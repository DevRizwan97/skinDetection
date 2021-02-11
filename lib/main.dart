import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/screens/Splash.dart';
import 'package:my_cities_time/screens/blog.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/screens/settings_screen.dart';
import 'package:my_cities_time/screens/signin.dart';
import 'package:my_cities_time/screens/signup.dart';
import 'package:my_cities_time/screens/the_skin_lab.dart';
import 'package:my_cities_time/states/appState.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/themes.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/utils/converters.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor().delegate = SimpleBlocDelegate();
  await Firebase.initializeApp();
  runApp(AppStateContainer(child: MyApp()));

}




class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
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
      theme: ThemeData(
        canvasColor: fontOrange
      ),
      debugShowCheckedModeBanner:false,
      home:SplashPage(),
    ));
  }
}

class AppStateContainer extends StatefulWidget {
  final Widget child;

  AppStateContainer({@required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
    as _InheritedStateContainer)
        .data;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
  ThemeData _theme = Themes.getTheme(Themes.DARK_THEME_CODE);
  int themeCode = Themes.DARK_THEME_CODE;
  TemperatureUnit temperatureUnit = TemperatureUnit.celsius;


  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      setState(() {
        themeCode = sharedPref.getInt(SHARED_PREF_KEY_THEME) ??
            Themes.DARK_THEME_CODE;
        temperatureUnit = TemperatureUnit.values[
        sharedPref.getInt(SHARED_PREF_KEY_TEMPERATURE_UNIT) ??
            TemperatureUnit.celsius.index];
        this._theme = Themes.getTheme(themeCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(theme.accentColor);
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  ThemeData get theme => _theme;

  updateTheme(int themeCode) {
    setState(() {
      _theme = Themes.getTheme(themeCode);
      this.themeCode = themeCode;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(SHARED_PREF_KEY_THEME, themeCode);
    });
  }

  updateTemperatureUnit(TemperatureUnit unit) {
    setState(() {
      this.temperatureUnit = unit;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(SHARED_PREF_KEY_TEMPERATURE_UNIT, unit.index);
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  const _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}

