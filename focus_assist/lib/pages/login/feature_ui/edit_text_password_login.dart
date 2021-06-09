import 'package:flutter/material.dart';
import 'color.dart';
import 'edit_text.dart';


class edit_text_password_login extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const edit_text_password_login({
    Key key, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return edit_text(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: colorEditText,
          ),
          border:  InputBorder.none,
        ),
      ),
    );
  }
}
