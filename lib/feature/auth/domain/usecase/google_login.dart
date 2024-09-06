import 'package:fpdart/fpdart.dart';

import '../../../../core/error/Failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repository/auth_repository.dart';

class GoogleLogin implements UseCase<String,String> {
  final AuthRepository authRepository;
  const GoogleLogin(this.authRepository);

  @override
  Future<Either<Failure, String>> call( String a) async{
    return await authRepository.loginWithGoogle();

  }

}