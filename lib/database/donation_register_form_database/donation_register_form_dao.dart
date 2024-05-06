import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_table.dart';
import 'package:floor/floor.dart';

@dao
abstract class DDRFormDatabaseDao {
  @Query('select * from DDRFormTable')
  Stream<List<DDRFormTable>> getAllDDRFormList();

  @Query('select * from DDRFormTable')
  Future<List<DDRFormTable>> getAllDDRFormListFuture();

  @insert
  Future<void> addNote(DDRFormTable ddrFormTable);

  @delete
  Future<void> deleteNote(DDRFormTable ddrFormTable);

  @update
  Future<void> updateNote(DDRFormTable ddrFormTable);

  @delete
  Future<void> deleteAllNote(List<DDRFormTable> ddrFormTable);

  @Query('select * from DDRFormTable where object_id = :id')
  Future<DDRFormTable?> findDonorById(String id);

  @Query('update DDRFormTable set posted = true')
  Future<void> setPosted();
}
