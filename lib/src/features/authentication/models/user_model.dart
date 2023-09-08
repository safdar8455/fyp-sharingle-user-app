import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * ================
 * Todo: Step -1 [Create Model]
 * ================
 */

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String gender;
  final String socialProfileImage;
  final String updateProfileImage;
  final String joinDate;

  const UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.socialProfileImage,
    required this.updateProfileImage,
    required this.joinDate,
  });

  toJson() {
    return {
      "Full Name": fullName,
      "Email": email,
      "Gender": gender,
      "Social Profile": socialProfileImage,
      "Update Profile": updateProfileImage,
      "Join Date": joinDate,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName: data["Full Name"],
      email: data["Email"],
      gender: data["Gender"],
      socialProfileImage: data["Social Profile"],
      updateProfileImage: data["Update Profile"],
      joinDate: data["Join Date"],
    );
  }
}
