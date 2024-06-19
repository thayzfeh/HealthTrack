class User {
  final String email;
  final String password;
  final String? username;
  final String? cpf;
  final String? phone;
  final String? birth;
  User(
      {required this.email,
      required this.password,
      this.username,
      this.cpf,
      this.phone,
      this.birth});

  @override
  String toString() {
    return 'E-mail: $email | Password: $password | Username: $username | CPF: $cpf | phone: $phone | Birth: $birth';
  }
}
