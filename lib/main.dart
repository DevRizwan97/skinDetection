import 'package:flutter/material.dart';
import 'package:my_cities_time/screens/blog.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/screens/signup.dart';
import 'package:my_cities_time/states/appState.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
    ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner:false,
      home: SignUp(),
    ));
  }
}

