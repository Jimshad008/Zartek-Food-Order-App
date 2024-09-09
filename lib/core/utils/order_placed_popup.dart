import 'package:flutter/material.dart';

showOrderPlacedPoPup({required BuildContext context,required double width,required double height}){
  return showDialog(context: context, builder: (context) {
    Future.delayed(const Duration(seconds: 4)).whenComplete((){
      Navigator.pop(context);
    });
    return AlertDialog(

      backgroundColor: Colors.white,
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width*0.8,
              height: height*0.2,
              child: Image.asset("assets/order_placed.gif"),
            ),
            SizedBox(height: height*0.02,),
            Text("Thank You !",style: TextStyle(fontSize: width*0.05,color: Colors.black,fontWeight: FontWeight.bold),),
            Text("Your Order is Successfully ",style: TextStyle(fontSize: width*0.05,color: Colors.black,fontWeight: FontWeight.bold),),
            Text("Placed ! ",style: TextStyle(fontSize: width*0.05,color: Colors.black,fontWeight: FontWeight.bold),),

          ],
        ),
      ),
    );
  },);
}