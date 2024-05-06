import 'package:blood_transfusion_register/database/blood_request_forms_database.dart/blood_request_form_table.dart';
import 'package:floor/floor.dart';

import 'blood_issue_form_table.dart';

@dao
abstract class BloodIssueFormDao {
  @Query('select * from BloodIssueFormTable')
  Stream<List<BloodIssueFormTable>> getAllDDRFormList();

  @Query('select * from BloodIssueFormTable')
  Future<List<BloodIssueFormTable>> getAllDDRFormListFuture();

  @insert
  Future<void> addBloodIssue(BloodIssueFormTable ddrFormTable);

  @delete
  Future<void> deleteBloodIssue(BloodIssueFormTable ddrFormTable);

  @update
  Future<void> updateBloodIssue(BloodIssueFormTable ddrFormTable);

  @delete
  Future<void> deleteAllBloodIssue(List<BloodIssueFormTable> ddrFormTable);

  @Query('update BloodIssueFormTable set posted = true')
  Future<void> setPosted();
}
