import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_dao.dart';
import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_table.dart';
import 'package:blood_transfusion_register/form_screen/form_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

@Deprecated('resuable found')
class DRFHomepage extends StatefulWidget {
  const DRFHomepage({
    Key? key,
  }) : super(key: key);

  @override
  State<DRFHomepage> createState() => _DRFHomepageState();
}

enum PBDStatus {
  yes,
  no,
}

class _DRFHomepageState extends State<DRFHomepage> {
  PBDStatus? selectedPBD;
  PBDStatus? _pbdStatus = PBDStatus.no;
  String? selectedValueForSex;
  final DDRFormDatabaseDao ddrFormDatabaseDao = Get.find();
  final TextEditingController donorIdTEC = TextEditingController();
  final TextEditingController nameTEC = TextEditingController();
  final ageTEC = TextEditingController();
  final fatherNameTEC = TextEditingController();
  final motherNameTEC = TextEditingController();
  final representativeNameTEC = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
    ];
    return menuItems;
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
        TextField(
          controller: donorIdTEC,
          keyboardType: const TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            labelText: "Donor ID",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: nameTEC,
          decoration: const InputDecoration(
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
            labelText: "Father Name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: motherNameTEC,
          decoration: const InputDecoration(
            labelText: "Mother Name",
            border: OutlineInputBorder(),
          ),
        ),
        buildDropDownButton(),
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
        buildFemaleHemoglobin(),
        const SizedBox(
          height: 8,
        ),
        buildPreviousBloodDonation(),
        const SizedBox(
          height: 8,
        ),
        buildTimesOfBloodDonation(),
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
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
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
        if (kIsVisible)
          const Text(
            "Times of Blood Donation",
            style: TextStyle(fontSize: 16),
          ),
        const SizedBox(
          width: 35,
        ),
        if (kIsVisible)
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
        if (kIsVisible)
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

  AppBar buildAppBar() {
    return AppBar(
      title: const FittedBox(fit: BoxFit.fitWidth, child: Text("Donor Register Form")),
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
                      //return false when click on "NO"
                      child: const Text('No'),
                    ),
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
        const SizedBox(
          width: 220,
        ),
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

  Row buildSBloodPressure() {
    return Row(
      children: [
        const Text(
          "S Blood Pressure",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 90,
        ),
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
        const SizedBox(
          width: 90,
        ),
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
          "Male Hemoglobin",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 88,
        ),
        NumberPicker(
          selectedTextStyle: TextStyle(color: Colors.blueAccent.shade100, fontSize: 24),
          minValue: 10,
          itemCount: 1,
          itemHeight: 30,
          maxValue: 20,
          haptics: true,
          value: kCurrentValueForMaleHemoglobin,
          onChanged: (value) => setState(
            () {
              kCurrentValueForMaleHemoglobin = value;
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
          "Previous Blood Donation ",
          style: TextStyle(fontSize: 16),
        ),
        Expanded(
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text('Yes'),
            leading: Radio<PBDStatus>(
              value: PBDStatus.yes,
              fillColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
              groupValue: _pbdStatus,
              onChanged: (PBDStatus? value) {
                setState(
                  () {
                    _pbdStatus = value;
                    if (_pbdStatus == PBDStatus.yes) {
                      print("$value");
                      kIsVisible = true;
                    }
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text('No'),
            leading: Radio<PBDStatus>(
              value: PBDStatus.no,
              groupValue: _pbdStatus,
              fillColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent.shade100),
              onChanged: (PBDStatus? value) {
                setState(
                  () {
                    _pbdStatus = value;
                    print("$value");
                    kIsVisible = false;
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
