import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.photo});
  final String photo;

  @override
  Widget build(BuildContext context) {
    final isPage = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: isPage.width,
          height: isPage.height,
          child: Image.network(photo, fit: BoxFit.fitWidth,)),
    );
  }
}
