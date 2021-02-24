import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_cities_time/models/blogs.dart';
import 'package:my_cities_time/models/skin.dart';
import 'package:my_cities_time/models/user.dart';
import 'package:my_cities_time/states/appState.dart';
import 'package:path/path.dart' as Path;

import 'package:firebase_database/firebase_database.dart' as dabase;
import 'package:shared_preferences/shared_preferences.dart';

class AuthState extends AppState {

  final DatabaseReference kDatabase = FirebaseDatabase.instance.reference();

  User user;
 // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Users get userModel => _userModel;
  Users _userModel;
  List<Blog> _blogs=List<Blog>();
List<Skin> _all_skin_data=List<Skin>();
  Skin _skin;
  String userId;
  dabase.Query _profileQuery;
  List<Users> _profileUserModelList;
  Users get profileUserModel {
    if (_profileUserModelList != null && _profileUserModelList.length > 0) {
      return _profileUserModelList.last;
    } else {
      return null;
    }
  }
  List<Skin> get all_skin_data {
    if (_all_skin_data != null && _all_skin_data.length > 0) {
      return _all_skin_data;
    } else {
      return null;
    }
  }
  List<Blog> get all_blogs {
    if (_blogs != null && _blogs.length > 0) {
      return _blogs;
    } else {
      return null;
    }
  }
  Skin get skin{

    return _skin;
  }
  void addskin(Skin skin){

    _all_skin_data.add(skin);
    notifyListeners();
  }
  databaseInit() {
    try {
      if (_profileQuery == null) {
        _profileQuery = kDatabase.child("profile").child(user.uid);
        _profileQuery.onValue.listen(_onProfileChanged);
      }
    } catch (error) {
     // cprint(error, errorIn: 'databaseInit');
    }
  }
  Future<User> getCurrentUser() async {
    try {
      loading = true;
      user = await _firebaseAuth.currentUser;
      if (user != null) {
        userId = user.uid;
        getProfileUser();
      } else {

        loading = false;
      }
      return user;
    } catch (error) {
      loading = false;
//      cprint(error, errorIn: 'getCurrentUser');
//      authStatus = AuthStatus.NOT_LOGGED_IN;
      return null;
    }
  }

  Future<Skin> getCurrentUserSkin() async {
    try {
      loading = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String city=prefs.getString("location");
      user = await _firebaseAuth.currentUser;
      if (user != null) {
        userId = user.uid;
        getProfileUserSkin(userProfileId: userId,city: city);
      } else {
      }
      loading = false;
     // return user;
    } catch (error) {
      print(error);
      loading = false;
//      cprint(error, errorIn: 'getCurrentUser');
//      authStatus = AuthStatus.NOT_LOGGED_IN;
      return null;
    }
  }
  Future<List<Skin>> getallSkins() async {
    try {
      loading = true;

      user = await _firebaseAuth.currentUser;
      if (user != null) {
        userId = user.uid;
        getallUserSkin(userProfileId: userId);
      } else {
      }
      loading = false;
      // return user;
    } catch (error) {
      print(error);
      loading = false;
//      cprint(error, errorIn: 'getCurrentUser');
//      authStatus = AuthStatus.NOT_LOGGED_IN;
      return null;
    }
  }

  Future<List<Blog>> getallBlogs() async {
    try {
      loading = true;
      for(int i=1;i>0;i++) {
        try {
          print(i.toString());
       await kDatabase
              .child("blogs").child(i.toString())
              .once()
              .then((DataSnapshot snapshot) {
            if (snapshot.value != null) {
              var map = snapshot.value;
                Blog g=Blog.fromJson(map);
                g.userId=snapshot.key;
                _blogs.add(g);
            }
            else {
              i=-1;
              loading = false;
            }
          });

          loading = false;
        }catch(e){

          break;}
      }
    } catch (error) {

      print("afnan hassan");
      print(error);
      loading = false;
    }
  }
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
              getCurrentUserSkin();

            }
          }
        }
        loading = false;
      });
    } catch (error) {
      print("hassan");
      print(error);
      loading = false;
    }
  }
  getProfileUserSkin({String userProfileId,String city}) {
    try {
      loading = true;

      print(city);
      print(userProfileId);
      kDatabase
          .child("skin")
          .child(userProfileId).child(city)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var map = snapshot.value;
          print(map);
          if (map != null) {
            map.values.forEach((k) => {
            _skin=(Skin.fromJson1(k)),
              print(_skin.city),

        loading=false,
        notifyListeners(),


            });

          }

        }
        else {
          loading = false;
        }
      });
    } catch (error) {

      print("hassa1n");
      print(error);
      loading = false;
    }
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
            loading=false,
            notifyListeners(),


            })
            });

          }

        }
        else {
          loading = false;
        }
      });
    } catch (error) {

      print("afnan hassan");
      print(error);
      loading = false;
    }
  }
  void _onProfileChanged(Event event) {
    if (event.snapshot != null) {
      final updatedUser = Users.fromJson(event.snapshot.value);
      if(updatedUser.userId == user.uid){
        _userModel = updatedUser;
      }

      notifyListeners();
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
      loading = false;

      // logoutCallback();
      return null;
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
      createUserFromGoogleSignIn(user);
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
  createUserFromGoogleSignIn(User user) {
    var diff = DateTime.now().difference(user.metadata.creationTime);
    // Check if user is new or old
    // If user is new then add new user to firebase realtime kDatabase
    if (diff < Duration(seconds: 15)) {
      Users model = Users(
        // bio: 'Edit profile to update bio',
        // dob: DateTime(1950, DateTime.now().month, DateTime.now().day + 3)
        //     .toString(),
        // location: 'Somewhere in universe',
        // profilePic: user.photoURL,
        // displayName: user.displayName,
        // email: user.email,
        // key: user.uid,
        // userId: user.uid,
        // contact: user.phoneNumber,
        // isVerified: user.emailVerified,
      );
      createUser(model, newUser: true);
    } else {
    }
  }
  createUser(Users user, {bool newUser = false}) async {

    UserCredential firebaseuser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: user.email , password: user.password);
    user.userId=firebaseuser.user.uid;
  await kDatabase.child('profile').child(user.userId).set(
     user.toJson()
    );
    _userModel = user;


    loading = false;
  }

  createAnonymousUser(Users user, {bool newUser = false}) async {

    UserCredential firebaseuser = await FirebaseAuth.instance
        .signInAnonymously();
    user.userId=firebaseuser.user.uid;
    await kDatabase.child('profile').child(user.userId).set(
        user.toJson()
    );
    _userModel = user;


    loading = false;
  }
  void changeuser(User user){
    this.user=user;
    notifyListeners();

  }

  Future<void> updateUserProfile(Users userModel, {File image}) async {
    try {
      if (image == null) {
        await kDatabase.child('profile').child(_userModel.userId).set(
            _userModel.toJson()
        );
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
            await kDatabase.child('profile').child(_userModel.userId).set(
                _userModel.toJson()
            );
            _userModel = userModel;
            notifyListeners();

          });
        });
      }
    } catch (error) {
    }
  }
}