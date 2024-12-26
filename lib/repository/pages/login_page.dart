import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallpeezer/domain/app_constants/app_images.dart';
import 'package:wallpeezer/domain/app_constants/app_taglines.dart';
import 'package:wallpeezer/repository/pages/homepage.dart';
import 'package:wallpeezer/repository/widgets/login/button/new_button.dart';

import '../widgets/login/textfield/mytext_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isPage = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.asset(
            AppImages.loginImg,
            width: isPage.width,
            height: isPage.height,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 19, sigmaY: 19),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white.withAlpha(19),
                ),
                width: isPage.width * 0.7,
                height: isPage.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Hi There",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          AppTaglines.loginNo1,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    MytextField(
                      controllerName: emailController,
                      keyboardType: TextInputType.emailAddress,
                      txtIcon: const Icon(
                        Icons.mail,
                        size: 18,
                      ),
                      obscrure: false,
                      hintTxt: "email",
                    ),
                    MytextField(
                      keyboardType: TextInputType.visiblePassword,
                      txtIcon: const Icon(
                        Icons.lock,
                        size: 18,
                      ),
                      controllerName: passwordController,
                      obscrure: true,
                      hintTxt: "password",
                    ),
                    NewButton(
                      btnName: "LogIn", 
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

// body: Container(
//         decoration: const BoxDecoration(
//             image: DecorationImage(image: AssetImage(AppImages.loginImg))),
//       ),
