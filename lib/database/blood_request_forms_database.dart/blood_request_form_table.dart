// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(tableName: 'BloodRequestTable')
class BloodRequestTable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'object_id')
  String? objectId;

  @ColumnInfo(name: 'lab_id')
  String? labId;

  @ColumnInfo(name: 'patient_id')
  String? patientId; //it is patient name,

  @ColumnInfo(name: 'age')
  String? age;

  @ColumnInfo(name: 'sex')
  String? sex;

  @ColumnInfo(name: 'blood_grouping')
  String? bloodGrouping;

  @ColumnInfo(name: 'history_of_blood_transfuction')
  String? historyOfBloodTransfustion;

  @ColumnInfo(name: 'reason_of_transfustion')
  String? reasonOfTransfusion;

  @ColumnInfo(name: 'transfusion_reaction')
  String? transfusionReaction;

  @ColumnInfo(name: 'date')
  String? date;

  @ColumnInfo(name: 'time')
  String? time;

  @ColumnInfo(name: 'component')
  String? component;

  @ColumnInfo(name: 'request_by')
  String? requestBy;

  @ColumnInfo(name: 'father_name')
  String? fatherName;

  @ColumnInfo(name: 'location')
  String? location;

  @ColumnInfo(name: 'info')
  String? info;

  @ColumnInfo(name: 'hemoglobin')
  String? hemoglobin;

  @ColumnInfo(name: 'rhd_factor')
  String? rhdFactor;

  @ColumnInfo(name: 'posted')
  bool? posted;

  BloodRequestTable({
    this.id,
    required this.objectId,
    required this.labId,
    required this.patientId,
    required this.age,
    required this.sex,
    required this.bloodGrouping,
    required this.historyOfBloodTransfustion,
    required this.reasonOfTransfusion,
    required this.transfusionReaction,
    required this.date,
    required this.time,
    required this.component,
    required this.requestBy,
    required this.fatherName,
    required this.location,
    required this.info,
    required this.hemoglobin,
    required this.rhdFactor,
    this.posted,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'labId': labId,
      'patientId': patientId,
      'age': age,
      'sex': sex,
      'bloodGrouping': bloodGrouping,
      'historyOfBloodTransfustion': historyOfBloodTransfustion,
      'reasonOfTransfusion': reasonOfTransfusion,
      'transfusionReaction': transfusionReaction,
      'date': date,
      'time': time,
      'component': component,
      'requestBy': requestBy,
      'fatherName': fatherName,
      'location': location,
      'info': info,
      'hemoglobin': hemoglobin,
    };
  }
}
