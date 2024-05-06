import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField({
    super.key,
    required this.labelForTextField,
    required this.textEditingController,
    required this.errorText,
    required this.textInputType,
    required this.iconData,
    required this.textInputAction,
    this.validateText = false,
  });

  final String labelForTextField;
  final TextInputType textInputType;
  final IconData iconData;
  final TextInputAction textInputAction;
  final String errorText;
  final TextEditingController textEditingController;
  final bool validateText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TextField(
        cursorColor: kLoginTextFieldCursorColor,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        controller: textEditingController,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.zero,
              // padding: const EdgeInsets.all(kDefaultPadding),
              child: Icon(iconData),
            ),
            hintText: labelForTextField,
            errorText: validateText ? "$errorText Can/'t Be Empty" : null,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }
}
