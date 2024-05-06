import 'package:blood_transfusion_register/database/transfusion_transmitted_infection_form_database/transfusion_transmitted_infection_dao.dart';
import 'package:blood_transfusion_register/reusable_content/reusable_ttrf_saved_list_card/reusable_ttrf_saved_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../database/my_database.dart';
import '../../database/transfusion_transmitted_infection_form_database/transfusion_transmitted_infection_table.dart';
import '../../reusable_content/reusable_ddrf_saved_list_card/reusable_ddrf_saved_list_card.dart';
import '../transfusion_transmitted_infection_register_form_page/transfusion_transmitted_infection_register_form_home_page.dart';

class TTRFormSavedListHomePage extends StatefulWidget {
  const TTRFormSavedListHomePage({Key? key}) : super(key: key);

  @override
  State<TTRFormSavedListHomePage> createState() => _TTRFormSavedListHomePageState();
}

class _TTRFormSavedListHomePageState extends State<TTRFormSavedListHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: db(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const FittedBox(
        fit: BoxFit.fitWidth,
        child: Text("Transfusion Transmitted Infection Forms"),
      ),
      backgroundColor: Colors.blueAccent[100],
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are u sure want to upload?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const DonationRegisterFormUpdateScreen(),
                      //   ),
                      // );
                    },
                    //return true when click on "Yes"
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.upload),
        ),
      ],
    );
  }
}

Widget db() {
  return Center(
    child: FutureBuilder<AppDatabase>(
      builder: (context, data) {
        if (data.hasData) {
          return dDRFSavedList(data.data!.transfustionTransmittedInfectionDao);
        } else if (data.hasError) {
          return const Text('Error');
        } else {
          return const Text('Loading');
        }
      },
      future: $FloorAppDatabase.databaseBuilder('TransfustionTransrmittedInfectionTable.db').build(),
    ),
  );
}

Widget dDRFSavedList(TransfustionTransmittedInfectionDao dao) {
  return StreamBuilder<List<TransfustionTransmittedInfectionTable>>(
    stream: dao.getAllDDRFormList(),
    builder: (_, snapShotData) {
      if (snapShotData.hasData) {
        if (snapShotData.data!.isEmpty) {
          return const Center(child: Text('No Data'));
        }
        return ListView.builder(
            itemCount: snapShotData.data?.length,
            itemBuilder: (_, position) {
              return ReusableDDRFSavedListCard(
                name: snapShotData.data![position].id.toString(),
                donorId: snapShotData.data![position].donorId.toString(),
                age: snapShotData.data![position].age,
                onPressTrailing: () {},
                dDRFormTable: null,
                onEdit: () {},
              );
            });
      } else if (snapShotData.hasError) {
        return const Center(
          child: (Text('Error')),
        );
      } else {
        return const Center(
          child: (Text('Loading')),
        );
      }
    },
  );
}
