import 'package:flutter/material.dart';
import 'package:wallpeezer/repository/pages/login_page.dart';


import 'domain/app_constants/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wallpeezer',
      themeMode: ThemeMode.dark,
      theme: mLightTheme,
      darkTheme: mDarkTheme,
      home: LoginPage(),
    );
  }
}
