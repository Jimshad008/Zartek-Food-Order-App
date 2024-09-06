import 'package:flutter/material.dart';
import 'package:zartek_task/core/utils/logout_alert.dart';

class HomeDrawer extends StatelessWidget {
  final String data;
  final String id;
  const HomeDrawer({super.key,required this.data,required this.id});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Drawer(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero, // This makes the drawer rectangular
    ),
      elevation: 0,
      backgroundColor: Colors.white,
      width: width*0.8,
      child: SizedBox(
        child: Column(
          children: [
            Container(
              width: width*0.8,
              height:height*0.25 ,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF7BD556),Color(0xFF49A349)]),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(width*0.05),bottomRight:Radius.circular(width*0.05) )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height*0.1,
                    child: Image.asset("assets/profile.png"),

                  ),
                  SizedBox(
                    width: width*0.78,
                      child: Center(child: Text(data,style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.05)))),
                  SizedBox(
                      width: width*0.78,
                      child: Center(child: Text("ID:${id.substring(0,5)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.05),)))
                ],
              ),

            ),
            SizedBox(
              height: height*0.015,
            ),
            GestureDetector(
              onTap: () => showLogoutDialog(context),
              child: SizedBox(
                child: Row(
                  children: [
                    SizedBox(width: width*0.05,),
                    Icon(Icons.logout,color: Colors.blueGrey,size: width*0.08,),
                    SizedBox(width: width*0.05,),
                    Text("Logout",style: TextStyle(color: Colors.blueGrey,fontSize: width*0.05),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
