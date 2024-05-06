import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/logIn_screen/input_wrapper.dart';
import 'package:blood_transfusion_register/logIn_screen/logIn_header.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: logInColors,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Header(),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )),
                child: const InputWrapper(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
