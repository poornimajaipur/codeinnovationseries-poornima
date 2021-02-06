import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
      leading: Image.asset(
        "assets/gif/engati-chat-icon-v2.gif",
      ),
      title: Text("ChatApp",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)));
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ));
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle mediumTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
