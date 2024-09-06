import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';
import '../../../../core/common/loader.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/auth_bloc.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {

  final Telephony telephony = Telephony.instance;
  final TextEditingController phoneNo=TextEditingController();
  @override
  void dispose() {
    super.dispose();
    phoneNo.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),

      body: BlocConsumer<AuthBloc,AuthState>(builder: (context, state) {
        if(state is AuthLoading){
          return const Loader();
        }
        return  SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: width,
            height: height,

            child: Padding(
              padding: EdgeInsets.only(right: width*0.05,left: width*0.05),
              child: Column(
                children: [
                  SizedBox(
                    width: width*0.5,
                    height: height*0.4,
                    child:Image.asset("assets/zartek_logo.png",fit: BoxFit.contain,),

                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: width*0.02),
                    child: SizedBox(
                      width: width,
                      child: Text(
                        "Enter Phone Number",style: TextStyle(
                          fontWeight: FontWeight.bold,fontFamily: "Montserrat",
                          fontSize: width*0.05
                      ),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.02,),
                  SizedBox(
                    width: width*0.9,
                    height: height*0.08,
                    child: TextFormField(

                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      cursorColor: Colors.grey,


                      controller: phoneNo,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Theme.of(context).hintColor,
                          fontSize: width*0.035,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter Phone Number *',
                        hintStyle: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Theme.of(context).hintColor,

                          fontSize: width*0.035,
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF1F54BC),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(
                            color: Color(0xFF1F54BC),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(
                            color:Color(0xFF03AAD6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: height*0.015,left: width*0.05),
                      ),
                      style:TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Theme.of(context).hintColor,
                        fontSize: width*0.035,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  SizedBox(height: height*0.02,),
                  GestureDetector(
                    onTap: () {
                      if(phoneNo.text.trim().length<10){
                        showSnackBar(context, "Please Enter 10 Digit Phone Number");
                      }else{
                        context.read<AuthBloc>().add(AuthPhoneLogin(phoneNo: phoneNo.text.trim(), context: context));
                      }

                    },
                    child: Container(
                      width: width*0.9,
                      height: height*0.07,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF1F54BC),Color(0xFF03AAD6)]),
                          borderRadius: BorderRadius.circular(width*0.08)
                      ),
                      child: Center(child: Text("Get OTP",style: TextStyle(color: Colors.white,fontSize: width*0.05,fontWeight: FontWeight.bold,fontFamily: "Montserrat",),)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        } else if (state is AuthSuccess) {
          state.success=="1"?showSnackBar(context, "Otp sent to your phone number"):
          showSnackBar(context, "Error Occur");
          telephony.requestSmsPermissions;


        }
      },),
    );
  }
}
