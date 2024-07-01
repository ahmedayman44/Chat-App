// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({super.key, required this.textButton, this.onTap});
  VoidCallback? onTap;
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20, bottom: 5),
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: Text(
            textButton,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            
          ),
        ),
      ),
    );
  }
}
