import 'package:d7/ghjapp_theme.dart';
import 'package:d7/ghjdata_provider.dart';
import 'package:d7/ghjloading_page.dart';
import 'package:d7/ghjmain_page.dart';
import 'package:d7/ghjonboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
final GetIt getIt = GetIt.instance;
Future<void> main() async{
     WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences ghjprefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<ghjDataProvider>(ghjDataProvider
    (prefs: ghjprefs));
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
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

