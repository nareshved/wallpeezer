import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/user_register/register_bloc.dart';
import '../../data/bloc/user_register/register_events.dart';
import 'login_page.dart';

class SettingsWallpapersPage extends StatelessWidget {
  const SettingsWallpapersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 150,
                color: Colors.red,
              ),
            ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<RegisterUserBloc>(context)
                        .add(LogOutUserEvent());

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  icon: const Icon(Icons.login_outlined)),
              title: const Text("LogOut"),
            ),
          ],
        ),
      ),
    );
  }
}
