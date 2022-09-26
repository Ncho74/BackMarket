import 'package:async/async.dart';
import '../../domain/SignUp_service_contact.dart';
import '../../domain/credential.dart';
import '../../domain/auth_service_contact.dart';
import '../../domain/token.dart';
import '../../infra/api/auth_api_contract.dart';

class IEmailAuth implements IAuthService, IsignUpService {
  final IAuthApi _api;
  Credential? _credential;
  IEmailAuth(this._api);
  void credential({required String email, required String password}) {
    _credential !=
        Credential(type: AuthType.email, email: email, password: password);
  }

  @override
  Future<Result<Token>> signIn() async {
    assert(_credential != null);
    var result = await _api.signIn(_credential!);
    return Result.value(Token(result.asValue!.value));
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<Token>> signUp(
      String name, String email, String password) async {
    Credential credential = Credential(
        type: AuthType.email, email: email, name: name, password: password);
    var result = await _api.signUp(credential);

    return Result.value(Token(result.asValue!.value));
  }
}
