import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? userType;

  const UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'] ?? "",
      userType: json['user_type']?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'user_type': userType,
    };
  }

  @override
  List<Object?> get props => [userId,
    firstName,
    lastName,
    email,
    phoneNumber,
    userType];
}
