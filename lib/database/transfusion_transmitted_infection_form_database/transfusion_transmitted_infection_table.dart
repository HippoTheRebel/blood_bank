// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(tableName: 'TransfustionTransmittedInfectionTable')
class TransfustionTransmittedInfectionTable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'hiv')
  String? hiv;

  @ColumnInfo(name: 'hbs')
  String? hbs;

  @ColumnInfo(name: 'anti_hcv')
  String? antiHcv;

  @ColumnInfo(name: 'malaria_ag')
  String? malariaAg;

  @ColumnInfo(name: 'syphills')
  String? syphills;

  @ColumnInfo(name: 'donorId')
  String? donorId;

  @ColumnInfo(name: 'age')
  String? age;

  @ColumnInfo(name: 'sex')
  String? sex;

  @ColumnInfo(name: 'date_of_screening')
  String? dateOfScreening;

  @ColumnInfo(name: 'date_of_donation')
  String? dateOfDonation;

  @ColumnInfo(name: 'tested_and_checked_by')
  String? testedAndCheckedBy;

  @ColumnInfo(name: 'posted')
  bool? posted;

  TransfustionTransmittedInfectionTable({
    this.id,
    required this.hiv,
    required this.hbs,
    required this.antiHcv,
    required this.malariaAg,
    required this.syphills,
    required this.donorId,
    required this.age,
    required this.sex,
    required this.dateOfScreening,
    required this.dateOfDonation,
    required this.testedAndCheckedBy,
    this.posted,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'hiv': hiv,
      'hbs': hbs,
      'antiHcv': antiHcv,
      'malariaAg': malariaAg,
      'syphills': syphills,
      'donorId': donorId,
      'age': age,
      'sex': sex,
      'dateOfScreening': dateOfScreening,
      'dateOfDonation': dateOfDonation,
      'testedAndCheckedBy': testedAndCheckedBy,
    };
  }
}

class TransfustionTransmittedInfectionModel {
  String? hiv;
  String? hbs;
  String? antiHcv;
  String? malariaAg;
  String? syphills;
  String? donorId;
  String? age;
  String? sex;
  String? dateOfScreening;
  String? dateOfDonation;
  String? testedAndCheckedBy;
  TransfustionTransmittedInfectionModel({
    this.hiv,
    this.hbs,
    this.antiHcv,
    this.malariaAg,
    this.syphills,
    this.donorId,
    this.age,
    this.sex,
    this.dateOfScreening,
    this.dateOfDonation,
    this.testedAndCheckedBy,
  });
}
