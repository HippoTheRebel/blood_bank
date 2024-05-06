// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(tableName: 'BloodIssueFormTable')
class BloodIssueFormTable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'patient_name')
  String? patientName;

  @ColumnInfo(name: 'patient_id')
  int? patientId; //patient id in db

  @ColumnInfo(name: 'patient_object_id')
  String? patientOjectId; // objectId of patient

  @ColumnInfo(name: 'donor_name')
  String? donorName;

  @ColumnInfo(name: 'donor_id')
  int? donorId; //donorId in db

  @ColumnInfo(name: 'donor_object_id')
  String? donorObjectId; //objectId or donor

  @ColumnInfo(name: 'compatibility_testing')
  String? compatibilityTesting;

  @ColumnInfo(name: 'reason_for_blood_request')
  String? reasonForBloodRequest;

  @ColumnInfo(name: 'component')
  String? component;

  @ColumnInfo(name: 'date')
  String? date;

  @ColumnInfo(name: 'time')
  String? time;

  @ColumnInfo(name: 'posted')
  bool? posted;

  BloodIssueFormTable({
    this.id,
    required this.patientName,
    required this.patientId,
    required this.patientOjectId,
    required this.donorName,
    required this.donorId,
    required this.donorObjectId,
    required this.compatibilityTesting,
    required this.reasonForBloodRequest,
    required this.component,
    required this.date,
    required this.time,
    this.posted,
  });
}
