import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String email;
  final String name;
  final int age;
  final List<String> sports;
  // prefTime is just a value of selectedIndex now
  final int prefTime;
  final double longitude;
  final double latitude;
  final String profilePic;
  // optional, will deal with this later
  final int gender;
  final String uid;
  const UserModel({
    required this.email,
    required this.name,
    required this.age,
    required this.sports,
    required this.prefTime,
    required this.longitude,
    required this.latitude,
    required this.profilePic,
    required this.gender,
    required this.uid,
  });

  UserModel copyWith({
    String? email,
    String? name,
    int? age,
    List<String>? sports,
    int? prefTime,
    double? longitude,
    double? latitude,
    String? profilePic,
    int? gender,
    String? uid,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      age: age ?? this.age,
      sports: sports ?? this.sports,
      prefTime: prefTime ?? this.prefTime,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      profilePic: profilePic ?? this.profilePic,
      gender: gender ?? this.gender,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'age': age,
      'sports': sports,
      'prefTime': prefTime,
      'longitude': longitude,
      'latitude': latitude,
      'profilePic': profilePic,
      'gender': gender,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      sports: List<String>.from(map['sports']),
      prefTime: map['prefTime']?.toInt() ?? 0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      profilePic: map['profilePic'] ?? '',
      gender: map['gender']?.toInt() ?? 0,
      uid: map['\$id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, age: $age, sports: $sports, prefTime: $prefTime, longitude: $longitude, latitude: $latitude, profilePic: $profilePic, gender: $gender, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.name == name &&
        other.age == age &&
        listEquals(other.sports, sports) &&
        other.prefTime == prefTime &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.profilePic == profilePic &&
        other.gender == gender &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        age.hashCode ^
        sports.hashCode ^
        prefTime.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        profilePic.hashCode ^
        gender.hashCode ^
        uid.hashCode;
  }
}
