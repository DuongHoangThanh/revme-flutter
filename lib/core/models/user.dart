

class User {
  final int id;
  final String username;
  final String email;
  // final List<Map<String, dynamic>> roles;
  final String token;



  User({
    required this.id,
    required this.username,
    required this.email,
    // required this.roles,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      // roles: List<Map<String, dynamic>>.from(json['roles']),
      token: json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      // 'roles': roles,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User{userId: $id, username: $username, email: $email, token: $token}';

  }
}