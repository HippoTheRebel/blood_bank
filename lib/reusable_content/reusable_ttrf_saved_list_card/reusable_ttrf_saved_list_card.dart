import 'package:blood_transfusion_register/transfusion_transmitted_infection_register_form_screen/transfusion_trasmitted_infecion_register_update_screen/transfusion_transmitted_infection_register_form_update_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableTTRFSavedListCard extends StatelessWidget {
  final String? donorId;
  final String name;

  const ReusableTTRFSavedListCard(
      {super.key, this.donorId, required this.name});

  // TextEditingController donorIdTextController = TextEditingController();
  // TextEditingController nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Card(
        child: ListTile(
          title: Text(
            name.toString(),
          ),
          subtitle: Text(
            donorId.toString(),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
          leading: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.to(
                const TTRFUpdatePage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
