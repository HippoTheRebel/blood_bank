import 'package:blood_transfusion_register/database/donation_register_form_database/donation_register_form_dao.dart';
import 'package:blood_transfusion_register/database/my_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/blood_request_forms_database.dart/blood_request_form_table.dart';
import '../../database/donation_register_form_database/donation_register_form_table.dart';

class BloodDataRepository {
  Future<AppDatabase> getAppDatabase(String dbName) async {
    return await $FloorAppDatabase.databaseBuilder(dbName).build();
  }
}

final bloodDataRepositoryProvider = Provider<BloodDataRepository>((ref) {
  return BloodDataRepository();
});

final getAppDatabaseProvider = FutureProvider.autoDispose.family<AppDatabase, String>((ref, dbName) async {
  return ref.watch(bloodDataRepositoryProvider).getAppDatabase(dbName);
});

final getDonorListProvider = FutureProvider.autoDispose<List<DDRFormTable>>((ref) async {
  final db = await ref.watch(getAppDatabaseProvider('DDRFormTable.db').future);
  final list = await db.ddRFormDatabaseDao.getAllDDRFormListFuture();
  return list;
});

final getDonorListByIdProvider = FutureProvider.family.autoDispose<DDRFormTable, String>((ref, id) async {
  final db = await ref.watch(getAppDatabaseProvider('DDRFormTable.db').future);
  final data = await db.ddRFormDatabaseDao.findDonorById(id);
  return data!;
});

final getPatientListProvider = FutureProvider.autoDispose<List<BloodRequestTable>>((ref) async {
  final db = await ref.watch(getAppDatabaseProvider('BloodRequestTable.db').future);
  final list = await db.bloodRequestFormDao.getAllDDRFormListFuture();
  return list;
});

final getPatientByIdProvider = FutureProvider.family.autoDispose<BloodRequestTable, String>((ref, id) async {
  final db = await ref.watch(getAppDatabaseProvider('BloodRequestTable.db').future);
  final data = await db.bloodRequestFormDao.findPatientById(id);
  return data!;
});
