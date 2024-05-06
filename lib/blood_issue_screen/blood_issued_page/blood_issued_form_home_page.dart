import 'package:blood_transfusion_register/apis/blood_data/blood_data_repository.dart';
import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/database/blood_issue_form_database.dart/blood_issue_form_dao.dart';
import 'package:blood_transfusion_register/database/blood_issue_form_database.dart/blood_issue_form_table.dart';
import 'package:blood_transfusion_register/form_screen/form_page.dart';
import 'package:blood_transfusion_register/reusable_content/show_common_snackbar.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../database/blood_request_forms_database.dart/blood_request_form_table.dart';
import '../../database/donation_register_form_database/donation_register_form_table.dart';

class BIRFormHomePage extends ConsumerStatefulWidget {
  const BIRFormHomePage({
    Key? key,
    required this.dao,
    required this.isEdit,
    required this.table,
  }) : super(key: key);
  final BloodIssueFormDao dao;
  final bool isEdit;
  final BloodIssueFormTable? table;
  @override
  ConsumerState<BIRFormHomePage> createState() => _BIRFormHomePageState();
}

class _BIRFormHomePageState extends ConsumerState<BIRFormHomePage> {
  String? selectedValueForPatientSex;
  String? selectedValueForDonorSex;
  String? selectedValueForPatientBloodGroup;
  String? selectedValueForDonorBloodGroup;
  String? selectedValueForCompatibilityTesting;
  String? selectedValueForComponent;
  int? id;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final patientIdController = TextEditingController();
  final ageController = TextEditingController();
  final diseaseOrReasonForBloodRequestController = TextEditingController();
  final donorIdController = TextEditingController();
  final issueByController = TextEditingController();
  DDRFormTable? donor;
  BloodRequestTable? patient;
  @override
  void initState() {
    if (widget.isEdit) {
      _setData();
    }
    super.initState();
  }

  void _setData() async {
    final data = widget.table!;
    final donorId = data.donorObjectId;
    donor = await ref.read(getDonorListByIdProvider(donorId!).future);
    final patientId = data.patientOjectId;
    patient = await ref.read(getPatientByIdProvider(patientId!).future);
    selectedValueForCompatibilityTesting = data.compatibilityTesting;
    selectedValueForComponent = data.component;
    diseaseOrReasonForBloodRequestController.text = data.reasonForBloodRequest ?? '';
    dateController.text = data.date ?? '';
    timeController.text = data.time ?? '';
    setState(() {});
  }

  TimeOfDay time = TimeOfDay.now();

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
      const DropdownMenuItem(value: "Rh Positive", child: Text("Rh Positive")),
      const DropdownMenuItem(value: "Rh Negative", child: Text("Rh Negative")),
      const DropdownMenuItem(value: "Other", child: Text("Other")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownDonorBloodGroupItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "A", child: Text("A")),
      const DropdownMenuItem(value: "B", child: Text("B")),
      const DropdownMenuItem(value: "AB", child: Text("AB")),
      const DropdownMenuItem(value: "O", child: Text("O")),
      const DropdownMenuItem(value: "Rh Positive", child: Text("Rh Positive")),
      const DropdownMenuItem(value: "Rh Negative", child: Text("Rh Negative")),
      const DropdownMenuItem(value: "Other", child: Text("Other")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownDonorSexItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownCompatibilityTestingItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Major Crossmatch", child: Text("Major Crossmactch")),
      const DropdownMenuItem(value: "Minor Crossmatch", child: Text("Minor Crossmatch")),
      const DropdownMenuItem(value: "No Crossmatch", child: Text("No Crossmatch")),
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

  AppBar buildAppBar() {
    return AppBar(
      title: const FittedBox(
        fit: BoxFit.fitWidth,
        child: Text("Blood Issued Form"),
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
                      if (patient != null && donor != null) {
                        if (widget.isEdit) {
                          widget.dao.updateBloodIssue(
                            BloodIssueFormTable(
                              id: widget.table!.id,
                              date: dateController.text,
                              patientName: patient!.patientId,
                              patientId: patient!.id!,
                              patientOjectId: patient!.objectId,
                              donorName: donor!.name,
                              donorId: donor!.donorId,
                              donorObjectId: donor!.objectId,
                              compatibilityTesting: selectedValueForCompatibilityTesting,
                              reasonForBloodRequest: diseaseOrReasonForBloodRequestController.text,
                              component: selectedValueForComponent,
                              time: timeController.text,
                            ),
                          );
                        } else {
                          widget.dao.addBloodIssue(
                            BloodIssueFormTable(
                              date: dateController.text,
                              patientName: patient!.patientId,
                              patientId: patient!.id!,
                              patientOjectId: patient!.objectId,
                              donorName: donor!.name,
                              donorId: donor!.donorId,
                              donorObjectId: donor!.objectId,
                              compatibilityTesting: selectedValueForCompatibilityTesting,
                              reasonForBloodRequest: diseaseOrReasonForBloodRequestController.text,
                              component: selectedValueForComponent,
                              time: timeController.text,
                            ),
                          );
                        }
                        if (mounted) Navigator.pop(context);
                      } else {
                        showCommonSnackBar(
                          message: 'Donor and Patient can\'t be empty',
                          bgColor: Colors.red,
                        );
                      }
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

  Widget buildColumn() {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              buildDonorList(),
              const SizedBox(
                height: 20,
              ),
              buildPatientList(),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: diseaseOrReasonForBloodRequestController,
                decoration: const InputDecoration(hintText: "Disease or Reason for blood request"),
              ),
              const SizedBox(
                height: 20,
              ),
              buildCompatibilityTestingSexDropDownButton(),
              const SizedBox(
                height: 20,
              ),
              buildComponentDropDownButton(),
              const SizedBox(
                height: 20,
              ),
              buildDatePicker(),
              const SizedBox(
                height: 20,
              ),
              buildTimePicker(),
            ],
          ),
        ),
      ],
    );
  }

  Row buildPatientSexDropDownButton() {
    return Row(
      children: [
        const Text("Sex"),
        const SizedBox(
          width: 260,
        ),
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
        const SizedBox(
          width: 150,
        ),
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

  Row buildDonorSexDropDownButton() {
    return Row(
      children: [
        const Text("Sex"),
        const SizedBox(
          width: 260,
        ),
        DropdownButton(
          items: dropdownDonorSexItems,
          value: selectedValueForDonorSex,
          onChanged: (String? newDonorSexValue) {
            setState(
              () {
                selectedValueForDonorSex = newDonorSexValue!;
                print("$selectedValueForDonorSex");
              },
            );
          },
        ),
      ],
    );
  }

  Row buildDonorBloodGroupDropDownButton() {
    return Row(
      children: [
        const Text("Blood Grouping"),
        const SizedBox(
          width: 150,
        ),
        DropdownButton(
          items: dropdownDonorBloodGroupItems,
          value: selectedValueForDonorBloodGroup,
          onChanged: (String? newDonorBloodGroupValue) {
            setState(
              () {
                selectedValueForDonorBloodGroup = newDonorBloodGroupValue!;
                print("$selectedValueForDonorBloodGroup");
              },
            );
          },
        ),
      ],
    );
  }

  Widget buildDonorList() {
    return Row(
      children: [
        const Text("Donor"),
        const Spacer(),
        SizedBox(
          width: 250,
          child: ref.watch(getDonorListProvider).when(
              data: (data) {
                if (data.isEmpty) {
                  return const Text(
                    'Please add donors',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  );
                }
                return DropdownButtonFormField<DDRFormTable>(
                  items: [
                    for (final i in data)
                      DropdownMenuItem(
                        value: i,
                        child: Text(i.name ?? '-'),
                      ),
                  ],
                  value: null,
                  onChanged: (value) {
                    donor = value!;
                    setState(() {});
                  },
                  hint: Text(
                    widget.table?.donorName ?? '',
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                );
              },
              error: (e, st) => Text(
                    '$e',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
      ],
    );
  }

  Widget buildPatientList() {
    return Row(
      children: [
        const Text("Patient"),
        const Spacer(),
        SizedBox(
          width: 250,
          child: ref.watch(getPatientListProvider).when(
              data: (data) {
                if (data.isEmpty) {
                  return const Text(
                    'Please add patients',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  );
                }
                return DropdownButtonFormField<BloodRequestTable>(
                  items: [
                    for (final i in data)
                      DropdownMenuItem(
                        value: i,
                        child: Text(i.patientId ?? '-'),
                      ),
                  ],
                  hint: Text(
                    widget.table?.patientName ?? '',
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  value: null,
                  onChanged: (value) {
                    patient = value!;
                    setState(() {});
                  },
                );
              },
              error: (e, st) => Text(
                    '$e',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
      ],
    );
  }

  Row buildCompatibilityTestingSexDropDownButton() {
    return Row(
      children: [
        const Text("Compatibility Testing"),
        const Spacer(),
        DropdownButton(
          items: dropdownCompatibilityTestingItems,
          value: selectedValueForCompatibilityTesting,
          onChanged: (String? newCompatibilityTestingValue) {
            setState(
              () {
                selectedValueForCompatibilityTesting = newCompatibilityTestingValue!;
                print("$selectedValueForCompatibilityTesting");
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
        labelText: "Date of Issue",
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
    } else {
      print("Time Error");
    }
  }

  TextField buildTimePicker() {
    return TextField(
      controller: timeController, //editing controller of this TextField
      decoration: const InputDecoration(
        icon: Icon(
          Icons.timer,
        ), //icon of text field
        labelText: "Time of Issue ",
      ),
      readOnly: true, // when true user cannot edit text
      onTap: () async {
        _selectTime();
      },
    );
  }
}
