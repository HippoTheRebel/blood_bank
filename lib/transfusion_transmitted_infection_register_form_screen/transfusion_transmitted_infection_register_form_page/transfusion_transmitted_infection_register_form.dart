import 'package:blood_transfusion_register/apis/blood_data/blood_data_repository.dart';
import 'package:blood_transfusion_register/transfusion_transmitted_infection_register_form_screen/transfusion_transmitted_infection_register_form_page/transfusion_transmitted_infection_register_form_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TTIRForm extends ConsumerWidget {
  const TTIRForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are u sure want to quit?'),
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

    // return WillPopScope(
    //   onWillPop: showExitPopup,
    //   child: Material(
    //     child: ref.watch(getAppDatabaseProvider('TransfustionTransrmittedInfectionTable.db')).when(
    //           data: (data) {
    //             return TTRFHomePage(
    //               isEditing: false,
    //               dao: data.transfustionTransmittedInfectionDao,
    //               table: null,
    //             );
    //           },
    //           error: (e, st) => Center(
    //             child: Text('$e'),
    //           ),
    //           loading: () => const Center(
    //             child: Text('Loading'),
    //           ),
    //         ),
    //   ),
    // );

    return const SizedBox.shrink();
  }
}
