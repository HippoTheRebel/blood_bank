import 'package:blood_transfusion_register/apis/auth/auth_repository.dart';
import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/reusable_content/reusable_nav_list/reusable_nav_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReusableDrawer extends StatelessWidget {
  const ReusableDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer(builder: (context, ref, _) {
            return UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF74A9FF),
              ),
              accountName: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Text(ref.watch(emailProvider)),
              ),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  ref.watch(emailProvider).isEmpty ? '' : ref.watch(emailProvider)[0],
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
            );
          }),
          NavIconContent(FontAwesomeIcons.house, 'Home', () {
            _routeToHomePage(context);
          }),
          NavIconContent(FontAwesomeIcons.fileInvoice, 'Form ', () {
            _routeToFormPage(context);
          }),
          // NavIconContent(FontAwesomeIcons.gear, 'Setting ', () {
          //   _routeToSettingPage(context);
          // }),
        ],
      ),
    );
  }

  void _routeToFormPage(BuildContext context) {
    Navigator.pushNamed(context, kFormRoutes);
  }

  void _routeToHomePage(BuildContext context) {
    Navigator.pushNamed(context, kHomeRoutes);
  }

  void _routeToSettingPage(BuildContext context) {
    Navigator.pushNamed(context, kSettingRoutes);
  }
}
