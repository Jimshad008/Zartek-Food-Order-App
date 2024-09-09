import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek_task/core/common/loader.dart';
import 'package:zartek_task/core/utils/order_placed_popup.dart';
import 'package:zartek_task/feature/home/presentation/pages/cart_dishes_widget.dart';

import '../../../auth/data/model/user_data_model.dart';
import '../bloc/home_bloc.dart';

class CartPage extends StatefulWidget {
  final String userId;

  const CartPage({super.key,required this.userId});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int items=0;
  double total=0.0;
  UserDataModel? user;
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeGetUserCart(id: widget.userId));

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
        iconTheme: const IconThemeData(color: Colors.grey),


        automaticallyImplyLeading: true,
        title: Text("Order Summary",style: TextStyle(fontSize:width*0.05,fontWeight: FontWeight.bold,color: Colors.grey ),),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
  listener: (context, state) {
    if(state is HomeSuccess1){
      final res=state.success;
      res.onData((data) {

        user=UserDataModel.fromMap(data.data()as Map<String ,dynamic>);

        if(mounted){
          setState(() {

          });
        }


      });

    }
  },
  builder: (context, state) {
    if(user!=null){
      items=0;
      total=0;
      for(var i in user!.cart){
        total=total+(i.qty*double.parse(i.price));
        items=items+i.qty;
      }
      return user!.cart.isEmpty?Center(child: SizedBox(
        width: width,
        height: height*0.5,
        child: Image.asset("assets/empty_cart.gif"),
      ),):
      SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(physics: const BouncingScrollPhysics(),
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
                                  child: Center(child: Text("${user!.cart.length} Dishes - $items Items",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: width*0.05),)),

                                ),
                                SizedBox(
                                  height: height*0.025,
                                ),
                                SizedBox(
                                  width:width*0.9,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:user!.cart.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          CartDishesWidget(dish: user!.cart[index],userId: widget.userId),
                                          const Divider(thickness: 2,)
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
                                    Text(total.toString(),style: TextStyle(color: Colors.green,fontSize: width*0.055))
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
                        GestureDetector(
                          onTap: () {
                            var res=user!.copyWith(cart: []);
                            user!.reference.update(res.toMap());
                            Navigator.pop(context);
                            showOrderPlacedPoPup(context: context, width: width, height: height);

                          },
                          child: Container(
                            width: width*0.92,
                            height: height*0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width*0.07),
                              color: const Color(0xFF1A3F14),

                            ),
                            child: Center(child: Text("Place Order",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: width*0.05),)),
                          ),
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
      );
    }
    else{
      return const Center(
        child: Loader(),
      );
    }

  },
)
    );
  }
}
