import 'package:blood_transfusion_register/database/blood_request_forms_database.dart/blood_request_form_table.dart';
import 'package:blood_transfusion_register/database/transfusion_transmitted_infection_form_database/transfusion_transmitted_infection_table.dart';
import 'package:floor/floor.dart';

@dao
abstract class TransfustionTransmittedInfectionDao {
  @Query('select * from TransfustionTransmittedInfectionTable')
  Stream<List<TransfustionTransmittedInfectionTable>> getAllDDRFormList();

  @Query('select * from TransfustionTransmittedInfectionTable')
  Future<List<TransfustionTransmittedInfectionTable>> getAllDDRFormListFuture();

  @insert
  Future<void> addTransfustionTransmitted(TransfustionTransmittedInfectionTable ddrFormTable);

  @delete
  Future<void> deleteTransfustionTransmitted(TransfustionTransmittedInfectionTable ddrFormTable);

  @update
  Future<void> updateTransfustionTransmitted(TransfustionTransmittedInfectionTable ddrFormTable);

  @delete
  Future<void> deleteAllTransfustionTransmitted(List<TransfustionTransmittedInfectionTable> ddrFormTable);

  @Query('update TransfustionTransmittedInfectionTable set posted = true')
  Future<void> setPosted();
}
