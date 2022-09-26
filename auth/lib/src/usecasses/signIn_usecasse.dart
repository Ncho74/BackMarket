import 'package:async/async.dart';

import '../domain/auth_service_contact.dart';
import '../domain/token.dart';

class SignInUseCasse {
  final IAuthService _authService;
  SignInUseCasse(this._authService);
  Future<Result<Token>> execute() async {
    return await _authService.signIn();
  }
}
