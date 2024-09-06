import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartDishesWidget extends StatefulWidget {
  const CartDishesWidget({super.key});

  @override
  State<CartDishesWidget> createState() => _CartDishesWidgetState();
}

class _CartDishesWidgetState extends State<CartDishesWidget> {
  List veg=["Spinach Salad","Chocolate Lava Cake","New York Cheesecake","Coca-Cola","Iced Tea"];
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return SizedBox(
      width: width*0.9,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width*0.05,
            child:
              // veg.contains(widget.dish.name)?
            Image.asset("assets/veglogo.png")
                // :Image.asset("assets/nonveglogo.png") ,
          ),
          SizedBox(
            width: width*0.3,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: width*0.3,
                    child: Text("Spinache Salad",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: width*0.05),)),
                SizedBox(
                  height: height*0.01,
                ),
                SizedBox(
                    width: width*0.3,
                    child: Text("INR 20",style: TextStyle(color: Colors.black,fontWeight:FontWeight.w500,fontSize: width*0.045),),),
                SizedBox(
                  height: height*0.01,
                ),
                SizedBox(
                  width: width*0.3,
                  child: Text("115 Calories",style: TextStyle(color: Colors.black,fontWeight:FontWeight.w500,fontSize: width*0.045),),),
                SizedBox(
                  height: height*0.01,
                ),

              ],
            ),

          ),
          Container(
            width: width*0.33,
            height: height*0.06,
            decoration:  BoxDecoration(
               color:  const Color(0xFF1A3F14),
                borderRadius: BorderRadius.circular(width*0.055)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {
                  // context.read<HomeBloc>().add(HomeAddRemoveUpdateItemToCart(userId: widget.userId, add: false, dish: widget.dish));
                }, icon:  Icon(CupertinoIcons.minus,color: Colors.white,weight: 5,size:width*0.08 ),),

                Text("0".toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: width*0.05)),
                IconButton(onPressed: () {
                  // context.read<HomeBloc>().add(HomeAddRemoveUpdateItemToCart(userId: widget.userId, add: true, dish: widget.dish));
                }, icon:  Icon(CupertinoIcons.plus,color: Colors.white,weight: 20,size:width*0.08),)


              ],
            ),
          ),
          SizedBox(
              width: width*0.15,
              height: height*0.1,
              child:Text("INR 20",style: TextStyle(color: Colors.black,fontWeight:FontWeight.w500,fontSize: width*0.045),),),

        ],
      ),
    );
  }
}
