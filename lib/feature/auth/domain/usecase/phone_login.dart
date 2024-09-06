import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/Failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repository/auth_repository.dart';

class PhoneLogin implements UseCase<String,LoginParam> {
  final AuthRepository authRepository;
  const PhoneLogin(this.authRepository);

  @override
  Future<Either<Failure, String>> call(LoginParam param) async{
    return await authRepository.loginWithPhoneNo(phoneNo: param.phoneNo,context: param.context);

  }

}
class LoginParam{
  final String phoneNo;
  final BuildContext context;
  LoginParam({required this.context,required this.phoneNo});
}