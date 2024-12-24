import 'package:flutter/material.dart';
import 'package:wallpeezer/domain/app_constants/app_info.dart';
import 'package:wallpeezer/domain/app_constants/app_taglines.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
