import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/NavigatorKey.dart';
import 'package:shop_app/helper/providers/CartProvider.dart';
import 'package:shop_app/helper/providers/ProductProvider.dart';
import 'package:shop_app/helper/providers/cat_provider.dart';
import 'package:shop_app/helper/providers/user_provider.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

import 'helper/LocalStorage/sp_helper.dart';
import 'helper/backendHelper/SQLHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPHelper.sp.initSP();
  await SQLHelper.helper.initDataBase();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: App()));
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
              home: Scaffold(
            body: Center(
              child: Text("error"),
            ),
          ));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>(
                create: (context) => UserProvider(),
              ),
              ChangeNotifierProvider<CatProvider>(
                create: (context) => CatProvider(),
              ),
              ChangeNotifierProvider<CartProvider>(
                create: (context) => CartProvider(),
              ),
              ChangeNotifierProvider<ProductProvider>(
                create: (context) => ProductProvider(),
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: theme(),
              // home: SplashScreen(),
              // We use routeName so that we dont need to remember the name
              initialRoute: SplashScreen.routeName,
              routes: routes,
              navigatorKey: NavigationService.navigationService.navigatorKey,
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
            home: Scaffold(
          body: Center(
            child: Text("loading"),
          ),
        ));
      },
    );
  }
}
