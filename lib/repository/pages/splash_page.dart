import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpeezer/data/firebase/firebase_provider.dart';
import 'package:wallpeezer/domain/app_constants/app_info.dart';
import 'package:wallpeezer/domain/app_constants/app_taglines.dart';
import 'package:wallpeezer/repository/pages/homepage.dart';
import 'package:wallpeezer/repository/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {

     var prefs = await SharedPreferences.getInstance();
    String? myKey =  prefs.getString(FirebaseHelper.prefsKey);

      Widget navigateTo = LoginPage();

      if(myKey != null && myKey !=""){
        navigateTo = const HomePage();
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => navigateTo,));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPage = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  AppInfo.appName,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: isPage.height * 0.015,
                ),
                Text(
                  AppTaglines.splashNo1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Container(
              height: 330,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(11),
              ),
              width: isPage.width * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.asset(
                  "assets/images/pxfuel.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const CircularProgressIndicator.adaptive(),
            Text(
              AppTaglines.splashNo2,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ));
  }
}
