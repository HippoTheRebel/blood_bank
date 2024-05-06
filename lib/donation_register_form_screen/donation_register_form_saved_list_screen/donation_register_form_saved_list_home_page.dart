import 'dart:convert';

import 'package:blood_transfusion_register/apis/blood_data/upload_controller.dart';
import 'package:blood_transfusion_register/blood_issue_screen/blood_issued_page/blood_issued_form_home_page.dart';
import 'package:blood_transfusion_register/blood_request_screen/blood_request_form_page/blood_request_form_home_page.dart';
import 'package:blood_transfusion_register/database/blood_issue_form_database.dart/blood_issue_form_dao.dart';
import 'package:blood_transfusion_register/database/blood_request_forms_database.dart/blood_request_form_table.dart';
import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_dao.dart';
import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_table.dart';
import 'package:blood_transfusion_register/home_page.dart';
import 'package:blood_transfusion_register/reusable_content/reusable_ddrf_saved_list_card/reusable_ddrf_saved_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../database/blood_issue_form_database.dart/blood_issue_form_table.dart';
import '../../database/blood_request_forms_database.dart/blood_request_form_dao.dart';
import '../../transfusion_transmitted_infection_register_form_screen/transfusion_transmitted_infection_register_form_page/transfusion_transmitted_infection_register_form_home_page.dart';
import '../donation_register_update_screen/donation_register_form_update_page.dart';

class DDRFormSavedListHomePage extends ConsumerStatefulWidget {
  const DDRFormSavedListHomePage({
    Key? key,
    required this.pageType,
    required this.bloodRequestFormDao,
    required this.ddrFormDatabaseDao,
    required this.bloodIssueFormDao,
  }) : super(key: key);
  final PageTypes pageType;
  final BloodRequestFormDao? bloodRequestFormDao;
  final DDRFormDatabaseDao? ddrFormDatabaseDao;
  final BloodIssueFormDao? bloodIssueFormDao;
  @override
  ConsumerState<DDRFormSavedListHomePage> createState() => _DDRFormSavedListHomePageState();
}

class _DDRFormSavedListHomePageState extends ConsumerState<DDRFormSavedListHomePage> {
  DDRFormDatabaseDao? ddrFormDatabaseDao;
  BloodRequestFormDao? brfDatabaseDao;
  BloodIssueFormDao? bloodIssueDao;

  @override
  void initState() {
    ddrFormDatabaseDao = widget.ddrFormDatabaseDao;
    brfDatabaseDao = widget.bloodRequestFormDao;
    bloodIssueDao = widget.bloodIssueFormDao;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Material(
        child: () {
          if (widget.pageType == PageTypes.donationRegister && ddrFormDatabaseDao != null) {
            return dDRFSavedList();
          } else if (widget.pageType == PageTypes.bloodRequest && brfDatabaseDao != null) {
            return buildBloodRequestForms();
          } else if (widget.pageType == PageTypes.bloodIssue && bloodIssueDao != null) {
            return buildBloodIssueForms();
          }
        }(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(() {
          if (widget.pageType == PageTypes.donationRegister) {
            return 'Donor Register Forms';
          } else if (widget.pageType == PageTypes.bloodRequest) {
            return 'Blood Request Forms';
          }
          return 'Blood Issue Forms';
        }()),
      ),
      backgroundColor: Colors.blueAccent[100],
      actions: [
        IconButton(
          onPressed: () async {
            // Get all the saved data from the database
            if (widget.pageType == PageTypes.donationRegister) {
              final list = await widget.ddrFormDatabaseDao!.getAllDDRFormListFuture();
              ref.read(uploadControllerProvider.notifier).uploadDonors(donorList: list, dao: widget.ddrFormDatabaseDao!);
            } else if (widget.pageType == PageTypes.bloodRequest) {
              final list = await widget.bloodRequestFormDao!.getAllDDRFormListFuture();
              ref.read(uploadControllerProvider.notifier).uploadPatients(patientList: list, dao: widget.bloodRequestFormDao!);
            } else {
              //issue form
              final list = await widget.bloodIssueFormDao!.getAllDDRFormListFuture();
              ref.read(uploadControllerProvider.notifier).issueUpload(list: list, dao: widget.bloodIssueFormDao!);
            }
          },
          icon: ref.watch(uploadControllerProvider).donorLoading || ref.watch(uploadControllerProvider).bloodRequestLoading || ref.watch(uploadControllerProvider).bloodIssueLoading
              ? () {
                  if ((widget.pageType == PageTypes.donationRegister && ref.watch(uploadControllerProvider).donorLoading) ||
                      (widget.pageType == PageTypes.bloodRequest && ref.watch(uploadControllerProvider).bloodRequestLoading) ||
                      (widget.pageType == PageTypes.bloodIssue && ref.watch(uploadControllerProvider).bloodIssueLoading)) {
                    return const SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    );
                  }
                  return const Icon(Icons.upload);
                }()
              : const Icon(Icons.upload),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are u sure want to delete'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    //return false when click on "NO"
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.pageType == PageTypes.donationRegister) {
                        final list = await widget.ddrFormDatabaseDao!.getAllDDRFormListFuture();
                        await widget.ddrFormDatabaseDao!.deleteAllNote(list);
                      } else if (widget.pageType == PageTypes.bloodRequest) {
                        final list = await widget.bloodRequestFormDao!.getAllDDRFormListFuture();
                        widget.bloodRequestFormDao!.deleteAllBloodRequest(list);
                      } else {
                        //issue form
                        final list = await widget.bloodIssueFormDao!.getAllDDRFormListFuture();
                        await widget.bloodIssueFormDao!.deleteAllBloodIssue(list);
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
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Widget dDRFSavedList() {
    return StreamBuilder<List<DDRFormTable>>(
      stream: ddrFormDatabaseDao!.getAllDDRFormList(),
      builder: (_, snapShotData) {
        if (snapShotData.hasData) {
          if (snapShotData.data!.isEmpty) {
            return const Center(child: Text('No Data'));
          }
          return ListView.builder(
              itemCount: snapShotData.data?.length,
              itemBuilder: (_, position) {
                return ReusableDDRFSavedListCard(
                  name: (snapShotData.data![position].donorId ?? '-').toString(),
                  donorId: snapShotData.data![position].name.toString(),
                  age: snapShotData.data![position].age,
                  onPressTrailing: () {
                    ddrFormDatabaseDao!.deleteNote(snapShotData.data![position]);
                  },
                  ttiCallback: () {
                    Get.to(TTRFHomePage(
                      isEditing: true,
                      dao: ddrFormDatabaseDao!,
                      table: snapShotData.data![position],
                    ));
                  },
                  onEdit: () {
                    Get.to(
                      DDRFormUpdatePage(
                        table: snapShotData.data![position],
                      ),
                    );
                  },
                  dDRFormTable: snapShotData.data![position],
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

  Widget buildBloodRequestForms() {
    return StreamBuilder<List<BloodRequestTable>>(
      stream: brfDatabaseDao!.getAllDDRFormList(),
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
                  donorId: snapShotData.data![position].patientId.toString(),
                  age: snapShotData.data![position].age,
                  onPressTrailing: () {
                    brfDatabaseDao!.deleteBloodRequest(snapShotData.data![position]);
                  },
                  onEdit: () {
                    Get.to(
                      BRFormHomePage(
                        isEdit: true,
                        dao: brfDatabaseDao!,
                        table: snapShotData.data![position],
                      ),
                    );
                  },
                  dDRFormTable: null,
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

  Widget buildBloodIssueForms() {
    return StreamBuilder<List<BloodIssueFormTable>>(
      stream: bloodIssueDao!.getAllDDRFormList(),
      builder: (_, snapShotData) {
        if (snapShotData.hasData) {
          if (snapShotData.data!.isEmpty) {
            return const Center(child: Text('No Data'));
          }
          return ListView.builder(
              itemCount: snapShotData.data?.length,
              itemBuilder: (_, position) {
                return ReusableDDRFSavedListCard(
                  name: snapShotData.data![position].patientName.toString(),
                  donorId: snapShotData.data![position].donorName.toString(),
                  age: '',
                  onPressTrailing: () {
                    bloodIssueDao!.deleteBloodIssue(snapShotData.data![position]);
                  },
                  onEdit: () {
                    Get.to(
                      BIRFormHomePage(
                        dao: bloodIssueDao!,
                        isEdit: true,
                        table: snapShotData.data![position],
                      ),
                    );
                  },
                  dDRFormTable: null,
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
}
