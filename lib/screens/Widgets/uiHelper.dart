import 'package:flutter/material.dart';

class UiHelper {
  static CustomTextField(TextEditingController controller, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      ),
    );
  }
}
