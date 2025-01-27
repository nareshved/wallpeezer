import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_events.dart';
import 'package:wallpeezer/repository/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("homepage"),
      ),
      body: Center(child:
      TextButton(onPressed: ()async{
        BlocProvider.of<RegisterUserBloc>(context).add(LogOutUserEvent());
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }, child: const Text("LogOut me", style: TextStyle(fontSize: 42),))
      ),
    );
  }
}
