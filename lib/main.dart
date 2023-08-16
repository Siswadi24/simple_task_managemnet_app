import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:managemen_task_app/db/db_helper.dart';
import 'package:managemen_task_app/db/db_helper_signup.dart';
import 'package:managemen_task_app/service/theme_service.dart';
import 'package:managemen_task_app/ui/splash_screen.dart';

import 'common/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await DBHelperSignup.initDBSignUp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Task App',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: SplashScreen(),
    );
  }
}


//Menit 23:40 Part 3