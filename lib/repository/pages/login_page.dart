import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_events.dart';
import 'package:wallpeezer/data/bloc/user_register/register_states.dart';
import 'package:wallpeezer/domain/app_constants/app_images.dart';
import 'package:wallpeezer/domain/app_constants/app_taglines.dart';
import 'package:wallpeezer/repository/pages/homepage.dart';
import 'package:wallpeezer/repository/pages/signup_page.dart';
import 'package:wallpeezer/repository/widgets/button/new_button.dart';

import '../widgets/textfield/mytext_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final mFormKey = GlobalKey<FormState>();

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
                width: isPage.width * 0.8,
                height: isPage.height * 0.5,
                child: Form(
                  key: mFormKey,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter email is required";
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        txtIcon: const Icon(
                          Icons.lock,
                          size: 18,
                        ),
                        controllerName: passwordController,
                        obscrure: true,
                        hintTxt: "password",
                      ),
                      BlocConsumer<RegisterUserBloc, RegisterUserStates>(
                        listener: (context, state) {
                          if (state is UserErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMsg)));
                          }

                          if (state is UserLoadedState) {
                            // show loading before login when bloc try catch fetch auth fun call in firebase provider
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                          }

                          if (state is UserLoadingState) {
                            NewButton(
                              btnWidget: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                              btnName: "",
                              onTap: () {},
                            );
                          }

                          // if (state is UserLoadedState) {
                          //   Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => const HomePage(),
                          //       ));
                          // }
                        },
                        builder: (context, state) {
                          return NewButton(
                            btnName: "LogIn",
                            onTap: () {
                              if (mFormKey.currentState!.validate()) {
                                String email = emailController.text.toString();
                                String password =
                                    passwordController.text.toString();

                                if (email.isNotEmpty && password.isNotEmpty) {
                                  BlocProvider.of<RegisterUserBloc>(context)
                                      .add(LoginUserEvent(
                                          userEmail: email,
                                          userPassword: password));
                                }
                              }
                            },
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupPage(),
                                    ));
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      )
                    ],
                  ),
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
