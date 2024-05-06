import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/donation_register_form_screen/donation_register_form_saved_list_screen/donation_register_form_saved_list_page.dart';
import 'package:blood_transfusion_register/reusable_content/reusable_drawer/reusable_drawer.dart';
import 'package:blood_transfusion_register/reusable_content/reusable_home_card/reusable_home_card.dart';
import 'package:blood_transfusion_register/transfusion_transmitted_infection_register_form_screen/transfusion_transmitted_infection_register_saved_list_screen/transfusion_transmitted_infection_register_saved_list_page.dart';
import 'package:flutter/material.dart';

enum PageTypes {
  donationRegister,
  transfusion,
  bloodRequest,
  bloodIssue,
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          textAlign: TextAlign.center,
          style: kAppBarTextStyle,
        ),
      ),
      drawer: const ReusableDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: ReusableHomeCard(
                    homeCardText: "Donation Register Forms",
                    routePages: DDRFormSavedListPage(
                      pageType: PageTypes.donationRegister,
                    ),
                  ),
                ),
                // ReusableHomeCard(
                //   homeCardText: "Transfusion Transmitted Infection Forms",
                //   routePages: TTRFormSavedListPage(),
                // ),
                const Expanded(
                  child: ReusableHomeCard(
                    homeCardText: "Blood Request Forms",
                    routePages: DDRFormSavedListPage(
                      pageType: PageTypes.bloodRequest,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const ReusableHomeCard(
                homeCardText: "Blood Issue Forms",
                routePages: DDRFormSavedListPage(
                  pageType: PageTypes.bloodIssue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
