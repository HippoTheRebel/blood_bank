import 'package:blood_transfusion_register/database/blood_request_forms_database.dart/blood_request_form_table.dart';
import 'package:floor/floor.dart';

@dao
abstract class BloodRequestFormDao {
  @Query('select * from BloodRequestTable')
  Stream<List<BloodRequestTable>> getAllDDRFormList();

  @Query('select * from BloodRequestTable')
  Future<List<BloodRequestTable>> getAllDDRFormListFuture();

  @insert
  Future<void> addBloodRequest(BloodRequestTable ddrFormTable);

  @delete
  Future<void> deleteBloodRequest(BloodRequestTable ddrFormTable);

  @update
  Future<void> updateBloodRequest(BloodRequestTable ddrFormTable);

  @delete
  Future<void> deleteAllBloodRequest(List<BloodRequestTable> ddrFormTable);

  @Query('select * from BloodRequestTable where object_id = :id')
  Future<BloodRequestTable?> findPatientById(String id);

  @Query('update BloodRequestTable set posted = true')
  Future<void> setPosted();
}
