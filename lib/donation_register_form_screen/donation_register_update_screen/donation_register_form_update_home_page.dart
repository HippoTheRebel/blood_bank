import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_dao.dart';
import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_table.dart';
import 'package:blood_transfusion_register/donation_register_form_screen/donation_register_form_saved_list_screen/donation_register_form_saved_list_page.dart';
import 'package:blood_transfusion_register/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:objectid/objectid.dart';

import '../../apis/blood_data/blood_data_repository.dart';
import '../../transfusion_transmitted_infection_register_form_screen/transfusion_transmitted_infection_register_form_page/transfusion_transmitted_infection_register_form_home_page.dart';

class DDRFUpdateHomePage extends StatefulWidget {
  const DDRFUpdateHomePage({Key? key, required this.isEdit, required this.table, required this.dao}) : super(key: key);
  final bool isEdit;
  final DDRFormTable? table;
  final DDRFormDatabaseDao dao;
  @override
  State<DDRFUpdateHomePage> createState() => _DDRFUpdateHomePageState();
}

enum PBDStatus {
  yes,
  no,
}

class _DDRFUpdateHomePageState extends State<DDRFUpdateHomePage> {
  PBDStatus _pbdStatus = PBDStatus.no;
  String? selectedValueForSex;
  String? selectedValueForPatientBloodGroup;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
    ];
    return menuItems;
  }

  String objectId = '';

  final TextEditingController donorIdTEC = TextEditingController();
  final TextEditingController nameTEC = TextEditingController();
  final ageTEC = TextEditingController();
  final fatherNameTEC = TextEditingController();
  final representativeNameTEC = TextEditingController();
  final infoTEC = TextEditingController();
  final locationTEC = TextEditingController();
  final hemoglobinController = TextEditingController();
  final dateController = TextEditingController();
  String? rhdFactor;
  List<DropdownMenuItem<String>> get dropdownPatientBloodGroupItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "A", child: Text("A")),
      const DropdownMenuItem(value: "B", child: Text("B")),
      const DropdownMenuItem(value: "AB", child: Text("AB")),
      const DropdownMenuItem(value: "O", child: Text("O")),
    ];
    return menuItems;
  }

  @override
  void initState() {
    if (widget.isEdit) {
      print('is edit');
      final ddrFormTable = widget.table!;
      nameTEC.text = ddrFormTable.name ?? '';
      donorIdTEC.text = ddrFormTable.donorId.toString();
      ageTEC.text = (ddrFormTable.age ?? '').toString();
      fatherNameTEC.text = ddrFormTable.fatherName ?? '';

      selectedValueForSex = ddrFormTable.sex;
      kCurrentValueForSBP = ddrFormTable.sbp ?? kCurrentValueForSBP;
      kCurrentValueForDBP = ddrFormTable.dbp ?? kCurrentValueForDBP;
      kCurrentValueForMaleHemoglobin = (ddrFormTable.maleHemoglobin ?? kCurrentValueForMaleHemoglobin).toInt();
      kCurrentValueForFemaleHemoglobin = (ddrFormTable.femaleHemoglobin ?? kCurrentValueForFemaleHemoglobin).toInt();
      print('previous -> ${ddrFormTable.previousDonation}');
      print('check -> ${ddrFormTable.previousDonation == 'PBDStatus.yes'}');
      _pbdStatus = (ddrFormTable.previousDonation == 'PBDStatus.yes') ? PBDStatus.yes : PBDStatus.no;
      kCurrentTimesOfBloodDonation = ddrFormTable.donatedTime ?? 0;
      representativeNameTEC.text = ddrFormTable.representativeName ?? '';
      selectedValueForPatientBloodGroup = ddrFormTable.bloodGroup;
      infoTEC.text = ddrFormTable.info ?? '';
      locationTEC.text = ddrFormTable.location ?? '';
      objectId = ddrFormTable.objectId ?? '';
      rhdFactor = ddrFormTable.rhdFactor;
      hemoglobinController.text = (ddrFormTable.maleHemoglobin ?? '').toString();
      dateController.text = ddrFormTable.lastDateOfDonation ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildSingleChildScrollView(),
    );
  }

  SingleChildScrollView buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildColumnForDRF(),
      ),
    );
  }

  Column buildColumnForDRF() {
    return Column(
      children: [
        // TextField(
        //   enabled: false,
        //   controller: donorIdTEC,
        //   keyboardType: const TextInputType.numberWithOptions(),
        //   decoration: InputDecoration(
        //     fillColor: Colors.grey.shade400,
        //     filled: true,
        //     labelText: "Donor ID",
        //     border: const OutlineInputBorder(),
        //   ),
        // ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: nameTEC,
          decoration: const InputDecoration(
            isDense: true,
            labelText: "Name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: ageTEC,
          keyboardType: const TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            isDense: true,
            labelText: "Age",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: fatherNameTEC,
          decoration: const InputDecoration(
            isDense: true,
            labelText: "Father Name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildDropDownButton(),
        const SizedBox(
          height: 20,
        ),
        buildPatientBloodGroupDropDownButton(),
        const SizedBox(
          height: 20,
        ),
        buildRhdDropDownButton(),
        const SizedBox(
          height: 20,
        ),
        buildSBloodPressure(),
        const SizedBox(
          height: 20,
        ),
        buildDBloodPressure(),
        const SizedBox(
          height: 20,
        ),
        buildMaleHemoglobin(),
        const SizedBox(
          height: 20,
        ),
        // buildFemaleHemoglobin(),
        // const SizedBox(
        //   height: 8,
        // ),
        buildPreviousBloodDonation(),
        const SizedBox(
          height: 8,
        ),
        buildTimesOfBloodDonation(),
        const SizedBox(
          height: 20,
        ),
        buildDatePicker(),
        const SizedBox(
          height: 20,
        ),
        // Center(
        //   child: TextField(
        //     controller: infoTEC,
        //     decoration: const InputDecoration(
        //       isDense: true,
        //       labelText: "Reasons for Transfusion",
        //       border: OutlineInputBorder(),
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        Center(
          child: TextField(
            controller: locationTEC,
            decoration: const InputDecoration(
              isDense: true,
              labelText: "HLF No.",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            "Checked By Medical Representatives",
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: TextField(
            controller: representativeNameTEC,
            decoration: const InputDecoration(
              isDense: true,
              labelText: "Representatives Name",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTimesOfBloodDonation() {
    return Row(
      children: [
        const Text(
          "Times of Blood Donation",
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),

        NumberPicker(
          selectedTextStyle: TextStyle(color: Colors.blueAccent.shade100, fontSize: 24),
          minValue: 0,
          itemCount: 1,
          itemHeight: 30,
          maxValue: 60,
          haptics: true,
          value: kCurrentTimesOfBloodDonation,
          onChanged: (value) => setState(
            () {
              kCurrentTimesOfBloodDonation = value;
            },
          ),
        ),

        const Text(
          "Times",
          style: TextStyle(fontSize: 16),
        ),
        // const TextField(
        //   decoration: InputDecoration(hintText: "Times"),
        // ),
      ],
    );
  }

  TextField buildDatePicker() {
    return TextField(
      controller: dateController, //editing controller of this TextField
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
        prefixIcon: Icon(
          Icons.calendar_today,
        ), //icon of text field
        labelText: "Last Date of Donation",
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

          setState(
            () {
              dateController.text = formattedDate;
            },
          );
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const FittedBox(fit: BoxFit.fitWidth, child: Text("Donor Register Form")),
      backgroundColor: Colors.blueAccent[100],
      actions: [
        if (widget.isEdit)
          Tooltip(
            message: 'Transfustion Transmitted Infections',
            child: IconButton(
              onPressed: () {
                Get.to(TTRFHomePage(
                  isEditing: true,
                  dao: widget.dao,
                  table: widget.table!,
                ));
              },
              icon: const Icon(Icons.health_and_safety),
            ),
          ),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are u sure want to save?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      //return false when click on "NO"
                      child: const Text('No'),
                    ),
                    Consumer(builder: (context, ref, _) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (widget.isEdit) {
                            await widget.dao.updateNote(
                              DDRFormTable(
                                objectId: objectId,
                                donorId: widget.table!.donorId,
                                name: nameTEC.text,
                                age: int.tryParse(ageTEC.text),
                                fatherName: fatherNameTEC.text,
                                motherName: '',
                                sex: selectedValueForSex,
                                sbp: kCurrentValueForSBP,
                                dbp: kCurrentValueForDBP,
                                maleHemoglobin: double.tryParse(hemoglobinController.text),
                                femaleHemoglobin: kCurrentValueForFemaleHemoglobin.toDouble(),
                                previousDonation: _pbdStatus.toString(),
                                representativeName: representativeNameTEC.text,
                                donatedTime: kCurrentTimesOfBloodDonation,
                                info: infoTEC.text,
                                location: locationTEC.text,
                                bloodGroup: selectedValueForPatientBloodGroup,
                                rhdFactor: rhdFactor,
                                lastDateOfDonation: dateController.text,
                              ),
                            );
                          } else {
                            await widget.dao.addNote(
                              DDRFormTable(
                                objectId: ObjectId().toString(),
                                name: nameTEC.text,
                                age: int.tryParse(ageTEC.text),
                                fatherName: fatherNameTEC.text,
                                motherName: '',
                                sex: selectedValueForSex,
                                sbp: kCurrentValueForSBP,
                                dbp: kCurrentValueForDBP,
                                maleHemoglobin: double.tryParse(hemoglobinController.text),
                                femaleHemoglobin: kCurrentValueForFemaleHemoglobin.toDouble(),
                                previousDonation: _pbdStatus.toString(),
                                representativeName: representativeNameTEC.text,
                                donatedTime: kCurrentTimesOfBloodDonation,
                                location: locationTEC.text,
                                bloodGroup: selectedValueForPatientBloodGroup,
                                info: infoTEC.text,
                                rhdFactor: rhdFactor,
                                lastDateOfDonation: dateController.text,
                              ),
                            );
                          }
                          ref.invalidate(getAppDatabaseProvider);

                          setState(() {});
                          if (mounted) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                        //return true when click on "Yes"
                        child: const Text('Yes'),
                      );
                    }),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.add_box))
      ],
    );
  }

  Row buildDropDownButton() {
    return Row(
      children: [
        const Text("Sex"),
        const Spacer(),
        DropdownButton(
          items: dropdownItems,
          value: selectedValueForSex,
          onChanged: (String? newValue) {
            setState(
              () {
                selectedValueForSex = newValue!;
                print("$selectedValueForSex");
              },
            );
          },
        ),
      ],
    );
  }

  static const List<String> rhdFactorList = [
    'Positive',
    'Negative',
  ];

  Row buildRhdDropDownButton() {
    return Row(
      children: [
        const Text("RHD factor"),
        const Spacer(),
        DropdownButton<String>(
          items: [
            for (final i in rhdFactorList)
              DropdownMenuItem(
                value: i,
                child: Text(i),
              ),
          ],
          value: rhdFactor,
          onChanged: (newValue) {
            rhdFactor = newValue!;
            setState(() {});
          },
        ),
      ],
    );
  }

  Row buildSBloodPressure() {
    return Row(
      children: [
        const Text(
          "S Blood Pressure",
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
        NumberPicker(
          selectedTextStyle: TextStyle(color: Colors.blueAccent.shade100, fontSize: 24),
          minValue: 100,
          itemCount: 1,
          itemHeight: 30,
          maxValue: 120,
          haptics: true,
          value: kCurrentValueForSBP,
          onChanged: (value) => setState(
            () {
              kCurrentValueForSBP = value;
            },
          ),
        ),
        const Text(
          "mm Hg",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Row buildDBloodPressure() {
    return Row(
      children: [
        const Text(
          "D Blood Pressure",
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
        NumberPicker(
          selectedTextStyle: TextStyle(color: Colors.blueAccent.shade100, fontSize: 24),
          minValue: 60,
          itemCount: 1,
          itemHeight: 30,
          maxValue: 120,
          haptics: true,
          value: kCurrentValueForDBP,
          onChanged: (value) => setState(
            () {
              kCurrentValueForDBP = value;
            },
          ),
        ),
        const Text(
          "mm Hg",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Row buildMaleHemoglobin() {
    return Row(
      children: [
        const Text(
          "Hemoglobin",
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
        SizedBox(
          width: 150,
          child: TextField(
            controller: hemoglobinController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'g/dl',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        // NumberPicker(
        //   selectedTextStyle: TextStyle(color: Colors.blueAccent.shade100, fontSize: 24),
        //   minValue: 10,
        //   itemCount: 1,
        //   itemHeight: 30,
        //   maxValue: 20,
        //   haptics: true,
        //   textMapper: (numberText) => 'a',
        //   value: kCurrentValueForMaleHemoglobin,
        //   onChanged: (value) => setState(
        //     () {
        //       kCurrentValueForMaleHemoglobin = value;
        //     },
        //   ),
        // ),
        // const Text(
        //   "g/dl",
        //   style: TextStyle(fontSize: 16),
        // ),
      ],
    );
  }

  Row buildFemaleHemoglobin() {
    return Row(
      children: [
        const Text(
          "Female Hemoglobin",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 70,
        ),
        NumberPicker(
          selectedTextStyle: TextStyle(color: Colors.blueAccent.shade100, fontSize: 24),
          minValue: 10,
          itemCount: 1,
          itemHeight: 30,
          maxValue: 20,
          haptics: true,
          value: kCurrentValueForFemaleHemoglobin,
          onChanged: (value) => setState(
            () {
              kCurrentValueForFemaleHemoglobin = value;
            },
          ),
        ),
        const Text(
          "g/dl",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Row buildPreviousBloodDonation() {
    return Row(
      children: [
        const Text(
          "Previous Blood Donation",
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
        SegmentedButton<PBDStatus>(
          style: ElevatedButton.styleFrom(side: const BorderSide(color: Colors.blue)),
          segments: const [
            ButtonSegment(
              value: PBDStatus.yes,
              label: Text('Yes'),
            ),
            ButtonSegment(
              value: PBDStatus.no,
              label: Text('No'),
            ),
          ],
          onSelectionChanged: (value) {
            _pbdStatus = value.first;

            setState(() {});
          },
          selected: {_pbdStatus},
        ),
        // SizedBox(
        //   width: 80,
        //   child: ListTile(
        //     contentPadding: const EdgeInsets.all(0),
        //     title: const Text('Yes'),
        //     leading: Radio<PBDStatus>(
        //       value: PBDStatus.yes,
        //       fillColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
        //       groupValue: _pbdStatus,
        //       onChanged: (PBDStatus? value) {
        //         setState(
        //           () {
        //             _pbdStatus = value;
        //             if (_pbdStatus == PBDStatus.yes) {
        //               print("$value");
        //               kIsVisible = true;
        //             }
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   width: 80,
        //   child: ListTile(
        //     contentPadding: const EdgeInsets.all(0),
        //     title: const Text('No'),
        //     leading: Radio<PBDStatus>(
        //       value: PBDStatus.no,
        //       groupValue: _pbdStatus,
        //       fillColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
        //       onChanged: (PBDStatus? value) {
        //         setState(
        //           () {
        //             _pbdStatus = value;
        //             print("$value");
        //             kIsVisible = false;
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Row buildPatientBloodGroupDropDownButton() {
    return Row(
      children: [
        const Text("Blood Grouping"),
        const Spacer(),
        DropdownButton(
          items: dropdownPatientBloodGroupItems,
          value: selectedValueForPatientBloodGroup,
          onChanged: (String? newPatientBloodGroupValue) {
            setState(
              () {
                selectedValueForPatientBloodGroup = newPatientBloodGroupValue!;
                print("$selectedValueForPatientBloodGroup");
              },
            );
          },
        ),
      ],
    );
  }
}
