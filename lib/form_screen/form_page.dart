import 'package:blood_transfusion_register/blood_issue_screen/blood_issued_page/blood_issued_form_page.dart';
import 'package:blood_transfusion_register/blood_request_screen/blood_request_form_page/blood_request_form.dart';
import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/donation_register_form_screen/donation_register_form_page/donation_register_form_page.dart';
import 'package:blood_transfusion_register/reusable_content/reusable_card/reusable_card.dart';
import 'package:blood_transfusion_register/reusable_content/reusable_drawer/reusable_drawer.dart';
import 'package:blood_transfusion_register/transfusion_transmitted_infection_register_form_screen/transfusion_transmitted_infection_register_form_page/transfusion_transmitted_infection_register_form.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forms",
          style: kAppBarTextStyle,
        ),
      ),
      drawer: const ReusableDrawer(),
      body: Center(
        child: ListView(
          children: const [
            ReusableListCard(
              cardText: 'Donor Register ',
              routePages: DRFormPage(),
            ),
            // ReusableListCard(
            //   cardText: 'Transfusion Transmitted Infection Register ',
            //   routePages: TTIRForm(),
            // ),
            ReusableListCard(
              cardText: 'Blood Request ',
              routePages: BRFormPage(),
            ),
            ReusableListCard(
              cardText: 'Blood Issued',
              routePages: BIFormPage(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Upload");
        },
        backgroundColor: kFormFloatingButtonColor,
        child: const Icon(Icons.upload),
      ),
    );
  }
}
