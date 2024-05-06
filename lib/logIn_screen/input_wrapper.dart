import 'package:blood_transfusion_register/apis/auth/auth_controller.dart';
import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/logIn_screen/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late final _myEmailController = TextEditingController();
late final _myPasswordController = TextEditingController();
bool _myEmailValidate = false;
bool _myPasswordValidate = false;

class InputWrapper extends ConsumerStatefulWidget {
  const InputWrapper({Key? key}) : super(key: key);

  @override
  ConsumerState<InputWrapper> createState() => _InputWrapperState();
}

class _InputWrapperState extends ConsumerState<InputWrapper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const LogInContainerWidget(),
          const SizedBox(
            height: 40,
          ),
          Hero(
            tag: "login_btn",
            child: buildLogInButton(),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildLogInButton() {
    return ElevatedButton(
      style: kLogInButtonStyle,
      onPressed: ref.watch(authControllerProvider).isLoading
          ? null
          : () {
              setState(
                () {
                  _myEmailController.text.isEmpty ? _myEmailValidate = true : _myEmailValidate = false;
                  _myPasswordController.text.isEmpty ? _myPasswordValidate = true : _myPasswordValidate = false;
                },
              );
              ref.read(authControllerProvider.notifier).login(email: _myEmailController.text, password: _myPasswordController.text);
              //_nextToHomePage(_myEmailController.text, _myPasswordController.text);
            },
      child: ref.watch(authControllerProvider).isLoading
          ? const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : Text(
              "LogIn".toUpperCase(),
              style: kLogInButtonTextStyle,
            ),
    );
  }

  _nextToHomePage(String myEmail, String myPassword) {
    if (myEmail.isNotEmpty && myPassword.isNotEmpty) {
      Navigator.pushNamed(context, kHomeRoutes);
    } else {
      print("Not Success");
    }
  }
}

class LogInContainerWidget extends StatelessWidget {
  const LogInContainerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ReusableTextField(
            labelForTextField: 'Enter Your Email',
            textEditingController: _myEmailController,
            errorText: "Email",
            textInputAction: TextInputAction.next,
            iconData: Icons.person,
            textInputType: TextInputType.emailAddress,
            validateText: _myEmailValidate,
          ),
          ReusableTextField(
            textInputAction: TextInputAction.done,
            iconData: Icons.lock,
            textInputType: TextInputType.visiblePassword,
            labelForTextField: 'Enter Your Password',
            textEditingController: _myPasswordController,
            errorText: "Password",
            validateText: _myPasswordValidate,
          ),
        ],
      ),
    );
  }
}
