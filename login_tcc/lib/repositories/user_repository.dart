import 'package:login_tcc/models/user.dart';

class UserRepository {
  static List<User> userRepository = [
    User(email: 'adm@email.com', password: '123'),
    User(email: 'joao@email.com', password: 'j123'),
    User(email: 'maria@email.com', password: 'm123')
  ];

  static bool isUser(User user) {
    var findUser = userRepository
        .where((u) => u.email == user.email && u.password == user.password);
    return findUser.isNotEmpty;
  }
}
