import 'dart:convert';

import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/models/model_vehicle.dart';

class Submission {
  final int submission_id;
  final String submission_status;
  final String submission_location;
  final String companion_name;
  final String companion_phone_no;
  final String companion_email;
  final String date_time_departure_to_location;
  final String date_time_departure_from_location;
  final String plat_no;
  final int submission_delete_flag;
  final int submission_student_id;
  final int submission_admin_id;
  final int submission_driver_id;
  final int pending_for_head_driver;
  final int person_num;
  final String reason;
  User admin;
  User driver;
  User student;
  // Admin admin;
  // Driver driver;
  Vehicle vehicle;

  Submission({
    this.submission_id,
    this.submission_status,
    this.submission_location,
    this.companion_name,
    this.companion_phone_no,
    this.companion_email,
    this.date_time_departure_to_location,
    this.date_time_departure_from_location,
    this.plat_no,
    this.submission_delete_flag,
    this.submission_student_id,
    this.submission_admin_id,
    this.submission_driver_id,
    this.pending_for_head_driver,
    this.person_num,
    this.reason,
    this.admin,
    this.driver,
    this.student,
    this.vehicle,
  });

  void setAdmin(User user) {
    admin = user;
  }

  void setDriver(User user) {
    driver = user;
  }

  void setStudent(User user) {
    student = user;
  }

  void setVehicle(Vehicle vehicle) {
    this.vehicle = vehicle;
  }

  Submission copyWith({
    int submission_id,
    String submission_status,
    String submission_location,
    String companion_name,
    String companion_phone_no,
    String companion_email,
    String date_time_departure_to_location,
    String date_time_departure_from_location,
    String plat_no,
    int submission_delete_flag,
    int submission_student_id,
    int submission_admin_id,
    int submission_driver_id,
    int pending_for_head_driver,
    int person_num,
    String reason,
    User admin,
    User driver,
    User student,
    Vehicle vehicle,
  }) {
    return Submission(
      submission_id: submission_id ?? this.submission_id,
      submission_status: submission_status ?? this.submission_status,
      submission_location: submission_location ?? this.submission_location,
      companion_name: companion_name ?? this.companion_name,
      companion_phone_no: companion_phone_no ?? this.companion_phone_no,
      companion_email: companion_email ?? this.companion_email,
      date_time_departure_to_location: date_time_departure_to_location ??
          this.date_time_departure_to_location,
      date_time_departure_from_location: date_time_departure_from_location ??
          this.date_time_departure_from_location,
      plat_no: plat_no ?? this.plat_no,
      submission_delete_flag:
          submission_delete_flag ?? this.submission_delete_flag,
      submission_student_id:
          submission_student_id ?? this.submission_student_id,
      submission_admin_id: submission_admin_id ?? this.submission_admin_id,
      submission_driver_id: submission_driver_id ?? this.submission_driver_id,
      pending_for_head_driver:
          pending_for_head_driver ?? this.pending_for_head_driver,
      person_num: person_num ?? this.person_num,
      reason: reason ?? this.reason,
      admin: admin ?? this.admin,
      driver: driver ?? this.driver,
      student: student ?? this.student,
      vehicle: vehicle ?? this.vehicle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'submission_id': submission_id,
      'submission_status': submission_status,
      'submission_location': submission_location,
      'companion_name': companion_name,
      'companion_phone_no': companion_phone_no,
      'companion_email': companion_email,
      'date_time_departure_to_location': date_time_departure_to_location,
      'date_time_departure_from_location': date_time_departure_from_location,
      'plat_no': plat_no,
      'submission_delete_flag': submission_delete_flag,
      'submission_student_id': submission_student_id,
      'submission_admin_id': submission_admin_id,
      'submission_driver_id': submission_driver_id,
      'pending_for_head_driver': pending_for_head_driver,
      'person_num': person_num,
      'reason': reason,
      'admin': admin?.toMap(),
      'driver': driver?.toMap(),
      'student': student?.toMap(),
      'vehicle': vehicle?.toMap(),
    };
  }

  factory Submission.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Submission(
      submission_id: map['submission_id'],
      submission_status: map['submission_status'],
      submission_location: map['submission_location'],
      companion_name: map['companion_name'],
      companion_phone_no: map['companion_phone_no'],
      companion_email: map['companion_email'],
      date_time_departure_to_location: map['date_time_departure_to_location'],
      date_time_departure_from_location:
          map['date_time_departure_from_location'],
      plat_no: map['plat_no'],
      submission_delete_flag: map['submission_delete_flag'],
      submission_student_id: map['submission_student_id'],
      submission_admin_id: map['submission_admin_id'],
      submission_driver_id: map['submission_driver_id'],
      pending_for_head_driver: map['pending_for_head_driver'],
      person_num: map['person_num'],
      reason: map['reason'],
      admin: User.fromMap(map['admin']),
      driver: User.fromMap(map['driver']),
      student: User.fromMap(map['student']),
      vehicle: Vehicle.fromMap(map['vehicle']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Submission.fromJson(String source) =>
      Submission.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Submission(submission_id: $submission_id, submission_status: $submission_status, submission_location: $submission_location, companion_name: $companion_name, companion_phone_no: $companion_phone_no, companion_email: $companion_email, date_time_departure_to_location: $date_time_departure_to_location, date_time_departure_from_location: $date_time_departure_from_location, plat_no: $plat_no, submission_delete_flag: $submission_delete_flag, submission_student_id: $submission_student_id, submission_admin_id: $submission_admin_id, submission_driver_id: $submission_driver_id, pending_for_head_driver: $pending_for_head_driver, person_num: $person_num, reason: $reason, admin: $admin, driver: $driver, student: $student, vehicle: $vehicle)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Submission &&
        o.submission_id == submission_id &&
        o.submission_status == submission_status &&
        o.submission_location == submission_location &&
        o.companion_name == companion_name &&
        o.companion_phone_no == companion_phone_no &&
        o.companion_email == companion_email &&
        o.date_time_departure_to_location == date_time_departure_to_location &&
        o.date_time_departure_from_location ==
            date_time_departure_from_location &&
        o.plat_no == plat_no &&
        o.submission_delete_flag == submission_delete_flag &&
        o.submission_student_id == submission_student_id &&
        o.submission_admin_id == submission_admin_id &&
        o.submission_driver_id == submission_driver_id &&
        o.pending_for_head_driver == pending_for_head_driver &&
        o.person_num == person_num &&
        o.reason == reason &&
        o.admin == admin &&
        o.driver == driver &&
        o.student == student &&
        o.vehicle == vehicle;
  }

  @override
  int get hashCode {
    return submission_id.hashCode ^
        submission_status.hashCode ^
        submission_location.hashCode ^
        companion_name.hashCode ^
        companion_phone_no.hashCode ^
        companion_email.hashCode ^
        date_time_departure_to_location.hashCode ^
        date_time_departure_from_location.hashCode ^
        plat_no.hashCode ^
        submission_delete_flag.hashCode ^
        submission_student_id.hashCode ^
        submission_admin_id.hashCode ^
        submission_driver_id.hashCode ^
        pending_for_head_driver.hashCode ^
        person_num.hashCode ^
        reason.hashCode ^
        admin.hashCode ^
        driver.hashCode ^
        student.hashCode ^
        vehicle.hashCode;
  }
}
