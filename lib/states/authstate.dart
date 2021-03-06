import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/api/http_exception.dart';
import 'package:my_cities_time/models/blogs.dart';
import 'package:my_cities_time/models/products.dart';
import 'package:my_cities_time/models/skin.dart';
import 'package:my_cities_time/models/user.dart';
import 'package:my_cities_time/models/weather.dart';
import 'package:my_cities_time/states/appState.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:path/path.dart' as Path;

import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart' as dabase;
import 'package:shared_preferences/shared_preferences.dart';

//Provider for auth
class AuthState extends AppState {
//Firebase Realtime Database Inilize
  final DatabaseReference kDatabase = FirebaseDatabase.instance.reference();

//Firebase User
  User user;

  // Use to authenticate firebase login and register
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Users get userModel => _userModel;
  Users _userModel;

  //To get all blogs
  List<Blog> _blogs = List<Blog>();

  List<Blog> get all_blogs {
    if (_blogs != null && _blogs.length > 0) {
      return _blogs;
    } else {
      return null;
    }
  }

//To extract excel data
  List<Map> _excel = List<Map>();

  List<Map> get all_excel_data {
    if (_excel != null && _excel.length > 0) {
      return _excel;
    } else {
      return null;
    }
  }

//To get all products
  List<Product> _products = List<Product>();

  List<Product> get all_products {
    if (_products != null && _products.length > 0) {
      return _products;
    } else {
      return null;
    }
  }

//To get all fav products
  List<Product> _favourites = List<Product>();

  List<Product> get all_favourites {
    if (_favourites != null && _favourites.length > 0) {
      return _favourites;
    } else {
      return _favourites;
    }
  }

//To get all user skin data
  List<Skin> _all_skin_data = List<Skin>();

  List<Skin> get all_skin_data {
    if (_all_skin_data != null && _all_skin_data.length > 0) {
      return _all_skin_data;
    } else {
      return null;
    }
  }

//To get all 3 cities data
  List<Weather> _top_three = List<Weather>();

  List<Weather> get top_three {
    if (_top_three != null && _top_three.length > 0) {
      return _top_three;
    } else {
      return null;
    }
  }

//Current skin
  Skin _skin;

  Skin get skin {
    return _skin;
  }

  //User firebase uId
  String userId;

  //User profile(name,email,photo)
  List<Users> _profileUserModelList;

  Users get profileUserModel {
    if (_profileUserModelList != null && _profileUserModelList.length > 0) {
      return _profileUserModelList.last;
    } else {
      return null;
    }
  }

//This will add the favourite product in user favs list
  void addfavourite(Product p) {
    _favourites.add(p);
    notifyListeners();
  }

  //This will remove the favourite product from user list
  void remotefavourite(int index) {
    _favourites.removeAt(index);
    notifyListeners();
  }

//This will add the new skin detected from camera in user all skin data
  void addskin(Skin skin) {
    _all_skin_data.add(skin);
    notifyListeners();
  }

//This will call data of current user login in the application
  Future<User> getCurrentUser() async {
    try {
      loading = true;
      user = await _firebaseAuth.currentUser;
      if (user != null) {
        userId = user.uid;
        getProfileUser();
        get_all_favourites();
      } else {
        loading = false;
      }
      return user;
    } catch (error) {
      loading = false;
      return null;
    }
  }

//This will return the latest skin detected from camera
  Future<Skin> getCurrentUserSkin() async {
    try {
      loading = true;
//I am using shared prefs to save location to get weather related to location
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String city = prefs.getString("location");
      user = await _firebaseAuth.currentUser;
      if (user != null) {
        userId = user.uid;
        getProfileUserSkin(userProfileId: userId, city: city);
      } else {}
      loading = false;
    } catch (error) {
      loading = false;
      return null;
    }
  }

//This function will return
  Future<List<Skin>> getallSkins() async {
    try {
      loading = true;
      user = await _firebaseAuth.currentUser;
      if (user != null) {
        userId = user.uid;
        //get the data of that person with uID
        getallUserSkin(userProfileId: userId);
      } else {}
      loading = false;
    } catch (error) {
      print(error);
      loading = false;
      return null;
    }
  }

//This function will return blogs from wordpress website
  Future<List<Blog>> getallBlogs() async {
    final url = 'http://xammin.pk/Suntastic/wp-json/wp/v2/posts/';

    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    Iterable l = json.decode(res.body);
    List<Blog> blogs = List<Blog>.from(l.map((model) => Blog.fromJson(model)));
    _blogs = blogs;
    //As in this api there are no picture so this loop will render in other link to access pictures
    for (int i = 0; i < blogs.length; i++) {
      final res = await http.get(blogs[i].imageurl);
      if (res.statusCode != 200) {
        throw HTTPException(res.statusCode, "unable to fetch weather data");
      }

      final imageDate = json.decode(res.body);
      blogs[i].imageurl = imageDate["guid"]["rendered"];
    }
    notifyListeners();
    return blogs;
  }

//This will fetch data from firebase of products
  Future<List<Product>> getallProducts() async {
    try {
      loading = true;
      //infinite loop and will break when the index will not present
      for (int i = 1; i > 0; i++) {
        try {
          //child named is "products"
          await kDatabase
              .child("products")
              .child(i.toString())
              .once()
              .then((DataSnapshot snapshot) {
            if (snapshot.value != null) {
              var map = snapshot.value;
              Product g = Product.fromJson(map);
              g.productId = snapshot.key;
              _products.add(g);
            } else {
              i = -1;
              loading = false;
            }
          });

          loading = false;
        } catch (e) {
          break;
        }
      }
    } catch (error) {
      loading = false;
    }
  }
//get profile data of user
  getProfileUser({String userProfileId}) {
    try {
      loading = true;
      if (_profileUserModelList == null) {
        _profileUserModelList = [];
      }

      userProfileId = userProfileId == null ? user.uid : userProfileId;
      kDatabase
          .child("profile")
          .child(userProfileId)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var map = snapshot.value;
          if (map != null) {
            _profileUserModelList.add(Users.fromJson(map));
            if (userProfileId == user.uid) {
              _userModel = _profileUserModelList.last;
             // This will call the function of getting skin data
              getCurrentUserSkin();
            }
          }
        }
        loading = false;
      });
    } catch (error) {
      //print error response
      print(error);
      loading = false;
    }
  }
//Function to extract excel file data
  fillexcel() async {
    ByteData data = await rootBundle.load("assets/skin_data/18_skin_types.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      int i = 0;
      for (var row in excel.tables[table].rows) {
        var details = new Map();
        if (i != 0) {
          details['skintype'] = row[0];
          details['uv'] = row[1];
          //"Checking whether 'safe' condition is matching or not?
          if (row[1] == 0 || row[1] == 1) {
            details['time'] = 'safe';
          } else {
            details['time'] = row[4] / row[3];
          }
          _excel.add(details);
        }
        i++;
      }
    }
  }

  getProfileUserSkin({String userProfileId, String city}) {
    try {
      loading = true;

      kDatabase
          .child("skin")
          .child(userProfileId)
          .child(city)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var map = snapshot.value;
          print(map);
          if (map != null) {
            map.values.forEach((k) => {
                  _skin = (Skin.fromJson1(k)),
                  loading = false,
                  notifyListeners(),
                });
          }
        } else {
          loading = false;
        }
      });
    } catch (error) {
      print(error);
      loading = false;
    }
  }
//Get user all favs product from dtabase
  get_all_favourites() {
    try {
      loading = true;
      kDatabase
          .child("favourites")
          .child(userId)
          .once()
          .then((DataSnapshot snapshot) {
        print((snapshot.value));
        if (snapshot.value != null) {
          var map = snapshot.value;
          if (map != null) {
            map.values.forEach((k) => {
                  _favourites.add(Product.fromJson(k)),
                  notifyListeners(),
                });
          }
          loading = false;
        }
      });
      loading = false;
    } catch (e) {
      loading = false;
      print(e);
    }
  }
//Calling api of weather to get weathedata of city
  void getWeatherData(String cityName) async {
    //As in this api the weather data is called from lat and long so we will use Geocoder lib to get lat and long of city
    var addresses = await Geocoder.local.findAddressesFromQuery(cityName);
    var first = addresses.first;

    final url =
        '${ApiKey.baseUrl}/data/2.5/onecall?lat=${first.coordinates.latitude}&lon=${first.coordinates.longitude}&appid=${ApiKey.OPEN_WEATHER_MAP}';

    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    _top_three.add(Weather.fromJsoncountry(weatherJson["current"], cityName));
    notifyListeners();
  }

  getallUserSkin({String userProfileId}) {
    try {
      loading = true;
      kDatabase
          .child("skin")
          .child(userProfileId)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var map = snapshot.value;
          if (map != null) {
            map.values.forEach((k) => {
                  k.values.forEach((k) => {
                        _all_skin_data.add(Skin.fromJson1(k)),
                        loading = false,
                        notifyListeners(),
                      })
                });
          }
        } else {
          loading = false;
        }
      });
    } catch (error) {
      print(error);
      loading = false;
    }
  }

  Future<String> signIn(String email, String password,
      {GlobalKey<ScaffoldState> scaffoldKey}) async {
    try {
      loading = true;
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      userId = user.uid;
      await getallUserSkin(userProfileId: userId);
      await getProfileUser(userProfileId: userId);
      return user.uid;
    } catch (error) {
      print(error);
      loading = false;

      // logoutCallback();
      return "There is no user record corresponding to this identifier. The user may have been deleted.";
    }
  }

  void logoutCallback() {
    userId = '';
    _userModel = null;
    user = null;
    _profileUserModelList = null;

    _firebaseAuth.signOut();

    notifyListeners();
  }

  /// Create user from `google login`
  /// If user is new then it create a new user
  /// If user is old then it just `authenticate` user and return firebase user data
  Future<User> handleGoogleSignIn() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      /// Record log in firebase kAnalytics about Google login
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google login cancelled by user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _firebaseAuth.signInWithCredential(credential)).user;

      userId = user.uid;
      //    createUserFromGoogleSignIn(user);
      notifyListeners();
      return user;
    } on PlatformException catch (error) {
      user = null;
      return null;
    } on Exception catch (error) {
      user = null;
      return null;
    } catch (error) {
      user = null;
      return null;
    }
  }

  // createUserFromGoogleSignIn(User user) {
  //   var diff = DateTime.now().difference(user.metadata.creationTime);
  //   // Check if user is new or old
  //   // If user is new then add new user to firebase realtime kDatabase
  //   if (diff < Duration(seconds: 15)) {
  //     Users model = Users(
  //         // bio: 'Edit profile to update bio',
  //         // dob: DateTime(1950, DateTime.now().month, DateTime.now().day + 3)
  //         //     .toString(),
  //         // location: 'Somewhere in universe',
  //         // profilePic: user.photoURL,
  //         // displayName: user.displayName,
  //         // email: user.email,
  //         // key: user.uid,
  //         // userId: user.uid,
  //         // contact: user.phoneNumber,
  //         // isVerified: user.emailVerified,
  //         );
  //     createUser(model, newUser: true);
  //   } else {}
  // }

  createUser(Users user, {bool newUser = false}) async {
    UserCredential firebaseuser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password);
    user.userId = firebaseuser.user.uid;
    await kDatabase.child('profile').child(user.userId).set(user.toJson());
    _userModel = user;

    loading = false;
  }

  createAnonymousUser(Users user, {bool newUser = false}) async {
    UserCredential firebaseuser =
        await FirebaseAuth.instance.signInAnonymously();
    user.userId = firebaseuser.user.uid;
    await kDatabase.child('profile').child(user.userId).set(user.toJson());
    _userModel = user;

    loading = false;
  }

  void changeuser(User user) {
    this.user = user;
    notifyListeners();
  }

  Future<void> updateUserProfile(Users userModel, {File image}) async {
    try {
      if (image == null) {
        await kDatabase
            .child('profile')
            .child(_userModel.userId)
            .set(_userModel.toJson());
        _userModel = userModel;
        notifyListeners();
      } else {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('user/profile/${Path.basename(image.path)}');

        UploadTask uploadTask = storageReference.putFile(image);
        await uploadTask.then((value) {
          storageReference.getDownloadURL().then((fileURL) async {
            print(fileURL);

            _userModel.imageurl = fileURL;
            await kDatabase
                .child('profile')
                .child(_userModel.userId)
                .set(_userModel.toJson());
            _userModel = userModel;
            notifyListeners();
          });
        });
      }
    } catch (error) {}
  }
}
