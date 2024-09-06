part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
final class AuthPhoneLogin extends AuthEvent {
  final String phoneNo;
  final BuildContext context;

  AuthPhoneLogin({
    required this.phoneNo,
    required this.context,
  });
}
final class AuthOtpVerify extends AuthEvent{
  final String verificationId;
  final String otp;
  AuthOtpVerify({
    required this.otp,required this.verificationId
  });
}
final class AuthGoogleLogin extends AuthEvent{

  AuthGoogleLogin();
}
