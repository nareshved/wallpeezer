import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_events.dart';
import 'package:wallpeezer/data/bloc/user_register/register_states.dart';
import 'package:wallpeezer/repository/pages/login_page.dart';

import '../../data/bloc/user_register/register_bloc.dart';
import '../../domain/app_constants/app_images.dart';
import '../../domain/app_constants/app_taglines.dart';
import '../../domain/models/register/user_model.dart';
import '../widgets/button/new_button.dart';
import '../widgets/textfield/mytext_field.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final mSignUpKey = GlobalKey<FormState>();

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
                  height: isPage.height * 0.6,
                  child: Form(
                    key: mSignUpKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Join Us",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              "Create account!",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            SizedBox(
                              height: isPage.height * 0.015,
                            ),
                            Text(
                              AppTaglines.signupNo1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        MytextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Name is required";
                            }
                            return null;
                          },
                          controllerName: nameController,
                          keyboardType: TextInputType.name,
                          txtIcon: const Icon(
                            Icons.person,
                            size: 18,
                          ),
                          obscrure: false,
                          hintTxt: "name",
                        ),
                        MytextField(
                          validator: (value) {
                            const pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                            final regExp = RegExp(pattern);

                            if (value!.isEmpty) {
                              return "Email can't be empty!";
                            } else if (!regExp.hasMatch(value)) {
                              return "Please enter a valid email!";
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
                            if (value!.length <= 7) {
                              return "Length should be greater than 7";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          txtIcon: const Icon(
                            Icons.lock,
                            size: 18,
                          ),
                          controllerName: passController,
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
                            Navigator.pop(
                                context,
                                // MaterialPageRoute(
                                //   builder: (context) => LoginPage(),
                                // )
                            );
                          }
                        }, builder: (context, state) {
                          return NewButton(
                            btnName: "SignUp",
                            onTap: () {
                              if (mSignUpKey.currentState!.validate()) {
                                String email = emailController.text.trim();
                                String password = passController.text.trim();
                                String name = nameController.text.trim();

                                if (emailController.text.isNotEmpty &&
                                    nameController.text.isNotEmpty &&
                                    passController.text.isNotEmpty) {
                                  var newUser = UserModel(
                                      // userId: FirebaseHelper.prefsKey,
                                      name: name,
                                      email: email,
                                      password: password);

                                  log("saved model signup : $newUser");

                                  // log("userId in signup page : ${FirebaseHelper.userId}");

                                  BlocProvider.of<RegisterUserBloc>(context)
                                      .add(CreateUserEvent(
                                          password: password,
                                          userModel: newUser));
                                }

                                // else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(
                                //           content:
                                //               Text("fill all required fields")));
                                // }

                                /// if
                              }
                            },
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ));
                                },
                                child: const Text(
                                  "LogIn",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
