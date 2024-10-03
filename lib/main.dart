import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:d7/ghjapp_theme.dart';
import 'package:d7/ghjdata_provider.dart';
import 'package:d7/ghjloading_page.dart';
import 'package:d7/ghjmain_page.dart';
import 'package:d7/ghjonboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
final GetIt getIt = GetIt.instance;

late AppsflyerSdk dncAppsflyerSdkCes;

Future<void> _cewHatOneSignalInitNetCew() async {
  await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  await OneSignal.Location.setShared(false);
  OneSignal.initialize('44700728-5d33-49fd-842c-010d16e0abba');
  await Future.delayed(const Duration(seconds: 1));
  OneSignal.Notifications.requestPermission(false);
}

Future<void> main() async{
     WidgetsFlutterBinding.ensureInitialized();
      await _cewHatOneSignalInitNetCew();
     await Firebase.initializeApp();
  SharedPreferences ghjprefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<ghjDataProvider>(ghjDataProvider
    (prefs: ghjprefs));
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

     runApp( MultiProvider(
       providers: [
         Provider<SharedPreferences>(
           create: ((context) => ghjprefs),
         ),
       ],
       child: const MyApp(),
     ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ghjappTheme,
      home: ghjLoadingPage(),
    );
  }
}

