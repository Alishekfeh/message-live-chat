import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final bool password;
  final void Function(String) onChanged;
  final TextInputType keyboardType;
  const TextFieldWidget({
    Key? key, required this.hintText, required this.password, required this.onChanged, required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: password,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      decoration:  InputDecoration(

        hintText:hintText!,
        contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        border:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange,width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder:const  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
