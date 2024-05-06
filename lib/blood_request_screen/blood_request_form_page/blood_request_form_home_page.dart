import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/database/blood_request_forms_database.dart/blood_request_form_table.dart';
import 'package:blood_transfusion_register/form_screen/form_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:objectid/objectid.dart';

import '../../database/blood_request_forms_database.dart/blood_request_form_dao.dart';

class BRFormHomePage extends StatefulWidget {
  const BRFormHomePage({Key? key, required this.isEdit, required this.dao, required this.table}) : super(key: key);
  final bool isEdit;
  final BloodRequestFormDao dao;
  final BloodRequestTable? table;
  @override
  State<BRFormHomePage> createState() => _BRFormHomePageState();
}

class _BRFormHomePageState extends State<BRFormHomePage> {
  int? id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      final data = widget.table!;
      labIdController.text = data.labId ?? '';
      patientIdController.text = data.patientId ?? '';
      ageController.text = data.age ?? '';
      selectedValueForSex = data.sex;
      selectedValueForPatientBloodGroup = data.bloodGrouping;
      selectedValueForHistoryOfBloodT = data.historyOfBloodTransfustion;
      selectedValueForReasonsOfTransfusion = data.reasonOfTransfusion;
      selectedValueForTransfusionReaction = data.transfusionReaction;
      dateController.text = data.date ?? '';
      timeController.text = data.time ?? '';
      selectedValueForComponent = data.component;
      requestedByController.text = data.requestBy ?? '';
      id = data.id;
      fatherNameController.text = data.fatherName ?? '';
      locationController.text = data.location ?? '';
      infoCotroller.text = data.info ?? '';
      currentValueForHameoglobin = int.tryParse(data.hemoglobin ?? '') ?? currentValueForHameoglobin;
      objectId = data.objectId ?? '';
      rhdFactor = data.rhdFactor;
      hemoglobinController.text = data.hemoglobin ?? '';
    }
  }

  String? selectedValueForPatientSex;
  String? selectedValueForPatientBloodGroup;
  String? selectedValueForHistoryOfBloodT;
  String? selectedValueForReasonsOfTransfusion;
  String? selectedValueForTransfusionReaction;
  String? selectedValueForComponent;
  String? rhdFactor;
  bool isVisible = false;
  final hemoglobinController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final labIdController = TextEditingController();
  final patientIdController = TextEditingController();
  final ageController = TextEditingController();
  final requestedByController = TextEditingController();

  final fatherNameController = TextEditingController();
  final locationController = TextEditingController();
  final infoCotroller = TextEditingController();
  int currentValueForHameoglobin = 10;

  TimeOfDay time = TimeOfDay.now();

  String objectId = '';

  List<DropdownMenuItem<String>> get dropdownPatientSexItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownPatientBloodGroupItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "A", child: Text("A")),
      const DropdownMenuItem(value: "B", child: Text("B")),
      const DropdownMenuItem(value: "AB", child: Text("AB")),
      const DropdownMenuItem(value: "O", child: Text("O")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownHistoryOfBloodTItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Positive", child: Text("Positive")),
      const DropdownMenuItem(value: "Negative", child: Text("Negative")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownReasonsForTransfusionItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Chronic Anemia", child: Text("Chronic Anemia")),
      const DropdownMenuItem(value: "Acute Blood Loss", child: Text("Acute Blood Loss")),
      const DropdownMenuItem(value: "Exchange Transfusion", child: Text("Exchange Transfusion")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownTransfusionReactionItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Positive", child: Text("Positive")),
      const DropdownMenuItem(value: "Negative", child: Text("Negative")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownComponentItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Whole Blood", child: Text("Whole Blood")),
      const DropdownMenuItem(value: "Packed red cells", child: Text("Packed red cells")),
      const DropdownMenuItem(value: "Plasma", child: Text("Plasma")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildColumn(),
    );
  }

  Widget buildColumn() {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: labIdController,
                decoration: const InputDecoration(hintText: "Lab ID"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: patientIdController,
                decoration: const InputDecoration(hintText: "Patient Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: ageController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(hintText: "Age"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: fatherNameController,
                decoration: const InputDecoration(hintText: "Father Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(hintText: "Location"),
              ),
              const SizedBox(
                height: 20,
              ),
              buildPatientSexDropDownButton(),
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
              buildHistoryOfBloodTransfusionDropDownButton(),
              buildReasonsForTransfusionDropDownButton(),
              const SizedBox(
                height: 20,
              ),
              buildTransfusionReactionsDropDownButton(),
              buildDatePicker(),
              const SizedBox(
                height: 20,
              ),
              buildTimePicker(),
              const SizedBox(
                height: 20,
              ),
              buildMaleHemoglobin(),
              const SizedBox(
                height: 20,
              ),
              buildComponentDropDownButton(),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: requestedByController,
                decoration: const InputDecoration(hintText: "Request By"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: infoCotroller,
                decoration: const InputDecoration(hintText: "Diagnosis/Patient Information"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const FittedBox(
        fit: BoxFit.fitWidth,
        child: Text("Blood Request Form"),
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
                    //return false when click on "NO"
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.isEdit) {
                        await widget.dao.updateBloodRequest(
                          BloodRequestTable(
                            objectId: objectId,
                            id: id,
                            labId: labIdController.text,
                            patientId: patientIdController.text,
                            age: ageController.text,
                            sex: selectedValueForSex,
                            bloodGrouping: selectedValueForPatientBloodGroup,
                            historyOfBloodTransfustion: selectedValueForHistoryOfBloodT,
                            reasonOfTransfusion: selectedValueForReasonsOfTransfusion,
                            transfusionReaction: selectedValueForTransfusionReaction,
                            date: dateController.text,
                            time: timeController.text,
                            component: selectedValueForComponent,
                            requestBy: requestedByController.text,
                            fatherName: fatherNameController.text,
                            info: infoCotroller.text,
                            location: locationController.text,
                            hemoglobin: hemoglobinController.text,
                            rhdFactor: rhdFactor,
                          ),
                        );
                      } else {
                        await widget.dao.addBloodRequest(
                          BloodRequestTable(
                            objectId: ObjectId().toString(),
                            labId: labIdController.text,
                            patientId: patientIdController.text,
                            age: ageController.text,
                            sex: selectedValueForSex,
                            bloodGrouping: selectedValueForPatientBloodGroup,
                            historyOfBloodTransfustion: selectedValueForHistoryOfBloodT,
                            reasonOfTransfusion: selectedValueForReasonsOfTransfusion,
                            transfusionReaction: selectedValueForTransfusionReaction,
                            date: dateController.text,
                            time: timeController.text,
                            component: selectedValueForComponent,
                            requestBy: requestedByController.text,
                            fatherName: fatherNameController.text,
                            info: infoCotroller.text,
                            location: locationController.text,
                            hemoglobin: hemoglobinController.text,
                            rhdFactor: rhdFactor,
                          ),
                        );
                      }

                      if (mounted) Navigator.pop(context);
                      if (mounted) Navigator.pop(context);
                    },
                    //return true when click on "Yes"
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Row buildPatientSexDropDownButton() {
    return Row(
      children: [
        const Text("Sex"),
        const Spacer(),
        DropdownButton(
          items: dropdownPatientSexItems,
          value: selectedValueForPatientSex,
          onChanged: (String? newPatientSexValue) {
            setState(
              () {
                selectedValueForPatientSex = newPatientSexValue!;
                print("$selectedValueForPatientSex");
              },
            );
          },
        ),
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

  Row buildHistoryOfBloodTransfusionDropDownButton() {
    return Row(
      children: [
        const Text("History Of Blood Transfusion"),
        const Spacer(),
        DropdownButton(
          items: dropdownHistoryOfBloodTItems,
          value: selectedValueForHistoryOfBloodT,
          onChanged: (String? newHistoryOfBloodTValue) {
            setState(
              () {
                if (newHistoryOfBloodTValue == "Positive") {
                  selectedValueForHistoryOfBloodT = newHistoryOfBloodTValue!;
                  isVisible = true;
                  print("True");
                  print("$selectedValueForHistoryOfBloodT");
                } else if (newHistoryOfBloodTValue == "Negative") {
                  selectedValueForHistoryOfBloodT = newHistoryOfBloodTValue!;
                  isVisible = false;
                  print("False");
                }
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

  Row buildReasonsForTransfusionDropDownButton() {
    return Row(
      children: [
        if (isVisible) const Text("Reasons Of Transfusion"),
        const SizedBox(
          width: 20,
        ),
        if (isVisible)
          DropdownButton(
            items: dropdownReasonsForTransfusionItems,
            value: selectedValueForReasonsOfTransfusion,
            onChanged: (String? newReasonsOfTransfusionValue) {
              setState(
                () {
                  selectedValueForReasonsOfTransfusion = newReasonsOfTransfusionValue!;
                  print("$selectedValueForReasonsOfTransfusion");
                },
              );
            },
          ),
      ],
    );
  }

  Row buildTransfusionReactionsDropDownButton() {
    return Row(
      children: [
        if (isVisible) const Text("Transfusion Reactions"),
        if (isVisible)
          const SizedBox(
            width: 130,
          ),
        if (isVisible)
          DropdownButton(
            items: dropdownTransfusionReactionItems,
            value: selectedValueForTransfusionReaction,
            onChanged: (String? newTransfusionReactionValue) {
              setState(
                () {
                  selectedValueForTransfusionReaction = newTransfusionReactionValue!;
                  print("$selectedValueForTransfusionReaction");
                },
              );
            },
          ),
      ],
    );
  }

  TextField buildDatePicker() {
    return TextField(
      controller: dateController, //editing controller of this TextField
      decoration: const InputDecoration(
        icon: Icon(
          Icons.calendar_today,
        ), //icon of text field
        labelText: "Date of Request",
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

  void _selectTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (selectedTime != null) {
      final formatTime = selectedTime.format(context);
      setState(
        () {
          timeController.text = formatTime.toString();
        },
      );
    } else
      print("Time Error");
  }

  TextField buildTimePicker() {
    return TextField(
      controller: timeController, //editing controller of this TextField
      decoration: const InputDecoration(
        icon: Icon(
          Icons.timer,
        ), //icon of text field
        labelText: "Time of Request",
      ),
      readOnly: true, // when true user cannot edit text
      onTap: () async {
        _selectTime();
      },
    );
  }

  Row buildComponentDropDownButton() {
    return Row(
      children: [
        const Text("Component"),
        const Spacer(),
        DropdownButton(
          items: dropdownComponentItems,
          value: selectedValueForComponent,
          onChanged: (String? newComponentSexValue) {
            setState(
              () {
                selectedValueForComponent = newComponentSexValue!;
                print("$selectedValueForComponent");
              },
            );
          },
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
        //   value: currentValueForHameoglobin,
        //   onChanged: (value) => setState(
        //     () {
        //       currentValueForHameoglobin = value;
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
}
