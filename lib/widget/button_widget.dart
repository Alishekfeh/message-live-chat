import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color color;
  final void Function() onPressed;

  const ButtonWidget({
    Key? key,
    required this.title,
    required this.onPressed, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        color: color,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 40,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
