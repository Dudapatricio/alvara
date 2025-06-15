import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const MyTextButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: Text(text));
  }
}
