// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DDRFormDatabaseDao? _ddRFormDatabaseDaoInstance;

  BloodRequestFormDao? _bloodRequestFormDaoInstance;

  BloodIssueFormDao? _bloodIssueFormDaoInstance;

  TransfustionTransmittedInfectionDao?
      _transfustionTransmittedInfectionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DDRFormTable` (`donorId` INTEGER PRIMARY KEY AUTOINCREMENT, `object_id` TEXT, `name` TEXT, `age` INTEGER, `father_name` TEXT, `mother_name` TEXT, `sex` TEXT, `sbp` INTEGER, `dbp` INTEGER, `male_hemoglobin` REAL, `female_hemoglobin` REAL, `previous_donation` TEXT, `donated_time` INTEGER, `representative_name` TEXT, `info` TEXT, `blood_group` TEXT, `hiv` TEXT, `hbs` TEXT, `anti_hcv` TEXT, `malaria_ag` TEXT, `syphills` TEXT, `date_of_screening` TEXT, `date_of_donation` TEXT, `tested_and_checked_by` TEXT, `location` TEXT, `tti_info_added` INTEGER, `rhd_factor` TEXT, `last_date_of_donation` TEXT, `posted` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BloodRequestTable` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `object_id` TEXT, `lab_id` TEXT, `patient_id` TEXT, `age` TEXT, `sex` TEXT, `blood_grouping` TEXT, `history_of_blood_transfuction` TEXT, `reason_of_transfustion` TEXT, `transfusion_reaction` TEXT, `date` TEXT, `time` TEXT, `component` TEXT, `request_by` TEXT, `father_name` TEXT, `location` TEXT, `info` TEXT, `hemoglobin` TEXT, `rhd_factor` TEXT, `posted` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BloodIssueFormTable` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `patient_name` TEXT, `patient_id` INTEGER, `patient_object_id` TEXT, `donor_name` TEXT, `donor_id` INTEGER, `donor_object_id` TEXT, `compatibility_testing` TEXT, `reason_for_blood_request` TEXT, `component` TEXT, `date` TEXT, `time` TEXT, `posted` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TransfustionTransmittedInfectionTable` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `hiv` TEXT, `hbs` TEXT, `anti_hcv` TEXT, `malaria_ag` TEXT, `syphills` TEXT, `donorId` TEXT, `age` TEXT, `sex` TEXT, `date_of_screening` TEXT, `date_of_donation` TEXT, `tested_and_checked_by` TEXT, `posted` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DDRFormDatabaseDao get ddRFormDatabaseDao {
    return _ddRFormDatabaseDaoInstance ??=
        _$DDRFormDatabaseDao(database, changeListener);
  }

  @override
  BloodRequestFormDao get bloodRequestFormDao {
    return _bloodRequestFormDaoInstance ??=
        _$BloodRequestFormDao(database, changeListener);
  }

  @override
  BloodIssueFormDao get bloodIssueFormDao {
    return _bloodIssueFormDaoInstance ??=
        _$BloodIssueFormDao(database, changeListener);
  }

  @override
  TransfustionTransmittedInfectionDao get transfustionTransmittedInfectionDao {
    return _transfustionTransmittedInfectionDaoInstance ??=
        _$TransfustionTransmittedInfectionDao(database, changeListener);
  }
}

class _$DDRFormDatabaseDao extends DDRFormDatabaseDao {
  _$DDRFormDatabaseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _dDRFormTableInsertionAdapter = InsertionAdapter(
            database,
            'DDRFormTable',
            (DDRFormTable item) => <String, Object?>{
                  'donorId': item.donorId,
                  'object_id': item.objectId,
                  'name': item.name,
                  'age': item.age,
                  'father_name': item.fatherName,
                  'mother_name': item.motherName,
                  'sex': item.sex,
                  'sbp': item.sbp,
                  'dbp': item.dbp,
                  'male_hemoglobin': item.maleHemoglobin,
                  'female_hemoglobin': item.femaleHemoglobin,
                  'previous_donation': item.previousDonation,
                  'donated_time': item.donatedTime,
                  'representative_name': item.representativeName,
                  'info': item.info,
                  'blood_group': item.bloodGroup,
                  'hiv': item.hiv,
                  'hbs': item.hbs,
                  'anti_hcv': item.antiHcv,
                  'malaria_ag': item.malariaAg,
                  'syphills': item.syphills,
                  'date_of_screening': item.dateOfScreening,
                  'date_of_donation': item.dateOfDonation,
                  'tested_and_checked_by': item.testedAndCheckedBy,
                  'location': item.location,
                  'tti_info_added':
                      item.addedtti == null ? null : (item.addedtti! ? 1 : 0),
                  'rhd_factor': item.rhdFactor,
                  'last_date_of_donation': item.lastDateOfDonation,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener),
        _dDRFormTableUpdateAdapter = UpdateAdapter(
            database,
            'DDRFormTable',
            ['donorId'],
            (DDRFormTable item) => <String, Object?>{
                  'donorId': item.donorId,
                  'object_id': item.objectId,
                  'name': item.name,
                  'age': item.age,
                  'father_name': item.fatherName,
                  'mother_name': item.motherName,
                  'sex': item.sex,
                  'sbp': item.sbp,
                  'dbp': item.dbp,
                  'male_hemoglobin': item.maleHemoglobin,
                  'female_hemoglobin': item.femaleHemoglobin,
                  'previous_donation': item.previousDonation,
                  'donated_time': item.donatedTime,
                  'representative_name': item.representativeName,
                  'info': item.info,
                  'blood_group': item.bloodGroup,
                  'hiv': item.hiv,
                  'hbs': item.hbs,
                  'anti_hcv': item.antiHcv,
                  'malaria_ag': item.malariaAg,
                  'syphills': item.syphills,
                  'date_of_screening': item.dateOfScreening,
                  'date_of_donation': item.dateOfDonation,
                  'tested_and_checked_by': item.testedAndCheckedBy,
                  'location': item.location,
                  'tti_info_added':
                      item.addedtti == null ? null : (item.addedtti! ? 1 : 0),
                  'rhd_factor': item.rhdFactor,
                  'last_date_of_donation': item.lastDateOfDonation,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener),
        _dDRFormTableDeletionAdapter = DeletionAdapter(
            database,
            'DDRFormTable',
            ['donorId'],
            (DDRFormTable item) => <String, Object?>{
                  'donorId': item.donorId,
                  'object_id': item.objectId,
                  'name': item.name,
                  'age': item.age,
                  'father_name': item.fatherName,
                  'mother_name': item.motherName,
                  'sex': item.sex,
                  'sbp': item.sbp,
                  'dbp': item.dbp,
                  'male_hemoglobin': item.maleHemoglobin,
                  'female_hemoglobin': item.femaleHemoglobin,
                  'previous_donation': item.previousDonation,
                  'donated_time': item.donatedTime,
                  'representative_name': item.representativeName,
                  'info': item.info,
                  'blood_group': item.bloodGroup,
                  'hiv': item.hiv,
                  'hbs': item.hbs,
                  'anti_hcv': item.antiHcv,
                  'malaria_ag': item.malariaAg,
                  'syphills': item.syphills,
                  'date_of_screening': item.dateOfScreening,
                  'date_of_donation': item.dateOfDonation,
                  'tested_and_checked_by': item.testedAndCheckedBy,
                  'location': item.location,
                  'tti_info_added':
                      item.addedtti == null ? null : (item.addedtti! ? 1 : 0),
                  'rhd_factor': item.rhdFactor,
                  'last_date_of_donation': item.lastDateOfDonation,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DDRFormTable> _dDRFormTableInsertionAdapter;

  final UpdateAdapter<DDRFormTable> _dDRFormTableUpdateAdapter;

  final DeletionAdapter<DDRFormTable> _dDRFormTableDeletionAdapter;

  @override
  Stream<List<DDRFormTable>> getAllDDRFormList() {
    return _queryAdapter.queryListStream('select * from DDRFormTable',
        mapper: (Map<String, Object?> row) => DDRFormTable(
            donorId: row['donorId'] as int?,
            objectId: row['object_id'] as String?,
            name: row['name'] as String?,
            age: row['age'] as int?,
            fatherName: row['father_name'] as String?,
            motherName: row['mother_name'] as String?,
            sex: row['sex'] as String?,
            sbp: row['sbp'] as int?,
            dbp: row['dbp'] as int?,
            maleHemoglobin: row['male_hemoglobin'] as double?,
            femaleHemoglobin: row['female_hemoglobin'] as double?,
            previousDonation: row['previous_donation'] as String?,
            donatedTime: row['donated_time'] as int?,
            representativeName: row['representative_name'] as String?,
            info: row['info'] as String?,
            bloodGroup: row['blood_group'] as String?,
            rhdFactor: row['rhd_factor'] as String?,
            lastDateOfDonation: row['last_date_of_donation'] as String?,
            hiv: row['hiv'] as String?,
            hbs: row['hbs'] as String?,
            antiHcv: row['anti_hcv'] as String?,
            malariaAg: row['malaria_ag'] as String?,
            syphills: row['syphills'] as String?,
            dateOfScreening: row['date_of_screening'] as String?,
            dateOfDonation: row['date_of_donation'] as String?,
            testedAndCheckedBy: row['tested_and_checked_by'] as String?,
            location: row['location'] as String?,
            addedtti: row['tti_info_added'] == null
                ? null
                : (row['tti_info_added'] as int) != 0,
            posted: row['posted'] == null ? null : (row['posted'] as int) != 0),
        queryableName: 'DDRFormTable',
        isView: false);
  }

  @override
  Future<List<DDRFormTable>> getAllDDRFormListFuture() async {
    return _queryAdapter.queryList('select * from DDRFormTable',
        mapper: (Map<String, Object?> row) => DDRFormTable(
            donorId: row['donorId'] as int?,
            objectId: row['object_id'] as String?,
            name: row['name'] as String?,
            age: row['age'] as int?,
            fatherName: row['father_name'] as String?,
            motherName: row['mother_name'] as String?,
            sex: row['sex'] as String?,
            sbp: row['sbp'] as int?,
            dbp: row['dbp'] as int?,
            maleHemoglobin: row['male_hemoglobin'] as double?,
            femaleHemoglobin: row['female_hemoglobin'] as double?,
            previousDonation: row['previous_donation'] as String?,
            donatedTime: row['donated_time'] as int?,
            representativeName: row['representative_name'] as String?,
            info: row['info'] as String?,
            bloodGroup: row['blood_group'] as String?,
            rhdFactor: row['rhd_factor'] as String?,
            lastDateOfDonation: row['last_date_of_donation'] as String?,
            hiv: row['hiv'] as String?,
            hbs: row['hbs'] as String?,
            antiHcv: row['anti_hcv'] as String?,
            malariaAg: row['malaria_ag'] as String?,
            syphills: row['syphills'] as String?,
            dateOfScreening: row['date_of_screening'] as String?,
            dateOfDonation: row['date_of_donation'] as String?,
            testedAndCheckedBy: row['tested_and_checked_by'] as String?,
            location: row['location'] as String?,
            addedtti: row['tti_info_added'] == null
                ? null
                : (row['tti_info_added'] as int) != 0,
            posted:
                row['posted'] == null ? null : (row['posted'] as int) != 0));
  }

  @override
  Future<DDRFormTable?> findDonorById(String id) async {
    return _queryAdapter.query(
        'select * from DDRFormTable where object_id = ?1',
        mapper: (Map<String, Object?> row) => DDRFormTable(
            donorId: row['donorId'] as int?,
            objectId: row['object_id'] as String?,
            name: row['name'] as String?,
            age: row['age'] as int?,
            fatherName: row['father_name'] as String?,
            motherName: row['mother_name'] as String?,
            sex: row['sex'] as String?,
            sbp: row['sbp'] as int?,
            dbp: row['dbp'] as int?,
            maleHemoglobin: row['male_hemoglobin'] as double?,
            femaleHemoglobin: row['female_hemoglobin'] as double?,
            previousDonation: row['previous_donation'] as String?,
            donatedTime: row['donated_time'] as int?,
            representativeName: row['representative_name'] as String?,
            info: row['info'] as String?,
            bloodGroup: row['blood_group'] as String?,
            rhdFactor: row['rhd_factor'] as String?,
            lastDateOfDonation: row['last_date_of_donation'] as String?,
            hiv: row['hiv'] as String?,
            hbs: row['hbs'] as String?,
            antiHcv: row['anti_hcv'] as String?,
            malariaAg: row['malaria_ag'] as String?,
            syphills: row['syphills'] as String?,
            dateOfScreening: row['date_of_screening'] as String?,
            dateOfDonation: row['date_of_donation'] as String?,
            testedAndCheckedBy: row['tested_and_checked_by'] as String?,
            location: row['location'] as String?,
            addedtti: row['tti_info_added'] == null
                ? null
                : (row['tti_info_added'] as int) != 0,
            posted: row['posted'] == null ? null : (row['posted'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> setPosted() async {
    await _queryAdapter.queryNoReturn('update DDRFormTable set posted = true');
  }

  @override
  Future<void> addNote(DDRFormTable ddrFormTable) async {
    await _dDRFormTableInsertionAdapter.insert(
        ddrFormTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(DDRFormTable ddrFormTable) async {
    await _dDRFormTableUpdateAdapter.update(
        ddrFormTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(DDRFormTable ddrFormTable) async {
    await _dDRFormTableDeletionAdapter.delete(ddrFormTable);
  }

  @override
  Future<void> deleteAllNote(List<DDRFormTable> ddrFormTable) async {
    await _dDRFormTableDeletionAdapter.deleteList(ddrFormTable);
  }
}

class _$BloodRequestFormDao extends BloodRequestFormDao {
  _$BloodRequestFormDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _bloodRequestTableInsertionAdapter = InsertionAdapter(
            database,
            'BloodRequestTable',
            (BloodRequestTable item) => <String, Object?>{
                  'id': item.id,
                  'object_id': item.objectId,
                  'lab_id': item.labId,
                  'patient_id': item.patientId,
                  'age': item.age,
                  'sex': item.sex,
                  'blood_grouping': item.bloodGrouping,
                  'history_of_blood_transfuction':
                      item.historyOfBloodTransfustion,
                  'reason_of_transfustion': item.reasonOfTransfusion,
                  'transfusion_reaction': item.transfusionReaction,
                  'date': item.date,
                  'time': item.time,
                  'component': item.component,
                  'request_by': item.requestBy,
                  'father_name': item.fatherName,
                  'location': item.location,
                  'info': item.info,
                  'hemoglobin': item.hemoglobin,
                  'rhd_factor': item.rhdFactor,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener),
        _bloodRequestTableUpdateAdapter = UpdateAdapter(
            database,
            'BloodRequestTable',
            ['id'],
            (BloodRequestTable item) => <String, Object?>{
                  'id': item.id,
                  'object_id': item.objectId,
                  'lab_id': item.labId,
                  'patient_id': item.patientId,
                  'age': item.age,
                  'sex': item.sex,
                  'blood_grouping': item.bloodGrouping,
                  'history_of_blood_transfuction':
                      item.historyOfBloodTransfustion,
                  'reason_of_transfustion': item.reasonOfTransfusion,
                  'transfusion_reaction': item.transfusionReaction,
                  'date': item.date,
                  'time': item.time,
                  'component': item.component,
                  'request_by': item.requestBy,
                  'father_name': item.fatherName,
                  'location': item.location,
                  'info': item.info,
                  'hemoglobin': item.hemoglobin,
                  'rhd_factor': item.rhdFactor,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener),
        _bloodRequestTableDeletionAdapter = DeletionAdapter(
            database,
            'BloodRequestTable',
            ['id'],
            (BloodRequestTable item) => <String, Object?>{
                  'id': item.id,
                  'object_id': item.objectId,
                  'lab_id': item.labId,
                  'patient_id': item.patientId,
                  'age': item.age,
                  'sex': item.sex,
                  'blood_grouping': item.bloodGrouping,
                  'history_of_blood_transfuction':
                      item.historyOfBloodTransfustion,
                  'reason_of_transfustion': item.reasonOfTransfusion,
                  'transfusion_reaction': item.transfusionReaction,
                  'date': item.date,
                  'time': item.time,
                  'component': item.component,
                  'request_by': item.requestBy,
                  'father_name': item.fatherName,
                  'location': item.location,
                  'info': item.info,
                  'hemoglobin': item.hemoglobin,
                  'rhd_factor': item.rhdFactor,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BloodRequestTable> _bloodRequestTableInsertionAdapter;

  final UpdateAdapter<BloodRequestTable> _bloodRequestTableUpdateAdapter;

  final DeletionAdapter<BloodRequestTable> _bloodRequestTableDeletionAdapter;

  @override
  Stream<List<BloodRequestTable>> getAllDDRFormList() {
    return _queryAdapter.queryListStream('select * from BloodRequestTable',
        mapper: (Map<String, Object?> row) => BloodRequestTable(
            id: row['id'] as int?,
            objectId: row['object_id'] as String?,
            labId: row['lab_id'] as String?,
            patientId: row['patient_id'] as String?,
            age: row['age'] as String?,
            sex: row['sex'] as String?,
            bloodGrouping: row['blood_grouping'] as String?,
            historyOfBloodTransfustion:
                row['history_of_blood_transfuction'] as String?,
            reasonOfTransfusion: row['reason_of_transfustion'] as String?,
            transfusionReaction: row['transfusion_reaction'] as String?,
            date: row['date'] as String?,
            time: row['time'] as String?,
            component: row['component'] as String?,
            requestBy: row['request_by'] as String?,
            fatherName: row['father_name'] as String?,
            location: row['location'] as String?,
            info: row['info'] as String?,
            hemoglobin: row['hemoglobin'] as String?,
            rhdFactor: row['rhd_factor'] as String?,
            posted: row['posted'] == null ? null : (row['posted'] as int) != 0),
        queryableName: 'BloodRequestTable',
        isView: false);
  }

  @override
  Future<List<BloodRequestTable>> getAllDDRFormListFuture() async {
    return _queryAdapter.queryList('select * from BloodRequestTable',
        mapper: (Map<String, Object?> row) => BloodRequestTable(
            id: row['id'] as int?,
            objectId: row['object_id'] as String?,
            labId: row['lab_id'] as String?,
            patientId: row['patient_id'] as String?,
            age: row['age'] as String?,
            sex: row['sex'] as String?,
            bloodGrouping: row['blood_grouping'] as String?,
            historyOfBloodTransfustion:
                row['history_of_blood_transfuction'] as String?,
            reasonOfTransfusion: row['reason_of_transfustion'] as String?,
            transfusionReaction: row['transfusion_reaction'] as String?,
            date: row['date'] as String?,
            time: row['time'] as String?,
            component: row['component'] as String?,
            requestBy: row['request_by'] as String?,
            fatherName: row['father_name'] as String?,
            location: row['location'] as String?,
            info: row['info'] as String?,
            hemoglobin: row['hemoglobin'] as String?,
            rhdFactor: row['rhd_factor'] as String?,
            posted:
                row['posted'] == null ? null : (row['posted'] as int) != 0));
  }

  @override
  Future<BloodRequestTable?> findPatientById(String id) async {
    return _queryAdapter.query(
        'select * from BloodRequestTable where object_id = ?1',
        mapper: (Map<String, Object?> row) => BloodRequestTable(
            id: row['id'] as int?,
            objectId: row['object_id'] as String?,
            labId: row['lab_id'] as String?,
            patientId: row['patient_id'] as String?,
            age: row['age'] as String?,
            sex: row['sex'] as String?,
            bloodGrouping: row['blood_grouping'] as String?,
            historyOfBloodTransfustion:
                row['history_of_blood_transfuction'] as String?,
            reasonOfTransfusion: row['reason_of_transfustion'] as String?,
            transfusionReaction: row['transfusion_reaction'] as String?,
            date: row['date'] as String?,
            time: row['time'] as String?,
            component: row['component'] as String?,
            requestBy: row['request_by'] as String?,
            fatherName: row['father_name'] as String?,
            location: row['location'] as String?,
            info: row['info'] as String?,
            hemoglobin: row['hemoglobin'] as String?,
            rhdFactor: row['rhd_factor'] as String?,
            posted: row['posted'] == null ? null : (row['posted'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> setPosted() async {
    await _queryAdapter
        .queryNoReturn('update BloodRequestTable set posted = true');
  }

  @override
  Future<void> addBloodRequest(BloodRequestTable ddrFormTable) async {
    await _bloodRequestTableInsertionAdapter.insert(
        ddrFormTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBloodRequest(BloodRequestTable ddrFormTable) async {
    await _bloodRequestTableUpdateAdapter.update(
        ddrFormTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBloodRequest(BloodRequestTable ddrFormTable) async {
    await _bloodRequestTableDeletionAdapter.delete(ddrFormTable);
  }

  @override
  Future<void> deleteAllBloodRequest(
      List<BloodRequestTable> ddrFormTable) async {
    await _bloodRequestTableDeletionAdapter.deleteList(ddrFormTable);
  }
}

class _$BloodIssueFormDao extends BloodIssueFormDao {
  _$BloodIssueFormDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _bloodIssueFormTableInsertionAdapter = InsertionAdapter(
            database,
            'BloodIssueFormTable',
            (BloodIssueFormTable item) => <String, Object?>{
                  'id': item.id,
                  'patient_name': item.patientName,
                  'patient_id': item.patientId,
                  'patient_object_id': item.patientOjectId,
                  'donor_name': item.donorName,
                  'donor_id': item.donorId,
                  'donor_object_id': item.donorObjectId,
                  'compatibility_testing': item.compatibilityTesting,
                  'reason_for_blood_request': item.reasonForBloodRequest,
                  'component': item.component,
                  'date': item.date,
                  'time': item.time,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener),
        _bloodIssueFormTableUpdateAdapter = UpdateAdapter(
            database,
            'BloodIssueFormTable',
            ['id'],
            (BloodIssueFormTable item) => <String, Object?>{
                  'id': item.id,
                  'patient_name': item.patientName,
                  'patient_id': item.patientId,
                  'patient_object_id': item.patientOjectId,
                  'donor_name': item.donorName,
                  'donor_id': item.donorId,
                  'donor_object_id': item.donorObjectId,
                  'compatibility_testing': item.compatibilityTesting,
                  'reason_for_blood_request': item.reasonForBloodRequest,
                  'component': item.component,
                  'date': item.date,
                  'time': item.time,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener),
        _bloodIssueFormTableDeletionAdapter = DeletionAdapter(
            database,
            'BloodIssueFormTable',
            ['id'],
            (BloodIssueFormTable item) => <String, Object?>{
                  'id': item.id,
                  'patient_name': item.patientName,
                  'patient_id': item.patientId,
                  'patient_object_id': item.patientOjectId,
                  'donor_name': item.donorName,
                  'donor_id': item.donorId,
                  'donor_object_id': item.donorObjectId,
                  'compatibility_testing': item.compatibilityTesting,
                  'reason_for_blood_request': item.reasonForBloodRequest,
                  'component': item.component,
                  'date': item.date,
                  'time': item.time,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BloodIssueFormTable>
      _bloodIssueFormTableInsertionAdapter;

  final UpdateAdapter<BloodIssueFormTable> _bloodIssueFormTableUpdateAdapter;

  final DeletionAdapter<BloodIssueFormTable>
      _bloodIssueFormTableDeletionAdapter;

  @override
  Stream<List<BloodIssueFormTable>> getAllDDRFormList() {
    return _queryAdapter.queryListStream('select * from BloodIssueFormTable',
        mapper: (Map<String, Object?> row) => BloodIssueFormTable(
            id: row['id'] as int?,
            patientName: row['patient_name'] as String?,
            patientId: row['patient_id'] as int?,
            patientOjectId: row['patient_object_id'] as String?,
            donorName: row['donor_name'] as String?,
            donorId: row['donor_id'] as int?,
            donorObjectId: row['donor_object_id'] as String?,
            compatibilityTesting: row['compatibility_testing'] as String?,
            reasonForBloodRequest: row['reason_for_blood_request'] as String?,
            component: row['component'] as String?,
            date: row['date'] as String?,
            time: row['time'] as String?,
            posted: row['posted'] == null ? null : (row['posted'] as int) != 0),
        queryableName: 'BloodIssueFormTable',
        isView: false);
  }

  @override
  Future<List<BloodIssueFormTable>> getAllDDRFormListFuture() async {
    return _queryAdapter.queryList('select * from BloodIssueFormTable',
        mapper: (Map<String, Object?> row) => BloodIssueFormTable(
            id: row['id'] as int?,
            patientName: row['patient_name'] as String?,
            patientId: row['patient_id'] as int?,
            patientOjectId: row['patient_object_id'] as String?,
            donorName: row['donor_name'] as String?,
            donorId: row['donor_id'] as int?,
            donorObjectId: row['donor_object_id'] as String?,
            compatibilityTesting: row['compatibility_testing'] as String?,
            reasonForBloodRequest: row['reason_for_blood_request'] as String?,
            component: row['component'] as String?,
            date: row['date'] as String?,
            time: row['time'] as String?,
            posted:
                row['posted'] == null ? null : (row['posted'] as int) != 0));
  }

  @override
  Future<void> setPosted() async {
    await _queryAdapter
        .queryNoReturn('update BloodIssueFormTable set posted = true');
  }

  @override
  Future<void> addBloodIssue(BloodIssueFormTable ddrFormTable) async {
    await _bloodIssueFormTableInsertionAdapter.insert(
        ddrFormTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBloodIssue(BloodIssueFormTable ddrFormTable) async {
    await _bloodIssueFormTableUpdateAdapter.update(
        ddrFormTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBloodIssue(BloodIssueFormTable ddrFormTable) async {
    await _bloodIssueFormTableDeletionAdapter.delete(ddrFormTable);
  }

  @override
  Future<void> deleteAllBloodIssue(
      List<BloodIssueFormTable> ddrFormTable) async {
    await _bloodIssueFormTableDeletionAdapter.deleteList(ddrFormTable);
  }
}

class _$TransfustionTransmittedInfectionDao
    extends TransfustionTransmittedInfectionDao {
  _$TransfustionTransmittedInfectionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _transfustionTransmittedInfectionTableInsertionAdapter =
            InsertionAdapter(
                database,
                'TransfustionTransmittedInfectionTable',
                (TransfustionTransmittedInfectionTable item) =>
                    <String, Object?>{
                      'id': item.id,
                      'hiv': item.hiv,
                      'hbs': item.hbs,
                      'anti_hcv': item.antiHcv,
                      'malaria_ag': item.malariaAg,
                      'syphills': item.syphills,
                      'donorId': item.donorId,
                      'age': item.age,
                      'sex': item.sex,
                      'date_of_screening': item.dateOfScreening,
                      'date_of_donation': item.dateOfDonation,
                      'tested_and_checked_by': item.testedAndCheckedBy,
                      'posted':
                          item.posted == null ? null : (item.posted! ? 1 : 0)
                    },
                changeListener),
        _transfustionTransmittedInfectionTableUpdateAdapter = UpdateAdapter(
            database,
            'TransfustionTransmittedInfectionTable',
            ['id'],
            (TransfustionTransmittedInfectionTable item) => <String, Object?>{
                  'id': item.id,
                  'hiv': item.hiv,
                  'hbs': item.hbs,
                  'anti_hcv': item.antiHcv,
                  'malaria_ag': item.malariaAg,
                  'syphills': item.syphills,
                  'donorId': item.donorId,
                  'age': item.age,
                  'sex': item.sex,
                  'date_of_screening': item.dateOfScreening,
                  'date_of_donation': item.dateOfDonation,
                  'tested_and_checked_by': item.testedAndCheckedBy,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener),
        _transfustionTransmittedInfectionTableDeletionAdapter = DeletionAdapter(
            database,
            'TransfustionTransmittedInfectionTable',
            ['id'],
            (TransfustionTransmittedInfectionTable item) => <String, Object?>{
                  'id': item.id,
                  'hiv': item.hiv,
                  'hbs': item.hbs,
                  'anti_hcv': item.antiHcv,
                  'malaria_ag': item.malariaAg,
                  'syphills': item.syphills,
                  'donorId': item.donorId,
                  'age': item.age,
                  'sex': item.sex,
                  'date_of_screening': item.dateOfScreening,
                  'date_of_donation': item.dateOfDonation,
                  'tested_and_checked_by': item.testedAndCheckedBy,
                  'posted': item.posted == null ? null : (item.posted! ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TransfustionTransmittedInfectionTable>
      _transfustionTransmittedInfectionTableInsertionAdapter;

  final UpdateAdapter<TransfustionTransmittedInfectionTable>
      _transfustionTransmittedInfectionTableUpdateAdapter;

  final DeletionAdapter<TransfustionTransmittedInfectionTable>
      _transfustionTransmittedInfectionTableDeletionAdapter;

  @override
  Stream<List<TransfustionTransmittedInfectionTable>> getAllDDRFormList() {
    return _queryAdapter.queryListStream(
        'select * from TransfustionTransmittedInfectionTable',
        mapper: (Map<String, Object?> row) =>
            TransfustionTransmittedInfectionTable(
                id: row['id'] as int?,
                hiv: row['hiv'] as String?,
                hbs: row['hbs'] as String?,
                antiHcv: row['anti_hcv'] as String?,
                malariaAg: row['malaria_ag'] as String?,
                syphills: row['syphills'] as String?,
                donorId: row['donorId'] as String?,
                age: row['age'] as String?,
                sex: row['sex'] as String?,
                dateOfScreening: row['date_of_screening'] as String?,
                dateOfDonation: row['date_of_donation'] as String?,
                testedAndCheckedBy: row['tested_and_checked_by'] as String?,
                posted:
                    row['posted'] == null ? null : (row['posted'] as int) != 0),
        queryableName: 'TransfustionTransmittedInfectionTable',
        isView: false);
  }

  @override
  Future<List<TransfustionTransmittedInfectionTable>>
      getAllDDRFormListFuture() async {
    return _queryAdapter.queryList(
        'select * from TransfustionTransmittedInfectionTable',
        mapper: (Map<String, Object?> row) =>
            TransfustionTransmittedInfectionTable(
                id: row['id'] as int?,
                hiv: row['hiv'] as String?,
                hbs: row['hbs'] as String?,
                antiHcv: row['anti_hcv'] as String?,
                malariaAg: row['malaria_ag'] as String?,
                syphills: row['syphills'] as String?,
                donorId: row['donorId'] as String?,
                age: row['age'] as String?,
                sex: row['sex'] as String?,
                dateOfScreening: row['date_of_screening'] as String?,
                dateOfDonation: row['date_of_donation'] as String?,
                testedAndCheckedBy: row['tested_and_checked_by'] as String?,
                posted: row['posted'] == null
                    ? null
                    : (row['posted'] as int) != 0));
  }

  @override
  Future<void> setPosted() async {
    await _queryAdapter.queryNoReturn(
        'update TransfustionTransmittedInfectionTable set posted = true');
  }

  @override
  Future<void> addTransfustionTransmitted(
      TransfustionTransmittedInfectionTable ddrFormTable) async {
    await _transfustionTransmittedInfectionTableInsertionAdapter.insert(
        ddrFormTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTransfustionTransmitted(
      TransfustionTransmittedInfectionTable ddrFormTable) async {
    await _transfustionTransmittedInfectionTableUpdateAdapter.update(
        ddrFormTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTransfustionTransmitted(
      TransfustionTransmittedInfectionTable ddrFormTable) async {
    await _transfustionTransmittedInfectionTableDeletionAdapter
        .delete(ddrFormTable);
  }

  @override
  Future<void> deleteAllTransfustionTransmitted(
      List<TransfustionTransmittedInfectionTable> ddrFormTable) async {
    await _transfustionTransmittedInfectionTableDeletionAdapter
        .deleteList(ddrFormTable);
  }
}
