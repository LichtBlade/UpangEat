class UserModel {
  final int id;
  final String email;
  final String userType;

  UserModel({
    required this.id,
    required this.email,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] as int,
      email: json['email'] as String,
      userType: json['user_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'email': email,
      'user_type': userType,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, email: $email, userType: $userType}';
  }
}
