import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_cities_time/page/Splash.dart';
import 'package:my_cities_time/page/main_screens/blog.dart';
import 'package:my_cities_time/page/main_screens/location.dart';
import 'package:my_cities_time/page/main_screens/product_detail.dart';
import 'package:my_cities_time/page/main_screens/profile_page.dart';
import 'package:my_cities_time/page/main_screens/settings_screen.dart';
import 'package:my_cities_time/page/main_screens/shop_detail_page.dart';
import 'package:my_cities_time/page/main_screens/signin.dart';
import 'package:my_cities_time/page/main_screens/signup.dart';
import 'package:my_cities_time/page/main_screens/the_skin_lab.dart';
import 'package:my_cities_time/states/appState.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/themes.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/utils/converters.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
BehaviorSubject<String>();

const MethodChannel platform =
MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

String selectedNotificationPayload;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final NotificationAppLaunchDetails notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  GoogleMap.init('AIzaSyDW5wGY0Yr8JDsgitFCCFt96HUNnnRvagI');
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('tlogo');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  const MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectNotificationSubject.add(payload);
      });


  await AndroidAlarmManager.initialize();
  BlocSupervisor().delegate = SimpleBlocDelegate();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(AppStateContainer(child: MyApp()));
  });


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
        primaryColor: fontOrange,
        backgroundColor: fontOrange,
        canvasColor: fontOrange
      ),
      debugShowCheckedModeBanner:false,
      home:SplashPage(),
      //ShopDetailPage(),
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

