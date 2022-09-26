import '../domain/token.dart';
import 'package:async/async.dart';

abstract class IsignUpService {
  Future<Result<Token>> signUp(String name, String email, String password);
}
