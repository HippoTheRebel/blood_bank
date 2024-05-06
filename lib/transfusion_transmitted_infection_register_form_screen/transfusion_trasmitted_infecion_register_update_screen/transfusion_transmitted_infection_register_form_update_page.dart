import 'package:blood_transfusion_register/transfusion_transmitted_infection_register_form_screen/transfusion_trasmitted_infecion_register_update_screen/transfusion_transmitted_infection_register_form_update_home_page.dart';
import 'package:flutter/material.dart';

class TTRFUpdatePage extends StatelessWidget {
  const TTRFUpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
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
        child: const TTRFormUpdateHomePage());
  }
}
