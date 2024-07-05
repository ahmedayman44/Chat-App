import 'package:flutter/material.dart';

import '../constan.dart';
import '../models/models.dart';

class CustomChatContainer extends StatelessWidget {
  const CustomChatContainer({
    super.key,
    required this.message,
  });

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, top: 25, right: 25, bottom: 25),
        margin: const EdgeInsets.all(11),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(33),
            topRight: Radius.circular(37),
            bottomRight: Radius.circular(37),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CustomChatContainerForFriend extends StatelessWidget {
  const CustomChatContainerForFriend({
    super.key,
    required this.message,
  });

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 25, right: 25, bottom: 25),
        margin: const EdgeInsets.all(11),
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(37),
            bottomLeft: Radius.circular(37),
            topRight: Radius.circular(37),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
