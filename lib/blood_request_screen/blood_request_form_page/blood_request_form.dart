import 'package:blood_transfusion_register/apis/blood_data/blood_data_repository.dart';
import 'package:blood_transfusion_register/blood_request_screen/blood_request_form_page/blood_request_form_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BRFormPage extends ConsumerWidget {
  const BRFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are u sure want to quit'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
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
        child: ref.watch(getAppDatabaseProvider('BloodRequestTable.db')).when(
              data: (data) {
                return BRFormHomePage(
                  isEdit: false,
                  dao: data.bloodRequestFormDao,
                  table: null,
                );
              },
              error: (e, st) => Center(
                child: Text('$e'),
              ),
              loading: () => const Center(
                child: Text('Loading'),
              ),
            ),
      ),
    );
  }
}
