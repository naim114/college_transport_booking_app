import 'dart:convert';

class User {
  final int user_id;
  final String user_full_name;
  final String password;
  final String user_type;
  final String user_phone_number;
  final String user_email;
  final int user_delete_flag;
  final int head_driver;
  final int student_semester;
  final String student_id;
  final String student_class;
  final int user_session;
  final int super_admin;

  User({
    this.user_id,
    this.user_full_name,
    this.password,
    this.user_type,
    this.user_phone_number,
    this.user_email,
    this.user_delete_flag,
    this.head_driver,
    this.student_semester,
    this.student_id,
    this.student_class,
    this.user_session,
    this.super_admin,
  });

  User copyWith({
    int user_id,
    String user_full_name,
    String password,
    String user_type,
    String user_phone_number,
    String user_email,
    int user_delete_flag,
    int head_driver,
    int student_semester,
    String student_id,
    String student_class,
    int user_session,
    int super_admin,
  }) {
    return User(
      user_id: user_id ?? this.user_id,
      user_full_name: user_full_name ?? this.user_full_name,
      password: password ?? this.password,
      user_type: user_type ?? this.user_type,
      user_phone_number: user_phone_number ?? this.user_phone_number,
      user_email: user_email ?? this.user_email,
      user_delete_flag: user_delete_flag ?? this.user_delete_flag,
      head_driver: head_driver ?? this.head_driver,
      student_semester: student_semester ?? this.student_semester,
      student_id: student_id ?? this.student_id,
      student_class: student_class ?? this.student_class,
      user_session: user_session ?? this.user_session,
      super_admin: super_admin ?? this.super_admin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'user_full_name': user_full_name,
      'password': password,
      'user_type': user_type,
      'user_phone_number': user_phone_number,
      'user_email': user_email,
      'user_delete_flag': user_delete_flag,
      'head_driver': head_driver,
      'student_semester': student_semester,
      'student_id': student_id,
      'student_class': student_class,
      'user_session': user_session,
      'super_admin': super_admin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      user_id: map['user_id'],
      user_full_name: map['user_full_name'],
      password: map['password'],
      user_type: map['user_type'],
      user_phone_number: map['user_phone_number'],
      user_email: map['user_email'],
      user_delete_flag: map['user_delete_flag'],
      head_driver: map['head_driver'],
      student_semester: map['student_semester'],
      student_id: map['student_id'],
      student_class: map['student_class'],
      user_session: map['user_session'],
      super_admin: map['super_admin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(user_id: $user_id, user_full_name: $user_full_name, password: $password, user_type: $user_type, user_phone_number: $user_phone_number, user_email: $user_email, user_delete_flag: $user_delete_flag, head_driver: $head_driver, student_semester: $student_semester, student_id: $student_id, student_class: $student_class, user_session: $user_session, super_admin: $super_admin)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.user_id == user_id &&
        o.user_full_name == user_full_name &&
        o.password == password &&
        o.user_type == user_type &&
        o.user_phone_number == user_phone_number &&
        o.user_email == user_email &&
        o.user_delete_flag == user_delete_flag &&
        o.head_driver == head_driver &&
        o.student_semester == student_semester &&
        o.student_id == student_id &&
        o.student_class == student_class &&
        o.user_session == user_session &&
        o.super_admin == super_admin;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        user_full_name.hashCode ^
        password.hashCode ^
        user_type.hashCode ^
        user_phone_number.hashCode ^
        user_email.hashCode ^
        user_delete_flag.hashCode ^
        head_driver.hashCode ^
        student_semester.hashCode ^
        student_id.hashCode ^
        student_class.hashCode ^
        user_session.hashCode ^
        super_admin.hashCode;
  }
}
