import 'package:flutter/material.dart';

class MytextField extends StatelessWidget {
  MytextField(
      {super.key,
      required this.validator,
      required this.controllerName,
      this.obscureSign,
      this.hintTxt,
      required this.txtIcon,
      required this.keyboardType,
      required this.obscrure});

  final TextEditingController controllerName;
  final String? obscureSign;
  bool obscrure = false;
  final String? hintTxt;
  final Icon txtIcon;
  final TextInputType keyboardType;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white.withAlpha(19),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          autocorrect: true,
          obscureText: obscrure,
          obscuringCharacter: "*",
          controller: controllerName,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(11),
              suffixIcon: txtIcon,
              hintText: hintTxt,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
