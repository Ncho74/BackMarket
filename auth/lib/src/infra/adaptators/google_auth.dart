import 'package:async/async.dart';
import '../../domain/credential.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/auth_service_contact.dart';
import '../../domain/token.dart';
import '../../infra/api/auth_api_contract.dart';

class GoogleAuth implements IAuthService {
  final IAuthApi _iAuthApi;
  GoogleSignIn? _googleSignIn;

  GoogleSignInAccount? _currentUser;

  GoogleAuth(this._iAuthApi, [GoogleSignIn? googleSignIn])
      : this._googleSignIn =
            googleSignIn ?? GoogleSignIn(scopes: ['email', 'profile']);

  @override
  Future<Result<Token>> signIn() async {
    if (_currentUser == null) {
      return Result.error('Failed to signin with google');
    }
    await _hanldeGoogleSignin();
    Credential credential = Credential(
        type: AuthType.email,
        email: _currentUser!.email,
        name: _currentUser!.displayName);
    var result = await _iAuthApi.signIn(credential);
    if (result == null) {
      return Result.error(Error);
    }
    return Result.value(Token(result.asValue!.value));
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn!.disconnect();
  }

  _hanldeGoogleSignin() async {
    try {
      _currentUser = await _googleSignIn!.signIn();
    } catch (error) {
      return;
    }
  }
}
