import 'package:flutter/material.dart';
import 'package:zartek_task/feature/home/presentation/pages/cart_dishes_widget.dart';

import '../../data/model/category_data_model.dart';

class CartPage extends StatefulWidget {
  final List<DishesModel> cart;
  const CartPage({super.key,required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int items=0;
  @override
  void initState() {
    for(var i in widget.cart){
      items=items+i.qty;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),


        automaticallyImplyLeading: true,
        title: Text("Order Summary",style: TextStyle(fontSize:width*0.05,fontWeight: FontWeight.bold,color: Colors.grey ),),
      ),
      body: widget.cart.isNotEmpty?Center(child: SizedBox(
        width: width,
        height: height*0.5,
        child: Image.asset("assets/empty_cart.gif"),
      ),):SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,

            children: [
              SizedBox(
                height: height*0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,


                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(

                          width: width*0.92,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width*0.01),
                            boxShadow: [BoxShadow(color: Colors.grey,blurRadius: width*0.01,spreadRadius: width*0.01)]
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(width*0.015),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: width*0.9,
                                  height: height*0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(width*0.01),
                                    color: const Color(0xFF1A3F14)

                                  ),
                                  child: Center(child: Text("${widget.cart.length} Dishes - $items Items",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: width*0.05),)),

                                ),
                                SizedBox(
                                  height: height*0.025,
                                ),
                                SizedBox(
                                  width:width*0.9,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        CartDishesWidget(),
                                        Divider(thickness: 2,)
                                      ],
                                    );
                                  },),
                                ),
                                SizedBox(
                                  height: height*0.025,
                                ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("Total Amount",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: width*0.055)),
                                   Text("65.00",style: TextStyle(color: Colors.green,fontSize: width*0.055))
                                 ],
                               ),
                                SizedBox(
                                  height: height*0.025,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height*0.025,
                        ),
                        Container(
                          width: width*0.92,
                          height: height*0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*0.07),
                            color: const Color(0xFF1A3F14),

                          ),
                          child: Center(child: Text("Place Order",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: width*0.05),)),
                        ),
                        SizedBox(
                          height: height*0.025,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
