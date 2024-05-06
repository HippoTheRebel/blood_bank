import 'package:floor/floor.dart';

// class DDRFormTable {
//   @PrimaryKey(autoGenerate: true)
//   int? donorId;
//
//   @ColumnInfo(name: 'name')
//   String name;
//
//   DDRFormTable({this.donorId, required this.name});
// }
@Entity(tableName: 'DDRFormTable')
class DDRFormTable {
  @PrimaryKey(autoGenerate: true)
  int? donorId;

  @ColumnInfo(name: 'object_id')
  String? objectId;

  @ColumnInfo(name: 'name')
  String? name;

  @ColumnInfo(name: 'age')
  int? age;

  @ColumnInfo(name: 'father_name')
  String? fatherName;

  @ColumnInfo(name: 'mother_name')
  String? motherName;

  @ColumnInfo(name: 'sex')
  String? sex;

  @ColumnInfo(name: 'sbp')
  int? sbp;

  @ColumnInfo(name: 'dbp')
  int? dbp;

  @ColumnInfo(name: 'male_hemoglobin')
  double? maleHemoglobin;

  @ColumnInfo(name: 'female_hemoglobin')
  double? femaleHemoglobin;

  @ColumnInfo(name: 'previous_donation')
  String? previousDonation;

  @ColumnInfo(name: 'donated_time')
  int? donatedTime;

  @ColumnInfo(name: 'representative_name')
  String? representativeName;

  @ColumnInfo(name: 'info')
  String? info;

  @ColumnInfo(name: 'blood_group')
  String? bloodGroup;

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

  @ColumnInfo(name: 'date_of_screening')
  String? dateOfScreening;

  @ColumnInfo(name: 'date_of_donation')
  String? dateOfDonation;

  @ColumnInfo(name: 'tested_and_checked_by')
  String? testedAndCheckedBy;

  @ColumnInfo(name: 'location')
  String? location;

  @ColumnInfo(name: 'tti_info_added')
  bool? addedtti;

  @ColumnInfo(name: 'rhd_factor')
  String? rhdFactor;

  @ColumnInfo(name: 'last_date_of_donation')
  String? lastDateOfDonation;

  @ColumnInfo(name: 'posted')
  bool? posted;

  DDRFormTable({
    this.donorId,
    required this.objectId,
    required this.name,
    required this.age,
    required this.fatherName,
    required this.motherName,
    required this.sex,
    required this.sbp,
    required this.dbp,
    required this.maleHemoglobin,
    required this.femaleHemoglobin,
    required this.previousDonation,
    required this.donatedTime,
    required this.representativeName,
    required this.info,
    required this.bloodGroup,
    required this.rhdFactor,
    required this.lastDateOfDonation,

    ///tti
    this.hiv,
    this.hbs,
    this.antiHcv,
    this.malariaAg,
    this.syphills,
    this.dateOfScreening,
    this.dateOfDonation,
    this.testedAndCheckedBy,
    this.location,
    this.addedtti,
    this.posted,
  });
}
