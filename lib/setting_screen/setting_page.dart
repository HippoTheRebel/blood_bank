import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/reusable_content/reusable_drawer/reusable_drawer.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: const ReusableDrawer(),
    );
  }
}
