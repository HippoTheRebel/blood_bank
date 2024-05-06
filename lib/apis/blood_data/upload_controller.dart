import 'dart:developer';

import 'package:blood_transfusion_register/apis/blood_data/blood_data_repository.dart';
import 'package:blood_transfusion_register/database/blood_issue_form_database.dart/blood_issue_form_dao.dart';
import 'package:blood_transfusion_register/logIn_screen/login_page.dart';
import 'package:blood_transfusion_register/reusable_content/show_common_snackbar.dart';
import 'package:blood_transfusion_register/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/blood_issue_form_database.dart/blood_issue_form_table.dart';
import '../../database/blood_request_forms_database.dart/blood_request_form_dao.dart';
import '../../database/blood_request_forms_database.dart/blood_request_form_table.dart';
import '../../database/donation_register_form_database/donation_register_form_dao.dart';
import '../../database/donation_register_form_database/donation_register_form_table.dart';
import 'package:objectid/objectid.dart';
import 'blood_data_state.dart';

const _url = 'https://btt.humanitarianlabfamily.org/apis/v1/auth/allinone';

class UploadController extends StateNotifier<BloodDataState> {
  UploadController(this.ref)
      : super(
          BloodDataState(
            donorLoading: false,
            transfustionLoading: false,
            bloodRequestLoading: false,
            bloodIssueLoading: false,
          ),
        );
  final Ref ref;
  Future<void> uploadDonors({
    required List<DDRFormTable> donorList,
    required DDRFormDatabaseDao dao,
  }) async {
    if (donorList.isEmpty) {
      showCommonSnackBar(message: 'Donor List is empty!', bgColor: Colors.red);
      return;
    }
    state = state.copyWith(donorLoading: true);

    final payload = {
      'data': [
        for (final i in donorList)
          if (i.posted == false || i.posted == null)
            {
              '_id': i.objectId,
              'name': i.name,
              'father_name': i.fatherName,
              'blood_grouping': '${i.bloodGroup}${(i.rhdFactor?.toLowerCase().contains('p') ?? false) ? '+' : '-'}',
              'age': i.age,
              'sex': i.sex,
              'previous_blood_donation': i.previousDonation == 'PBDStatus.yes',
              'donated_times': i.donatedTime,
              'info': i.info,
              'location': i.location,
              'user': '',
              'status': i.representativeName,
              'tti_info': i.addedtti == true ? 'yes' : 'no',
              'is_used': 'false',
              'last_date_of_donation': i.lastDateOfDonation,
              'hemoglobin': i.maleHemoglobin.toString(),
              'blood_pressure': '${i.sbp} ${i.dbp}',
              'tti': [
                if (i.addedtti == true)
                  {
                    'hiv': i.hiv?.contains('yes') ?? false,
                    'hbs_ag': i.hbs?.contains('yes') ?? false,
                    'anti_hcv': i.antiHcv?.contains('yes') ?? false,
                    'malaria': i.malariaAg?.contains('yes') ?? false,
                    'syphilis': i.syphills?.contains('yes') ?? false,
                  }
              ]
            }
      ]
    };
    print(payload);

    final response = await Session.postJson('$_url/donortti', payload);
    state = state.copyWith(donorLoading: false);
    if (response.statusCode == 200) {
      //dao.deleteAllNote(donorList);
      dao.setPosted();
      showCommonSnackBar(message: 'Uploaded Donor List Successfully');
    } else if (response.statusCode == 401) {
      Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
        (_) => false,
      );
      showCommonSnackBar(message: 'Session Expired!', bgColor: Colors.red);
    } else {
      showCommonSnackBar(message: 'Something went wrong!', bgColor: Colors.red);
    }
  }

  ///blood request upload
  Future<void> uploadPatients({
    required List<BloodRequestTable> patientList,
    required BloodRequestFormDao dao,
  }) async {
    if (patientList.isEmpty) {
      showCommonSnackBar(message: 'Blood Request List is empty!', bgColor: Colors.red);
      return;
    }
    state = state.copyWith(bloodRequestLoading: true);
    final payload = {
      'data': [
        for (final i in patientList)
          if (i.posted == false || i.posted == null)
            {
              '_id': i.objectId,
              'lab_id': i.labId,
              'location': i.location,
              'name': i.patientId,
              'father_name': i.fatherName,
              'age': int.tryParse(i.age.toString()) ?? 0,
              'sex': i.sex,
              'blood_grouping': '${i.bloodGrouping}${(i.rhdFactor?.toLowerCase().contains('p') ?? false) ? '+' : '-'}',
              'blood_transfusion': i.historyOfBloodTransfustion == 'Positive',
              'transfusion_reason': i.reasonOfTransfusion,
              'transfusion_reaction': i.transfusionReaction == 'Positive',
              'hemoglobin': i.hemoglobin ?? '',
              'user_request': i.requestBy,
              'component': i.component,
              'info': i.info,
            }
      ]
    };
    final response = await Session.postJson('$_url/request', payload);

    state = state.copyWith(bloodRequestLoading: false);
    if (response.statusCode == 200) {
      // dao.deleteAllBloodRequest(patientList);
      dao.setPosted();
      showCommonSnackBar(message: 'Uploaded Donor List Successfully');
    } else if (response.statusCode == 401) {
      Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
        (_) => false,
      );
      showCommonSnackBar(message: 'Session Expired!', bgColor: Colors.red);
    } else {
      showCommonSnackBar(message: 'Something went wrong!', bgColor: Colors.red);
    }
  }

  //issue upload
  Future<void> issueUpload({
    required List<BloodIssueFormTable> list,
    required BloodIssueFormDao dao,
  }) async {
    if (list.isEmpty) {
      showCommonSnackBar(message: 'Issue List is empty!', bgColor: Colors.red);
      return;
    }
    state = state.copyWith(bloodIssueLoading: true);

    final List<Map<String, Object?>> payload = [];

    for (final i in list) {
      if (i.posted == false || i.posted == null) {
        final patient = await ref.read(getPatientByIdProvider(i.patientOjectId!).future);
        final patientMap = {
          '_id': patient.objectId,
          'lab_id': patient.labId,
          'location': patient.location,
          'name': patient.patientId,
          'father_name': patient.fatherName,
          'age': int.tryParse(patient.age.toString()) ?? 0,
          'sex': patient.sex,
          'blood_grouping': patient.bloodGrouping,
          'blood_transfusion': patient.historyOfBloodTransfustion == 'Positive',
          'transfusion_reason': patient.reasonOfTransfusion,
          'transfusion_reaction': patient.transfusionReaction == 'Positive',
          'hemoglobin': patient.hemoglobin,
          'user_request': patient.requestBy,
          'component': patient.component,
          'info': patient.info,
        };
        final donor = await ref.read(getDonorListByIdProvider(i.donorObjectId!).future);
        final donorMap = {
          '_id': donor.objectId,
          'name': donor.name,
          'father_name': donor.fatherName,
          'blood_grouping': donor.bloodGroup,
          'age': donor.age,
          'sex': donor.sex,
          'previou+_blood_donation': donor.previousDonation == 'PBDStatus.yes',
          'donated_times': donor.donatedTime,
          'info': donor.info,
          'location': donor.location,
          'user': '',
          'tti_info': donor.addedtti == true ? 'yes' : 'no',
          'hemoglobin': donor.maleHemoglobin.toString(),
          'blood_pressure': '${donor.sbp} ${donor.dbp}',
          'last_date_of_donation': donor.lastDateOfDonation,
        };
        payload.add({
          '_id': ObjectId().toString(),
          'patient_id': [
            patientMap,
          ],
          'donor_id': [
            donorMap,
          ],
          'disease_or_reason_for_blood_request': i.reasonForBloodRequest,
          'compatibility_testing': i.compatibilityTesting,
          'data_time': '${i.date} ${i.time}',
          'component': i.component,
          'user': '',
        });
      }
    }

    final response = await Session.postJson('$_url/issue', {
      'data': payload,
    });
    log({'data': payload}.toString());
    state = state.copyWith(bloodIssueLoading: false);
    print(response.body);
    if (response.statusCode == 200) {
      //dao.deleteAllBloodIssue(list);
      dao.setPosted();
      showCommonSnackBar(message: 'Uploaded Issue List Successfully');
    } else if (response.statusCode == 401) {
      Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
        (_) => false,
      );
      showCommonSnackBar(message: 'Session Expired!', bgColor: Colors.red);
    } else {
      showCommonSnackBar(message: 'Something went wrong!', bgColor: Colors.red);
    }
  }
}

final uploadControllerProvider = StateNotifierProvider<UploadController, BloodDataState>((ref) {
  return UploadController(ref);
});
