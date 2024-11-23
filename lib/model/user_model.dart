class UserModel {
  final String id;
  final String email;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
}

enum UserRole {
  ADMIN,
  USER,
}

// {
//   "id": "2946e428-04a3-4aa5-939c-34071cb265a9",
//   "createdAt": "2024-09-26T19:15:42.194Z",
//   "updatedAt": "2024-09-26T19:15:42.194Z",
//   "email": "test@gmail.com",
//   "role": "ADMIN"
// }