// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hinText,
     this.obscureTextMode = false ,
    this.keyBoard,
    this.onChanged ,
  });
  final String hinText;
   bool? obscureTextMode;
  TextInputType? keyBoard;
  Function(String)? onChanged ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is requred' ; 
          } 
        },
        onChanged: onChanged,
        cursorColor: Colors.white,
        keyboardType: keyBoard,
        obscureText: obscureTextMode!,
        decoration: InputDecoration(
            hintText: hinText,
            hintStyle: const TextStyle(color: Colors.white),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.3,
              ),
            ),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
