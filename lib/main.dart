import 'package:blood_transfusion_register/apis/auth/auth_repository.dart';
import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/form_screen/form_page.dart';
import 'package:blood_transfusion_register/logIn_screen/login_page.dart';
import 'package:blood_transfusion_register/setting_screen/setting_page.dart';
import 'package:blood_transfusion_register/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(Session.tokenKey);
  final container = ProviderContainer();

  container.read(emailProvider.notifier).state = prefs.getString(emailKey) ?? '';
  container.read(sIdProvider.notifier).state = prefs.getString(sidKey) ?? '';

  print('${container.read(emailProvider)} email');

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(
        hasToken: token != null,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.hasToken}) : super(key: key);
  final bool hasToken;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: hasToken ? kHomeRoutes : kLogInRoutes,
      routes: {
        kHomeRoutes: (context) => const MyHomePage(),
        kLogInRoutes: (context) => const LoginPage(),
        kFormRoutes: (context) => const FormPage(),
        kSettingRoutes: (context) => const SettingPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: kPrimaryColor,
        ),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: kThemeColor,
            ),
      ),
    );
  }
}
