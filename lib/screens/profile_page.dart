import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_cities_time/page/camera.dart';
import 'package:my_cities_time/shared/widgets/focus_widget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';

import 'package:image_picker/image_picker.dart' as picker;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../themes.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  File _image;
  bool loader = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  var email, url1, name, studentId, phone, studentClass, section;
  Future<void> getUser() async {
    var state = Provider.of<AuthState>(context, listen: false);
    setState(() {
      emailController.text = state.userModel.email;
      nameController.text = state.userModel.username;
      print(url1);
    });
  }

  _imgFromCamera() async {
    File image =
        (await picker.ImagePicker.pickImage(source: picker.ImageSource.camera));

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = (await picker.ImagePicker.pickImage(
        source: picker.ImageSource.gallery, imageQuality: 50));

    setState(() {
      _image = image;
    });
  }

  openImagePicker(BuildContext context, Function onImageSelected) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 130,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Use Camera',
                          style: TextStyle(
                              color: Colors.white, fontFamily: "OpenSans"),
                        ),
                        onPressed: () {
                          _imgFromCamera();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Use Gallery',
                          style: TextStyle(
                              color: Colors.white, fontFamily: "OpenSans"),
                        ),
                        onPressed: () {
                          _imgFromGallery();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context);
    print(state.userModel.imageurl);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?Color(0xff3b3b3b): Colors.white,
          elevation: 0.0,

          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
              child: Icon(
            Icons.arrow_back,
            color: fontOrange,
          )),
        ),
        body: new Container(
          color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?Color(0xff3b3b3b): Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 230.0,
                    // color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: fontOrange, spreadRadius: 2)
                                      ],
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: state.userModel.imageurl != null
                                            ? new NetworkImage(
                                                state.userModel.imageurl)
                                            : new NetworkImage(
                                                "https://firebasestorage.googleapis.com/v0/b/learning-management-syst-1145b.appspot.com/o/DummyPicture%2Fas.png?alt=media&token=d21d753b-f24c-4e62-8f9f-464a7aa80279"),
                                        // _image==null?
                                        //
                                        // new NetworkImage( "https://firebasestorage.googleapis.com/v0/b/learning-management-syst-1145b.appspot.com/o/DummyPicture%2Fas.png?alt=media&token=d21d753b-f24c-4e62-8f9f-464a7aa80279" ,
                                        // ):

                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        openImagePicker(context, (file) {
                                          setState(() {
                                            _image = file;
                                          });
                                        });
                                      },
                                      child: new CircleAvatar(
                                        backgroundColor: cardColor,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: fontOrange,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?Color(0xff3b3b3b): Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 25.0,
                      ),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 0.0),
                              child: Container(
                                child: new Text(
                                  'Personal Information',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans",
                                    color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?white: Color(0xff3b3b3b),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 35.0,
                              ),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "OpenSans",
                                        color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?white: Color(0xff3b3b3b),),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      style: TextStyle(color:  AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?white: Color(0xff3b3b3b),),

                                      enabled: true,
                                      controller: nameController,
                                      decoration:  InputDecoration(
                                        enabledBorder:  UnderlineInputBorder(
                                          borderSide:  BorderSide(color:  AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?white: Color(0xff3b3b3b), width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 35.0,
                              ),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "OpenSans",
                                          color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?white: Color(0xff3b3b3b),),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      style: TextStyle(color:  AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?white: Color(0xff3b3b3b),),

                                      enabled: true,
                                      controller: emailController,
                                      decoration:  InputDecoration(
                                        enabledBorder:  UnderlineInputBorder(
                                          borderSide:  BorderSide(color:  AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?white: Color(0xff3b3b3b), width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 35,
                          ),
                          loader
                              ? SpinKitRipple(
                                  color: fontOrange,
                                  size: 40,
                                )
                              : RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      loader = true;
                                    });
                                    state
                                        .updateUserProfile(state.userModel,
                                            image: _image)
                                        .then((status) {
                                      setState(() {
                                        loader = false;
                                      });
                                    });

//https://firebasestorage.googleapis.com/v0/b/learning-management-syst-1145b.appspot.com/o/DummyPicture%2Fas.png?alt=media&token=d21d753b-f24c-4e62-8f9f-464a7aa80279
                                  },
                                  color: fontOrange,
                                  textColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0,
                                        bottom: 12.0,
                                        right: 40,
                                        left: 40),
                                    child: Text("Update Profile",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "OpenSans")),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
