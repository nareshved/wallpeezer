import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  const NewButton({super.key, required this.btnName, required this.onTap});

  final String btnName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7)),
        child: Center(
            child: Text(
          btnName,
          style: Theme.of(context).textTheme.bodyMedium,
        )),
      ),
    );
  }
}
