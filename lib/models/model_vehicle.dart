import 'dart:convert';

class Vehicle {
  final String plat_no;
  final int passenger_no;
  final int vehicle_delete_flag;
  final String vehicle_type;

  Vehicle({
    this.plat_no,
    this.passenger_no,
    this.vehicle_delete_flag,
    this.vehicle_type,
  });

  Vehicle copyWith({
    String plat_no,
    int passenger_no,
    int vehicle_delete_flag,
    String vehicle_type,
  }) {
    return Vehicle(
      plat_no: plat_no ?? this.plat_no,
      passenger_no: passenger_no ?? this.passenger_no,
      vehicle_delete_flag: vehicle_delete_flag ?? this.vehicle_delete_flag,
      vehicle_type: vehicle_type ?? this.vehicle_type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'plat_no': plat_no,
      'passenger_no': passenger_no,
      'vehicle_delete_flag': vehicle_delete_flag,
      'vehicle_type': vehicle_type,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Vehicle(
      plat_no: map['plat_no'],
      passenger_no: map['passenger_no'],
      vehicle_delete_flag: map['vehicle_delete_flag'],
      vehicle_type: map['vehicle_type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vehicle(plat_no: $plat_no, passenger_no: $passenger_no, vehicle_delete_flag: $vehicle_delete_flag, vehicle_type: $vehicle_type)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Vehicle &&
        o.plat_no == plat_no &&
        o.passenger_no == passenger_no &&
        o.vehicle_delete_flag == vehicle_delete_flag &&
        o.vehicle_type == vehicle_type;
  }

  @override
  int get hashCode {
    return plat_no.hashCode ^
        passenger_no.hashCode ^
        vehicle_delete_flag.hashCode ^
        vehicle_type.hashCode;
  }
}
