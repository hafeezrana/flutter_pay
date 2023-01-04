import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SECRET_API', obfuscate: true)
  static final secretkey = _Env.secretkey;
}
