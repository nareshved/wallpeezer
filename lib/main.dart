import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_bloc.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wallpaper_bloc.dart';
import 'package:wallpeezer/data/firebase/firebase_provider.dart';
import 'package:wallpeezer/data/remote/api/api_helper.dart';
import 'package:wallpeezer/firebase_options.dart';
import 'package:wallpeezer/repository/pages/splash_page.dart';

import 'domain/app_constants/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => RegisterUserBloc(firebaseHelper: FirebaseHelper()),
    ),
    BlocProvider(create: (context) => WallpaperBloc(apiHelper: ApiHelper()),),
  ], child: const MyApp()));
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
      home: const SplashPage(),
    );
  }
}
