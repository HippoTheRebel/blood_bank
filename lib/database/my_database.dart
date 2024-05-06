// database.dart

// required package imports
import 'dart:async';
import 'package:blood_transfusion_register/database/blood_request_forms_database.dart/blood_request_form_dao.dart';
import 'package:blood_transfusion_register/database/transfusion_transmitted_infection_form_database/transfusion_transmitted_infection_dao.dart';
import 'package:blood_transfusion_register/database/transfusion_transmitted_infection_form_database/transfusion_transmitted_infection_table.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'blood_issue_form_database.dart/blood_issue_form_dao.dart';
import 'blood_issue_form_database.dart/blood_issue_form_table.dart';
import 'blood_request_forms_database.dart/blood_request_form_table.dart';
import 'donation_register_form_database/donation_register_form_dao.dart';
import 'donation_register_form_database/donation_register_form_table.dart';
part 'my_database.g.dart';

@Database(version: 1, entities: [
  DDRFormTable,
  BloodRequestTable,
  BloodIssueFormTable,
  TransfustionTransmittedInfectionTable,
])
abstract class AppDatabase extends FloorDatabase {
  DDRFormDatabaseDao get ddRFormDatabaseDao;
  BloodRequestFormDao get bloodRequestFormDao;
  BloodIssueFormDao get bloodIssueFormDao;
  TransfustionTransmittedInfectionDao get transfustionTransmittedInfectionDao;
}
