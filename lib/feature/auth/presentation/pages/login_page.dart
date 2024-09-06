import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek_task/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:zartek_task/feature/auth/presentation/pages/phone_login.dart';

import '../../../../core/common/loader.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
       body: SizedBox(
         width: width,
         height: height,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             SizedBox(
               width: width*0.7,
               height: height*0.3,
               child: Image.asset("assets/zartek_logo.png"),
             ),
             Column(
               children: [
                 BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) async {
    if (state is AuthFailure) {
      showSnackBar(context, state.message.toString());
    }
    else if (state is AuthSuccess2) {



        final SharedPreferences local=await SharedPreferences.getInstance();
        local.setString("uid",state.success);
        String data=local.getString("data")??"";
        showSnackBar(context, "Login Successful");
        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => HomePage(id: state.success.toString(),data: data) ,), (route) => false);






    }
  },
  builder: (context, state) {
    if(state is AuthLoading){
      return const Loader();
    }
    else{
      return GestureDetector(
        onTap: () {
        context.read<AuthBloc>().add(AuthGoogleLogin());
        },
        child: Container(
        width: width*0.85,
        height: height*0.07,
        decoration:  BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xF24185F3),Color(0xFF4185F3)]),
            borderRadius: BorderRadius.circular(width*0.085)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: width*0.085,
              height: height*0.06,
              child: Image.asset("assets/google_logo.png"),
            ),

            SizedBox(
              width: width*0.6,
              child: Center(
                child: Text("Google      ",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: width*0.05,
                ),),
              ),
            ),

          ],
        ),
        ),
      );
    }

  },
),
                 SizedBox(height: height*0.02,),
                 GestureDetector(
                   onTap: () {
                     Navigator.of(context).push(PageRouteBuilder(
                         transitionDuration: const Duration(milliseconds: 500),
                         pageBuilder: (context, animation, secondaryAnimation) {
                           return ScaleTransition(
                            alignment: const Alignment(0.3,0.65),
                             scale: animation,
                             child: const PhoneLogin(),
                           );
                         }
                     ));
                   },
                   child: Container(
                     width: width*0.85,
                     height: height*0.07,

                     decoration:  BoxDecoration(
                       gradient: const LinearGradient(colors: [Color(0xFF7BD556),Color(0xFF49A349)]),
                       borderRadius: BorderRadius.circular(width*0.085)
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         SizedBox(
                           width: width*0.085,
                           height: height*0.06,
                           child: const Icon(Icons.phone,color: Colors.white,),
                         ),

                         SizedBox(
                           width: width*0.6,
                           child: Center(
                             child: Text("Phone      ",style: TextStyle(
                               fontWeight: FontWeight.bold,
                               color: Colors.white,
                               fontSize: width*0.05,
                             ),),
                           ),
                         ),

                       ],
                     ),
                   ),
                 ),
               ],
             )
           ],
         ),
       ),
    );
  }
}
