import '../domain/SignUp_service_contact.dart';

import '../domain/token.dart';
import 'package:async/async.dart';

class SignIUpUseCasse {
  final IsignUpService _isignUpService;

  SignIUpUseCasse(this._isignUpService);

  Future<Result<Token>> execute(
      String name, String email, String password) async {
    return await _isignUpService.signUp(name, email, password);
  }
}
