import 'package:flutter/material.dart';

showAddonPoPup({required BuildContext context,required double width,required double height,required List addons
}){
  return showDialog(context: context, builder: (context) {
    return AlertDialog(
      actions: [IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: const Text("OK"))],
      title: const Text("AddOns :"),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: width*0.8,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: addons.length,
          itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                width: width*0.75,
                height: height*0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width*0.4,
                        child: Text(addons[index]["name"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: width*0.04),)),
                    Text("INR ${addons[index]["price"]}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: width*0.04),)
                  ],
                ),
              ),
              const Divider()
            ],
          );
        },),
      ),
    );
  },);
}