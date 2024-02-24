class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  @override
  String toString() {
    return 'E-mail: $email | Password: $password';
  }
}
