import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek_task/core/constant/firebase_constant.dart';
import 'package:zartek_task/feature/auth/data/model/user_data_model.dart';
import '../../../../core/error/exception.dart';
import '../../presentation/pages/verify_otp_page.dart';
abstract interface class AuthRemoteDataSource {
  Future<String> loginWithPhoneNo({
    required String phoneNo,
    required BuildContext context,
  });
  Future<String>verifyOtp({
    required String verificationId,
    required String otp
  });
  Future<String>loginWithGoogle();


}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;
  const AuthRemoteDataSourceImpl(this.firebaseAuth,this.firestore,this.googleSignIn);

  @override
  Future<String> loginWithPhoneNo({
    required String phoneNo,
    required BuildContext  context
  }) async {
    try {
       String result="";
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: "+91$phoneNo",
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
            await firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException error) {

             result=error.message!;

          },
          codeSent: (String verificationId, int? forceResendingToken) {
            result="1";
            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) =>  VerifyOtpPage(phoneNo: phoneNo,verificationId: verificationId),), (route) => false);

          },
          codeAutoRetrievalTimeout: (String verificationId) {});
if(result.isEmpty){
  return "";
}
else{
  return result;
}

    }on FirebaseAuthException catch(e){
      throw ServerException(message: e.toString());
    }
    catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> verifyOtp({required String verificationId, required String otp}) async{
    try{
      PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
      final res=await firebaseAuth.signInWithCredential(credential);
      if(res.user==null){
        throw const ServerException(message: "Invalid Otp");
      }
      else{
        var doc=firestore.collection(FirebaseConstants.userCollection).doc(res.user?.uid);
        var user=UserDataModel(data: res.user?.phoneNumber??"", id: res.user?.uid??"",cart: [],reference: doc);
        firestore.collection(FirebaseConstants.userCollection).doc(res.user?.uid).set(user.toMap());
        final SharedPreferences local=await SharedPreferences.getInstance();
        local.setString("data",user.data);
      }
      return res.user!.uid;
    }on FirebaseAuthException catch(e){
      throw ServerException(message: e.toString());
    }
    catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final res=await firebaseAuth.signInWithCredential(credential);
    if(res.user==null){
      throw const ServerException(message: "Google Signing Failed!");
    }
    else{
      var doc=firestore.collection(FirebaseConstants.userCollection).doc(res.user?.uid);
      var user=UserDataModel(data: res.user?.displayName??"", id: res.user?.uid??"",cart: [],reference: doc);
      firestore.collection(FirebaseConstants.userCollection).doc(res.user?.uid).set(user.toMap());
      final SharedPreferences local=await SharedPreferences.getInstance();
      local.setString("data",user.data);
    }

    return res.user!.uid;

  }


}