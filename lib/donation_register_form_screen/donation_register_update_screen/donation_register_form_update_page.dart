import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_table.dart';
import 'package:blood_transfusion_register/database/my_database.dart';
import 'package:blood_transfusion_register/donation_register_form_screen/donation_register_update_screen/donation_register_form_update_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DDRFormUpdatePage extends StatelessWidget {
  const DDRFormUpdatePage({Key? key, required this.table}) : super(key: key);
  final DDRFormTable table;
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
        child: FutureBuilder<AppDatabase>(
          builder: (context, data) {
            if (data.hasData) {
              Get.put(data.data!.ddRFormDatabaseDao);
              return DDRFUpdateHomePage(
                isEdit: true,
                dao: data.data!.ddRFormDatabaseDao,
                table: table,
              );
            } else if (data.hasError) {
              return const Scaffold(
                body: Text('Error'),
              );
            } else {
              return const Scaffold(
                body: Text('Loading'),
              );
            }
          },
          future: $FloorAppDatabase.databaseBuilder('DDRFormTable.db').build(),
        ));
  }
}
