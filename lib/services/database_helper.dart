import 'dart:io';

import 'package:college_transport_booking_app/models/model_submission.dart';
import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/models/model_vehicle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final _databaseName = "db_college_transportation_booking.db";
  static final _databaseVersion = 1;

  //tb_user
  static final tb_user = 'tb_user';

  static final user_id = 'user_id';
  static final password = 'password';
  static final user_type = 'user_type';
  static final user_full_name = 'user_full_name';
  static final user_phone_number = 'user_phone_number';
  static final user_email = 'user_email';
  static final user_delete_flag = 'delete_flag';
  static final user_session = 'user_session';

  static final student_semester = 'student_semester';
  static final student_class = 'student_class';
  static final student_id = 'student_id';

  static final head_driver = 'head_driver';

  static final super_admin = 'super_admin';

  //tb_vehicle
  static final tb_vehicle = 'tb_vehicle';

  static final vehicle_id = 'vehicle_id';
  static final plat_no = 'plat_no';
  static final passenger_no = 'passenger_no';
  static final vehicle_delete_flag = 'vehicle_delete_flag';
  static final vehicle_type = 'vehicle_type';

  //tb_submission
  static final tb_submission = 'tb_submission';

  static final submission_id = 'submission_id';
  static final submission_status = 'submission_status';
  static final submission_location = 'submission_location';
  static final companion_name = 'companion_name';
  static final companion_phone_no = 'companion_phone_no';
  static final companion_email = 'companion_email';
  static final date_time_departure_to_location =
      'date_time_departure_to_location';
  static final date_time_departure_from_location =
      'date_time_departure_from_location';
  static final submission_delete_flag = 'submission_delete_flag';
  static final submission_student_id = 'submission_student_id';
  static final submission_driver_id = 'submission_driver_id';
  static final submission_admin_id = 'submission_admin_id';
  static final person_num = 'person_num';
  static final reason = 'reason';
  static final pending_for_head_driver = 'pending_for_head_driver';

  Map<String, dynamic> defaultStudent = {
    DatabaseHelper.user_type: 'student',
    DatabaseHelper.student_id: 'abc',
    DatabaseHelper.user_full_name: 'abc',
    DatabaseHelper.user_email: 'abc',
    DatabaseHelper.student_class: 'abc',
    DatabaseHelper.password: 'abc',
    DatabaseHelper.user_phone_number: 123,
    DatabaseHelper.student_semester: 123,
  };

  Map<String, dynamic> defaultStudent2 = {
    DatabaseHelper.user_type: 'student',
    DatabaseHelper.student_id: 'student2',
    DatabaseHelper.user_full_name: 'student2',
    DatabaseHelper.user_email: 'student2',
    DatabaseHelper.student_class: 'student2',
    DatabaseHelper.password: 'student2',
    DatabaseHelper.user_phone_number: 123,
    DatabaseHelper.student_semester: 123,
  };

  Map<String, dynamic> defaultDriver = {
    DatabaseHelper.user_type: 'driver',
    DatabaseHelper.student_id: 'none',
    DatabaseHelper.user_full_name: 'driver',
    DatabaseHelper.user_email: 'driver',
    DatabaseHelper.student_class: 'driver',
    DatabaseHelper.password: 'driver',
    DatabaseHelper.user_phone_number: 0192839202123,
    DatabaseHelper.student_semester: 0,
  };

  Map<String, dynamic> defaultDriver2 = {
    DatabaseHelper.user_type: 'driver',
    DatabaseHelper.student_id: 'none',
    DatabaseHelper.user_full_name: 'driver2',
    DatabaseHelper.user_email: 'driver2',
    DatabaseHelper.student_class: 'driver2',
    DatabaseHelper.password: 'driver2',
    DatabaseHelper.user_phone_number: 0192839202123,
    DatabaseHelper.student_semester: 0,
  };

  Map<String, dynamic> defaultSuperAdmin = {
    DatabaseHelper.user_type: 'admin',
    DatabaseHelper.student_id: 'none',
    DatabaseHelper.user_full_name: 'none',
    DatabaseHelper.user_email: 'admin',
    DatabaseHelper.student_class: 'none',
    DatabaseHelper.password: 'admin',
    DatabaseHelper.user_phone_number: 0,
    DatabaseHelper.student_semester: 0,
    DatabaseHelper.super_admin: 1,
    DatabaseHelper.user_session: 1,
  };

  Map<String, dynamic> defaultAdmin2 = {
    DatabaseHelper.user_type: 'admin',
    DatabaseHelper.student_id: 'none',
    DatabaseHelper.user_full_name: 'none',
    DatabaseHelper.user_email: 'admin2',
    DatabaseHelper.student_class: 'none',
    DatabaseHelper.password: 'admin2',
    DatabaseHelper.user_phone_number: 0,
    DatabaseHelper.student_semester: 0,
  };

  Map<String, dynamic> bus1 = {
    DatabaseHelper.passenger_no: 40,
    DatabaseHelper.vehicle_type: 'bus',
    DatabaseHelper.plat_no: 'BUS1024',
  };

  Map<String, dynamic> bus2 = {
    DatabaseHelper.passenger_no: 42,
    DatabaseHelper.vehicle_type: 'bus',
    DatabaseHelper.plat_no: 'BUS2013',
  };

  Map<String, dynamic> van1 = {
    DatabaseHelper.passenger_no: 6,
    DatabaseHelper.vehicle_type: 'van',
    DatabaseHelper.plat_no: 'VAN1113',
  };

  Map<String, dynamic> submission1 = {
    DatabaseHelper.submission_location: 'sub1',
    DatabaseHelper.person_num: 101,
    DatabaseHelper.companion_name: 'sub1',
    DatabaseHelper.companion_phone_no: 'sub1',
    DatabaseHelper.companion_email: 'sub1',
    DatabaseHelper.submission_student_id: 1,
    DatabaseHelper.date_time_departure_to_location:
        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now()).toString(),
    DatabaseHelper.date_time_departure_from_location:
        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now()).toString(),
  };

  Map<String, dynamic> submission2 = {
    DatabaseHelper.submission_location: 'sub2',
    DatabaseHelper.person_num: 101,
    DatabaseHelper.companion_name: 'sub2',
    DatabaseHelper.companion_phone_no: 'sub2',
    DatabaseHelper.companion_email: 'sub2',
    DatabaseHelper.submission_student_id: 1,
    DatabaseHelper.date_time_departure_to_location:
        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now()).toString(),
    DatabaseHelper.date_time_departure_from_location:
        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now()).toString(),
  };

  Map<String, dynamic> submission3 = {
    DatabaseHelper.submission_location: 'sub3',
    DatabaseHelper.person_num: 101,
    DatabaseHelper.companion_name: 'sub3',
    DatabaseHelper.companion_phone_no: 'sub3',
    DatabaseHelper.companion_email: 'sub3',
    DatabaseHelper.submission_student_id: 1,
    DatabaseHelper.date_time_departure_to_location:
        DateFormat('yyyy-MM-dd hh:mm')
            .format(DateTime.now().subtract(Duration()))
            .toString(),
    DatabaseHelper.date_time_departure_from_location:
        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now()).toString(),
  };

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tb_user ("
        "$user_id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$user_full_name TEXT NOT NULL,"
        "$password TEXT NOT NULL,"
        "$user_type TEXT DEFAULT student,"
        "$user_phone_number TEXT NOT NULL,"
        "$user_email TEXT NOT NULL,"
        "$user_delete_flag INTEGER DEFAULT 0,"
        "$head_driver INTEGER DEFAULT 0,"
        "$super_admin INTEGER DEFAULT 0,"
        "$student_semester INTEGER DEFAULT 0,"
        "$student_id TEXT DEFAULT 0,"
        "$student_class TEXT DEFAULT 0,"
        "$user_session INTEGER DEFAULT 0"
        ")");
    await db.execute("CREATE TABLE $tb_vehicle ("
        "$vehicle_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "$plat_no TEXT NOT NULL,"
        "$passenger_no INTEGER DEFAULT 0,"
        "$vehicle_type TEXT NOT NULL,"
        "$vehicle_delete_flag INTEGER DEFAULT 0"
        ")");
    await db.execute("CREATE TABLE $tb_submission ("
        "$submission_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "$submission_status TEXT DEFAULT Pending,"
        "$submission_location TEXT NOT NULL,"
        "$companion_name TEXT DEFAULT none,"
        "$companion_phone_no TEXT DEFAULT none,"
        "$companion_email TEXT DEFAULT none,"
        "$reason TEXT DEFAULT none,"
        "$date_time_departure_to_location TEXT NOT NULL,"
        "$date_time_departure_from_location TEXT NOT NULL,"
        "$submission_delete_flag INTEGER DEFAULT 0,"
        "$pending_for_head_driver INTEGER DEFAULT 0,"
        "$person_num INTEGER NOT NULL,"
        //student
        "$submission_student_id INTEGER,"
        // "FOREIGN KEY ($studentId) REFERENCES tb_admin ($studentId),"
        //admin
        "$submission_admin_id INTEGER,"
        // "FOREIGN KEY ($admin_id) REFERENCES tb_admin ($admin_id),"
        //driver
        "$submission_driver_id INTEGER,"
        // "FOREIGN KEY ($driver_id) REFERENCES tb_driver ($driver_id),"
        //vehicle
        "$plat_no TEXT"
        // "FOREIGN KEY ($plat_no) REFERENCES tb_vehicle ($plat_no)"
        ")");
    await db.insert(DatabaseHelper.tb_user, defaultStudent);
    await db.insert(DatabaseHelper.tb_user, defaultSuperAdmin);
    await db.insert(DatabaseHelper.tb_user, defaultAdmin2);
    await db.insert(DatabaseHelper.tb_user, defaultStudent2);
    await db.insert(DatabaseHelper.tb_user, defaultDriver);
    await db.insert(DatabaseHelper.tb_user, defaultDriver2);
    await db.insert(DatabaseHelper.tb_vehicle, bus1);
    await db.insert(DatabaseHelper.tb_vehicle, bus2);
    await db.insert(DatabaseHelper.tb_vehicle, van1);
    await db.insert(DatabaseHelper.tb_submission, submission1);
    await db.insert(DatabaseHelper.tb_submission, submission2);

    print('****************ALL TABLES CREATION SUCCESSFUL*****************');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> updateByHelper(
    String tableName,
    dynamic columnId,
    Map<String, dynamic> row,
  ) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateByHelperCustom(
    String tableName,
    dynamic whereColumn,
    dynamic columnValue,
    Map<String, dynamic> row,
  ) async {
    Database db = await instance.database;
    return await db.update(tableName, row,
        where: '$whereColumn = $columnValue');
  }

  Future<int> updateSession(
    int user_session,
    String enteredEmail,
  ) async {
    Database db = await instance.database;

    print('Updating session...');
    return await db.rawUpdate('''
      UPDATE ${DatabaseHelper.tb_user} 
      SET ${DatabaseHelper.user_session} = ? 
      WHERE ${DatabaseHelper.user_email} = ?
    ''', [user_session, enteredEmail]);
  }

  Future<int> updateUserProfile(
    String columnId,
    dynamic columnVal,
    String userEmail,
  ) async {
    Database db = await instance.database;

    return await db.rawUpdate('''
      UPDATE ${DatabaseHelper.tb_user} 
      SET $columnId = ? 
      WHERE ${DatabaseHelper.user_email} = ?
    ''', [columnVal, userEmail]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String tableName, String columnId, int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  // Future<int> deleteAllVehicle() async {
  //   Database db = await instance.database;
  //   return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  // }

  Future<User> getLogin(String enteredEmail, String enteredPassword) async {
    Database db = await instance.database;

    var res = await db.rawQuery(
        "SELECT * FROM $tb_user WHERE $user_email = '$enteredEmail' and $password = '$enteredPassword'");

    if (res.length < 0) {
      return null;
    }

    return User.fromMap(res.first);
  }

  Future<User> checkSession() async {
    Database db = await instance.database;
    var res =
        await db.rawQuery("SELECT * FROM $tb_user WHERE $user_session = 1");

    if (res.length > 0) {
      return User.fromMap(res.first);
    }

    return null;
  }

  void printAllData() async {
    final dbHelper = DatabaseHelper.instance;
    List<String> list = [
      'tb_user',
      'tb_vehicle',
      'tb_submission',
    ];
    list.forEach((tableName) async {
      final allRows = await dbHelper.queryAllRows(tableName);
      print('query all rows for $tableName:');
      allRows.forEach((row) {
        print('=======================$tableName=========================');
        print(row);
        print('=======================$tableName=========================');
        Fluttertoast.showToast(msg: '$tableName ==> $row');
      });
    });

    // String tableName = 'tb_driver';
    // final allRows = await dbHelper.queryAllRows(tableName);
    // print('query all rows for $tableName:');
    // allRows.forEach((row) => print(row));
  }

  Future<User> getUserByEmail(String inputEmail) async {
    Database db = await instance.database;

    var res = await db
        .rawQuery("SELECT * FROM $tb_user WHERE $user_email = '$inputEmail'");

    if (res.length < 0) {
      return null;
    }

    return User.fromMap(res.first);
  }

  Future<Vehicle> getVehicleByPlatNo(String platNo) async {
    Database db = await instance.database;

    var res = await db
        .rawQuery("SELECT * FROM $tb_vehicle WHERE $plat_no = '$platNo'");

    if (res.length < 0) {
      return null;
    }

    return Vehicle.fromMap(res.first);
  }

  Future<User> getUserById(int userId) async {
    Database db = await instance.database;

    var res =
        await db.rawQuery("SELECT * FROM $tb_user WHERE $user_id = '$userId'");

    if (res.length < 0) {
      return null;
    }

    return User.fromMap(res.first);
  }

  Future<List<Submission>> getSubmissionByStudentId({
    int studentId,
    String submissionStatus = 'Pending',
  }) async {
    Database db = await instance.database;

    // print('entering getSubmissionByStudentEmail()');
    var res = await db.rawQuery(
        "SELECT * FROM $tb_submission WHERE $submission_student_id = '${studentId.toString()}' and $submission_status = '$submissionStatus'");

    // print('inserted data: ${studentId.toString()} & $submission_status');
    // print('data $res');

    if (res.length < 0) {
      print('couldnt find the submission dumbass');
      return null;
    }

    List<Submission> submission = [];
    res.forEach((sub) {
      submission.add(Submission.fromMap(sub));
    });

    // print('data submission: $submission');
    return submission;
  }

  Future<List<Submission>> getSubmissionByDriverId({
    int driverId,
    String submissionStatus = 'Pending',
  }) async {
    Database db = await instance.database;

    // print('entering getSubmissionByStudentEmail()');
    var res = await db.rawQuery(
        "SELECT * FROM $tb_submission WHERE $submission_driver_id = '${driverId.toString()}' and $submission_status = '$submissionStatus'");

    // print('inserted data: ${studentId.toString()} & $submission_status');
    // print('data $res');

    if (res.length < 0) {
      print('couldnt find the submission dumbass');
      return null;
    }

    List<Submission> submission = [];
    res.forEach((sub) {
      submission.add(Submission.fromMap(sub));
    });

    // print('data submission: $submission');
    return submission;
  }

  // List<Submission> getConfirmedSubmissionByStudentId(int studentId) {
  //   getSubmissionByStudentId(
  //           studentId: studentId, submissionStatus: 'Confirmed')
  //       .then((value) {
  //     return value;
  //   });
  // }

  Map<DateTime, List> getConfirmedSubmission(int studentId) {}

  Future<User> getCurrentUser() async {
    Database db = await instance.database;

    var res =
        await db.rawQuery("SELECT * FROM $tb_user WHERE $user_session = 1");

    if (res.length < 0) {
      return null;
    }

    return User.fromMap(res.first);
  }

  Future<List<Submission>> getAllSubmissionByStudentId({
    int studentId,
  }) async {
    Database db = await instance.database;

    // print('entering getSubmissionByStudentEmail()');
    var res = await db.rawQuery(
        "SELECT * FROM $tb_submission WHERE $submission_student_id = '${studentId.toString()}'");

    // print('inserted data: ${studentId.toString()} & $submission_status');
    // print('data $res');

    if (res.length < 0) {
      print('couldnt find the submission dumbass');
      return null;
    }

    List<Submission> submission = [];
    res.forEach((sub) {
      submission.add(Submission.fromMap(sub));
    });

    // print('data submission: $submission');
    return submission;
  }

  Future<List<Submission>> getAllSubmission({
    String submissionStatus = 'Pending',
  }) async {
    Database db = await instance.database;

    print('entering getAllSubmission()');
    var res = await db.rawQuery(
        "SELECT * FROM $tb_submission WHERE $submission_status = '$submissionStatus'");

    // print('inserted data: ${studentId.toString()} & $submission_status');
    // print('xx data: $res');

    // res.forEach((map) {
    //   map.forEach((key, value) {
    //     print('xx $key ==> ${value.runtimeType} ==> $value');
    //   });
    // });

    if (res.length < 0) {
      print('couldnt find the submission dumbass');
      return null;
    }

    List<Submission> submission = [];
    res.forEach((sub) {
      submission.add(Submission.fromMap(sub));
    });

    print('data submission: $submission');
    return submission;
  }

  Future<List<Submission>> getAllSubmissionByStatus(
      {String subStatus = 'Pending'}) async {
    Database db = await instance.database;

    var res = await db.rawQuery(
        "SELECT * FROM $tb_submission WHERE $submission_status = '$subStatus'");

    if (res.length < 0) {
      print('couldnt find the submission dumbass');
      return null;
    }

    List<Submission> submission = [];
    res.forEach((sub) {
      submission.add(Submission.fromMap(sub));
    });

    print('data submission getAllSubmissionByStatus():  $submission');
    return submission;
  }

  Future<List<User>> getUserListByType(String userType) async {
    Database db = await instance.database;

    var res = await db
        .rawQuery("SELECT * FROM $tb_user WHERE $user_type = '$userType'");

    if (res.length < 0) {
      print('couldnt find the submission dumbass');
      return null;
    }

    List<User> userList = [];
    res.forEach((user) {
      userList.add(User.fromMap(user));
    });

    print('data submission getAllSubmissionByStatus(): $userList');
    return userList;
  }

  Future<List<List<dynamic>>> getAllDriversAndVehicle() async {
    Database db = await instance.database;

    var driverRes =
        await db.rawQuery("SELECT * FROM $tb_user WHERE $user_type = 'driver'");

    if (driverRes.length < 0) {
      print('couldnt find the drivers dumbass');
      return null;
    }

    List<User> driverList = [];
    driverRes.forEach((user) {
      driverList.add(User.fromMap(user));
    });

    print('getting all driver: $driverList');

    var vehicleRes = await db.rawQuery("SELECT * FROM $tb_vehicle");

    if (vehicleRes.length < 0) {
      print('couldnt find the vehicles dumbass');
      return null;
    }

    List<Vehicle> vehicleList = [];
    vehicleRes.forEach((vehicle) {
      vehicleList.add(Vehicle.fromMap(vehicle));
    });

    print('getting all vehicle: $vehicleList');

    List<List<dynamic>> driversVehicleList = [];
    driversVehicleList.add(driverList);
    driversVehicleList.add(vehicleList);

    print('getting all lists: $driversVehicleList');

    return driversVehicleList;
  }

  Future<List<Vehicle>> getAllVehicle() async {
    Database db = await instance.database;

    var res = await db.rawQuery("SELECT * FROM $tb_vehicle");

    if (res.length < 0) {
      print('couldnt find the submission dumbass');
      return null;
    }

    List<Vehicle> vehicleList = [];
    res.forEach((vehicle) {
      vehicleList.add(Vehicle.fromMap(vehicle));
    });

    print('data submission getAllVehicle(): $vehicleList');
    return vehicleList;
  }
}
