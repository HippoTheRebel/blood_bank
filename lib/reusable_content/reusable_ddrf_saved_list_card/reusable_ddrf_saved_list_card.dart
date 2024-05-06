import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_table.dart';
import 'package:blood_transfusion_register/donation_register_form_screen/donation_register_update_screen/donation_register_form_update_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableDDRFSavedListCard extends StatelessWidget {
  final String? donorId;
  final String name;
  final Function onPressTrailing;
  final DDRFormTable? dDRFormTable;
  final void Function()? onEdit;
  final void Function()? ttiCallback;
  const ReusableDDRFSavedListCard({
    super.key,
    this.donorId,
    required this.name,
    required this.onPressTrailing,
    required this.dDRFormTable,
    required age,
    this.onEdit,
    this.ttiCallback,
  });

  // TextEditingController donorIdTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _CustomCard(
      donorId: donorId,
      name: name,
      onPressTrailing: onPressTrailing,
      dDRFormTable: dDRFormTable,
      onEdit: onEdit,
      ttiCallback: ttiCallback,
    );
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard({
    super.key,
    required this.donorId,
    required this.name,
    required this.onPressTrailing,
    required this.dDRFormTable,
    required this.onEdit,
    required this.ttiCallback,
  });
  final String? donorId;
  final String name;
  final Function onPressTrailing;
  final DDRFormTable? dDRFormTable;
  final void Function()? onEdit;
  final void Function()? ttiCallback;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Tooltip(
                message: 'Edit',
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black38,
                  ),
                  onPressed: () {
                    if (onEdit != null) {
                      onEdit!();
                    } else {
                      if (dDRFormTable != null) {}
                    }
                  },
                ),
              ),
              if (ttiCallback != null)
                Tooltip(
                  message: 'Transfusion Transmitted Infection',
                  child: IconButton(
                    icon: const Icon(
                      Icons.health_and_safety_outlined,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      ttiCallback!.call();
                    },
                  ),
                ),
              Expanded(
                child: ListTile(
                  title: Text(
                    name.toString(),
                  ),
                  subtitle: Text(
                    donorId.toString(),
                  ),
                  trailing: Tooltip(
                    message: 'Delete',
                    child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          onPressTrailing();
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Container(
//       margin: const EdgeInsets.all(8),
//       child: Card(
//         child: ListTile(
//           title: Text(
//             name.toString(),
//           ),
//           subtitle: Text(
//             donorId.toString(),
//           ),
//           trailing: IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () {
//                 onPressTrailing();
//               }),
//           leading: IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               if (onEdit != null) {
//                 onEdit!();
//               } else {
//                 if (dDRFormTable != null) {}
//               }
//             },
//           ),
//         ),
//       ),
//     )