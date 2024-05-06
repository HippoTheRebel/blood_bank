import 'package:blood_transfusion_register/donation_register_form_screen/donation_register_form_page/donation_register_form_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../database/my_database.dart';
import '../donation_register_update_screen/donation_register_form_update_home_page.dart';

class DRFormPage extends StatelessWidget {
  const DRFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are u sure want to quit'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press
        child: Material(
          child: FutureBuilder<AppDatabase>(
            builder: (context, data) {
              if (data.hasData) {
                Get.put(data.data!.ddRFormDatabaseDao);
                return DDRFUpdateHomePage(
                  isEdit: false,
                  dao: data.data!.ddRFormDatabaseDao,
                  table: null,
                );
              } else if (data.hasError) {
                return const Center(child: Text('Error'));
              } else {
                return const Center(child: Text('Loading'));
              }
            },
            future: $FloorAppDatabase.databaseBuilder('DDRFormTable.db').build(),
          ),
        ));
  }
}
