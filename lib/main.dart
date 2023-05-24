import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:note_app/resources/app_localization.dart';
import 'package:note_app/resources/resources.dart';
import 'package:note_app/routes/app_routes.dart';
import 'package:note_app/services/hive_db.dart';
import 'package:note_app/src/base/view/base_view.dart';
import 'package:note_app/src/base/vm/base_vm.dart';
import 'package:note_app/utils/no_internet_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveDb.openHiveBox("db");

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: R.colors.transparent));

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => BaseVM()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale locale) {}

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _connectionStatus = "Unknown";
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      startConnectionStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetMaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          theme: ThemeData(
              primaryColor: R.colors.themeColor,
              textSelectionTheme: TextSelectionThemeData(
                  cursorColor: R.colors.themeColor,
                  selectionColor: R.colors.themeColor,
                  selectionHandleColor: R.colors.themeColor)),
          title: 'Note App',
          fallbackLocale: const Locale('en', 'US'),
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback:
              (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.pages,
          initialRoute: BaseView.route,
        ),
      );
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        {
          debugPrint(result.toString());
          debugPrint(_connectionStatus);
        }
        break;
      case ConnectivityResult.mobile:
        {
          debugPrint(result.toString());
        }
        break;
      case ConnectivityResult.none:
        {
          Get.snackbar(LocalizationMap.getValue("uh_oh"),
              LocalizationMap.getValue("no_internet_connection"));
          Get.to(() => const NoInternetScreen());
        }
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        break;
    }
  }

  void startConnectionStream() {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
}
