import 'package:login_tcc/models/user.dart';
import 'package:login_tcc/repositories/user_repository.dart';
import 'package:login_tcc/services/prefs_service.dart';

class LoginController {
  final User user;

  LoginController({required this.user});

  bool isValid() {
    if (UserRepository.isUser(user)) {
      PrefsService.save(user.email);
      return true;
    }
    return false;
  }
}
