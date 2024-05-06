import 'package:blood_transfusion_register/apis/blood_data/blood_data_repository.dart';
import 'package:blood_transfusion_register/donation_register_form_screen/donation_register_form_saved_list_screen/donation_register_form_saved_list_home_page.dart';
import 'package:blood_transfusion_register/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../database/my_database.dart';

class DDRFormSavedListPage extends StatelessWidget {
  const DDRFormSavedListPage({
    Key? key,
    required this.pageType,
  }) : super(key: key);
  final PageTypes pageType;
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

//
    return Material(
      child: () {
        if (pageType == PageTypes.donationRegister) {
          return WillPopScope(
            onWillPop: showExitPopup, //call function on back button press
            child: Consumer(
              builder: (_, ref, __) {
                return ref.watch(getAppDatabaseProvider('DDRFormTable.db')).when(
                    data: (data) {
                      return DDRFormSavedListHomePage(
                        pageType: pageType,
                        bloodRequestFormDao: null,
                        ddrFormDatabaseDao: data.ddRFormDatabaseDao,
                        bloodIssueFormDao: null,
                      );
                    },
                    error: (e, st) => Center(
                          child: Text('$e'),
                        ),
                    loading: () => Center(
                          child: Text('loading'),
                        ));
              },
            ),
          );
        }

        if (pageType == PageTypes.bloodRequest) {
          return WillPopScope(
              onWillPop: showExitPopup, //call function on back button press
              child: FutureBuilder<AppDatabase>(
                builder: (context, data) {
                  if (data.hasData) {
                    return DDRFormSavedListHomePage(
                      pageType: pageType,
                      bloodRequestFormDao: data.data!.bloodRequestFormDao,
                      ddrFormDatabaseDao: null,
                      bloodIssueFormDao: null,
                    );
                  } else if (data.hasError) {
                    return const Text('Error');
                  } else {
                    return const Text('Loading');
                  }
                },
                future: $FloorAppDatabase.databaseBuilder('BloodRequestTable.db').build(),
              ));
        }

        if (pageType == PageTypes.bloodIssue) {
          return WillPopScope(
              onWillPop: showExitPopup, //call function on back button press
              child: FutureBuilder<AppDatabase>(
                builder: (context, data) {
                  if (data.hasData) {
                    return DDRFormSavedListHomePage(
                      pageType: pageType,
                      bloodRequestFormDao: null,
                      ddrFormDatabaseDao: null,
                      bloodIssueFormDao: data.data!.bloodIssueFormDao,
                    );
                  } else if (data.hasError) {
                    return const Text('Error');
                  } else {
                    return const Text('Loading');
                  }
                },
                future: $FloorAppDatabase.databaseBuilder('BloodIssueFormTable.db').build(),
              ));
        }

        return const SizedBox.shrink();
      }(),
    );
  }
}
