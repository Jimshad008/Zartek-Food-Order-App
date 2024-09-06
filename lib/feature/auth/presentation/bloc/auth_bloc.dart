import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:zartek_task/feature/auth/domain/usecase/google_login.dart';
import 'package:zartek_task/feature/auth/domain/usecase/otp_verify.dart';
import 'package:zartek_task/feature/auth/domain/usecase/phone_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PhoneLogin _phoneLogin;
  final OtpVerify _otpVerify;
  final GoogleLogin _googleLogin;
  AuthBloc({
    required PhoneLogin phoneLogin,required OtpVerify otpVerify,required GoogleLogin googleLogin
}) :_googleLogin=googleLogin,_otpVerify=otpVerify,_phoneLogin=phoneLogin, super(AuthInitial()) {
    on<AuthOtpVerify>((event,emit)async{
      emit(AuthLoading());
      final res=await _otpVerify.authRepository.otpVerify(verificationId: event.verificationId, otp: event.otp);
      res.fold(
            (l) => emit(AuthFailure( l.message)),
            (uid) => emit(AuthSuccess( uid)),
      );
    });
    on<AuthPhoneLogin>((event,emit)async{
      emit(AuthLoading());
      final res=await _phoneLogin.authRepository.loginWithPhoneNo(context: event.context,phoneNo: event.phoneNo);
      res.fold(
            (l) => emit(AuthFailure( l.message)),
            (uid) => emit(AuthSuccess( uid)),
      );
    });
    on<AuthGoogleLogin>((event,emit)async{
      emit(AuthLoading());
      final res=await _googleLogin.authRepository.loginWithGoogle();
      res.fold(
            (l) => emit(AuthFailure( l.message)),
            (uid) => emit(AuthSuccess2( uid)),
      );
    });
  }
}
