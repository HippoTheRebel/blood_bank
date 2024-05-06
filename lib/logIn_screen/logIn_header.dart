import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Log In",
              style: kLogInHeaderTextStyle,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text("Welcome to Blood Transfusion Registration", style: kLogInSecondTextStyle),
          )
        ],
      ),
    );
  }
}
