import 'package:flutter/material.dart';

class SharedTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String text) validator;
  final Widget icon;
  final String label;
  final int maxLength;
  final bool obscureText;

  const SharedTextField({
    Key key,
    @required this.controller,
    this.validator,
    @required this.icon,
    @required this.label,
    this.maxLength,
    this.obscureText = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Color(0xff62626c)),
      child: TextFormField(
        controller: controller,
        cursorColor: Color(0xff62626c),
        autocorrect: false,
        autovalidateMode: AutovalidateMode.disabled,
        validator: validator,
        maxLength: maxLength,
        obscureText: this.obscureText,
        style: TextStyle(color: Colors.white),
        decoration: textFormInputDecoration(
          label: label,
          icon: icon,
        ),
      ),
    );
  }

  static InputDecoration textFormInputDecoration({String label, Widget icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Color(0xff62626c),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff62626c),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff62626c),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff62626c),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      suffixIcon: icon,
    );
  }
}
