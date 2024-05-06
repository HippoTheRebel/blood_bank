import 'package:blood_transfusion_register/database/transfusion_transmitted_infection_form_database/transfusion_transmitted_infection_dao.dart';
import 'package:blood_transfusion_register/database/transfusion_transmitted_infection_form_database/transfusion_transmitted_infection_table.dart';
import 'package:blood_transfusion_register/form_screen/form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../apis/blood_data/blood_data_repository.dart';
import '../../constants/constants.dart';
import '../../database/donation_register_form_database/donation_register_form_dao.dart';
import '../../database/donation_register_form_database/donation_register_form_table.dart';

class TTRFHomePage extends StatefulWidget {
  const TTRFHomePage({
    Key? key,
    required this.isEditing,
    required this.dao,
    required this.table,
  }) : super(key: key);
  final bool isEditing;
  final DDRFormDatabaseDao dao;
  final DDRFormTable table;
  @override
  State<TTRFHomePage> createState() => _TTRFHomePageState();
}

enum HIVActiveStatus {
  yes,
  no,
}

enum HBsAgStatus {
  yes,
  no,
}

enum AntiHCVStatus {
  yes,
  no,
}

enum MalariaAgStatus {
  yes,
  no,
}

enum SyphillsStatus {
  yes,
  no,
}

List<DropdownMenuItem<String>> get dropdownSexItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Male", child: Text("Male")),
    const DropdownMenuItem(value: "Female", child: Text("Female")),
  ];
  return menuItems;
}

class _TTRFHomePageState extends State<TTRFHomePage> {
  HIVActiveStatus? _hivStatus = HIVActiveStatus.no;

  HBsAgStatus? _hBsAgStatus = HBsAgStatus.no;

  AntiHCVStatus? _antiHCVStatus = AntiHCVStatus.no;

  MalariaAgStatus? _malariaAgStatus = MalariaAgStatus.no;

  SyphillsStatus? _syphillsStatus = SyphillsStatus.no;
  final dateScreeningController = TextEditingController();
  final dateDontaionController = TextEditingController();
  final donorIdController = TextEditingController();
  final ageController = TextEditingController();
  final testedAndCheckedByController = TextEditingController();
  int? id;
  @override
  void initState() {
    if (widget.isEditing) {
      final data = widget.table;
      id = data.donorId;
      dateDontaionController.text = data.dateOfDonation ?? '';
      dateScreeningController.text = data.dateOfScreening ?? '';
      testedAndCheckedByController.text = data.testedAndCheckedBy ?? '';
      selectedValueForSex = data.sex;
      _hivStatus = (data.hiv?.contains('no') ?? true) ? HIVActiveStatus.no : HIVActiveStatus.yes;
      _hBsAgStatus = (data.hbs?.contains('no') ?? true) ? HBsAgStatus.no : HBsAgStatus.yes;
      _antiHCVStatus = (data.antiHcv?.contains('no') ?? true) ? AntiHCVStatus.no : AntiHCVStatus.yes;
      _malariaAgStatus = (data.malariaAg?.contains('no') ?? true) ? MalariaAgStatus.no : MalariaAgStatus.yes;
      _syphillsStatus = (data.syphills?.contains('no') ?? true) ? SyphillsStatus.no : SyphillsStatus.yes;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: buildHIV(),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: buildHBsAg(),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: buildAntiHCV(),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: buildMalariaAg(),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: buildSyphills(),
            ),
            buildTTRFDonationDatePicker(),
            buildTTRFScreeningDatePicker(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: testedAndCheckedByController,
                decoration: const InputDecoration(hintText: "Tested and Checked By"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField buildTTRFDonationDatePicker() {
    return TextField(
      controller: dateScreeningController, //editing controller of this TextField
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Date of Screening" //label text of field
          ),
      readOnly: true, // when true user cannot edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          print(pickedDate);
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate);

          setState(() {
            dateScreeningController.text = formattedDate;
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  TextField buildTTRFScreeningDatePicker() {
    return TextField(
      controller: dateDontaionController, //editing controller of this TextField
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Date of Donation" //label text of field
          ),
      readOnly: true, // when true user cannot edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          //get today's date
          firstDate: DateTime(2000),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          print(pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
          print(formattedDate); //formatted date output using intl package =>  2022-07-04
          //You can format date as per your need

          setState(() {
            dateDontaionController.text = formattedDate; //set foratted date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  Row buildHIV() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Flexible(
          child: Text(
            " HIV 1/2 ",
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(
          width: 11,
        ),
        Flexible(
          child: RadioListTile<HIVActiveStatus>(
            title: const Text(
              'Reactive',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            value: HIVActiveStatus.yes,
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _hivStatus,
            onChanged: (HIVActiveStatus? value) {
              setState(
                () {
                  _hivStatus = value;
                  if (_hivStatus == HIVActiveStatus.yes) {
                    print("$value");
                    kIsVisible = true;
                  }
                },
              );
            },
          ),
        ),
        Flexible(
          child: RadioListTile<HIVActiveStatus>(
            contentPadding: EdgeInsets.zero,
            value: HIVActiveStatus.no,
            title: const Text(
              "Non-reactive",
              softWrap: false,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _hivStatus,
            onChanged: (HIVActiveStatus? value) {
              setState(
                () {
                  _hivStatus = value;
                  print("$value");
                  kIsVisible = false;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Row buildHBsAg() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Flexible(
          child: Text(
            " HBsAg ",
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(
          width: 11,
        ),
        Flexible(
          child: RadioListTile<HBsAgStatus>(
            title: const Text(
              'Positive',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            value: HBsAgStatus.yes,
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _hBsAgStatus,
            onChanged: (HBsAgStatus? value) {
              setState(
                () {
                  _hBsAgStatus = value;
                  if (_hBsAgStatus == HBsAgStatus.yes) {
                    print("$value");
                    kIsVisible = true;
                  }
                },
              );
            },
          ),
        ),
        Flexible(
          child: RadioListTile<HBsAgStatus>(
            contentPadding: EdgeInsets.zero,
            value: HBsAgStatus.no,
            title: const Text(
              "Negative",
              softWrap: false,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _hBsAgStatus,
            onChanged: (HBsAgStatus? value) {
              setState(
                () {
                  _hBsAgStatus = value;
                  print("$value");
                  kIsVisible = false;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Row buildAntiHCV() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Flexible(
          child: Text(
            " Anti-HCV ",
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: RadioListTile<AntiHCVStatus>(
            title: const Text(
              'Positive',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            value: AntiHCVStatus.yes,
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _antiHCVStatus,
            onChanged: (AntiHCVStatus? value) {
              setState(
                () {
                  _antiHCVStatus = value;
                  if (_antiHCVStatus == AntiHCVStatus.yes) {
                    print("$value");
                    kIsVisible = true;
                  }
                },
              );
            },
          ),
        ),
        Flexible(
          child: RadioListTile<AntiHCVStatus>(
            contentPadding: EdgeInsets.zero,
            value: AntiHCVStatus.no,
            title: const Text(
              "Negative",
              softWrap: false,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _antiHCVStatus,
            onChanged: (AntiHCVStatus? value) {
              setState(
                () {
                  _antiHCVStatus = value;
                  print("$value");
                  kIsVisible = false;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Row buildMalariaAg() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Flexible(
          child: Text(
            " Malaria Ag ",
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(
          width: 0,
        ),
        Flexible(
          child: RadioListTile<MalariaAgStatus>(
            title: const Text(
              'Positive',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            value: MalariaAgStatus.yes,
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _malariaAgStatus,
            onChanged: (MalariaAgStatus? value) {
              setState(
                () {
                  _malariaAgStatus = value;
                  if (_malariaAgStatus == MalariaAgStatus.yes) {
                    print("$value");
                    kIsVisible = true;
                  }
                },
              );
            },
          ),
        ),
        Flexible(
          child: RadioListTile<MalariaAgStatus>(
            contentPadding: EdgeInsets.zero,
            value: MalariaAgStatus.no,
            title: const Text(
              "Negative",
              softWrap: false,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _malariaAgStatus,
            onChanged: (MalariaAgStatus? value) {
              setState(
                () {
                  _malariaAgStatus = value;
                  print("$value");
                  kIsVisible = false;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Row buildSyphills() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Flexible(
          child: Text(
            " Syphills ",
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: RadioListTile<SyphillsStatus>(
            title: const Text(
              'Reactive',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            value: SyphillsStatus.yes,
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _syphillsStatus,
            onChanged: (SyphillsStatus? value) {
              setState(
                () {
                  _syphillsStatus = value;
                  if (_syphillsStatus == SyphillsStatus.yes) {
                    print("$value");
                    kIsVisible = true;
                  }
                },
              );
            },
          ),
        ),
        Flexible(
          child: RadioListTile<SyphillsStatus>(
            contentPadding: EdgeInsets.zero,
            value: SyphillsStatus.no,
            title: const Text(
              "Non-reactive",
              softWrap: false,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            activeColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
            groupValue: _syphillsStatus,
            onChanged: (SyphillsStatus? value) {
              setState(
                () {
                  _syphillsStatus = value;
                  print("$value");
                  kIsVisible = false;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(" Transfusion Transmitted Infection Forms"),
      ),
      backgroundColor: Colors.blueAccent[100],
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are u sure want to save?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  Consumer(builder: (context, ref, _) {
                    return ElevatedButton(
                      onPressed: () async {
                        await widget.dao.updateNote(
                          DDRFormTable(
                            rhdFactor: widget.table.rhdFactor,
                            objectId: widget.table.objectId,
                            donorId: widget.table.donorId,
                            name: widget.table.name,
                            age: widget.table.age,
                            fatherName: widget.table.fatherName,
                            motherName: widget.table.motherName,
                            sex: widget.table.sex,
                            sbp: widget.table.sbp,
                            dbp: widget.table.dbp,
                            maleHemoglobin: widget.table.maleHemoglobin,
                            femaleHemoglobin: widget.table.femaleHemoglobin,
                            previousDonation: widget.table.previousDonation,
                            donatedTime: widget.table.donatedTime,
                            representativeName: widget.table.representativeName,
                            info: widget.table.info,
                            bloodGroup: widget.table.bloodGroup,
                            hiv: _hivStatus.toString(),
                            hbs: _hBsAgStatus.toString(),
                            antiHcv: _antiHCVStatus.toString(),
                            malariaAg: _malariaAgStatus.toString(),
                            syphills: _syphillsStatus.toString(),
                            dateOfScreening: dateScreeningController.text,
                            dateOfDonation: dateDontaionController.text,
                            testedAndCheckedBy: testedAndCheckedByController.text,
                            addedtti: true,
                            lastDateOfDonation: widget.table.lastDateOfDonation,
                          ),
                        );
                        ref.invalidate(getAppDatabaseProvider);
                        if (mounted) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Yes'),
                    );
                  }),
                ],
              ),
            );
          },
          icon: const Icon(Icons.add_box),
        ),
      ],
    );
  }

  Row buildSexDropDownButton() {
    return Row(
      children: [
        const Text("Sex"),
        const SizedBox(
          width: 220,
        ),
        DropdownButton(
          items: dropdownSexItems,
          value: selectedValueForTTRFSex,
          onChanged: (String? newValue) {
            setState(
              () {
                selectedValueForTTRFSex = newValue!;
                print("$selectedValueForTTRFSex");
              },
            );
          },
        ),
      ],
    );
  }
}
