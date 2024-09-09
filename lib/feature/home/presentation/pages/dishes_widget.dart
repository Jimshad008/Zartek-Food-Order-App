import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek_task/core/utils/show_addons_popup.dart';
import 'package:zartek_task/feature/home/data/model/category_data_model.dart';
import 'package:zartek_task/feature/home/presentation/bloc/home_bloc.dart';
class DishesWidget extends StatefulWidget {
  final DishesModel dish;
  final List<DishesModel> cartDish;
  final String userId;
  const DishesWidget({super.key,required this.dish,required this.cartDish,required this.userId});

  @override
  State<DishesWidget> createState() => _DishesWidgetState();
}

class _DishesWidgetState extends State<DishesWidget> {
  Map image={
    "Spinach Salad":"https://www.acouplecooks.com/wp-content/uploads/2020/09/Spinach-Salad-010.jpg",
    "Traditional New England Seafood Chowder":"https://www.healthyseasonalrecipes.com/wp-content/uploads/2017/01/healthy-new-england-seafood-chowder-012.jpg",
    "Grilled Chicken Breast":"https://www.cookinwithmima.com/wp-content/uploads/2021/06/Grilled-BBQ-Chicken.jpg",
    "BBQ Pork Ribs":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZCln44yF6vyinYIsxYL32rUA73QiF8u0Dig&s",
    "Grilled Salmon":"https://www.feastingathome.com/wp-content/uploads/2022/08/Grilled-Salmon-10.jpg",
    "Shrimp Scampi":"https://bakerbynature.com/wp-content/uploads/2023/02/shrimp-scampi-119.jpg",
    "Chocolate Lava Cake":"https://sallysbakingaddiction.com/wp-content/uploads/2017/02/chocolate-molten-lava-cakes.jpg",
    "New York Cheesecake":"https://tornadoughalli.com/wp-content/uploads/2018/09/NEW-YORK-STYLE-CHEESECAKE2-2.jpg",
    "Coca-Cola":"https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/15-09-26-RalfR-WLC-0098_-_Coca-Cola_glass_bottle_%28Germany%29.jpg/1200px-15-09-26-RalfR-WLC-0098_-_Coca-Cola_glass_bottle_%28Germany%29.jpg",
    "Iced Tea":"https://natashaskitchen.com/wp-content/uploads/2021/07/Iced-Tea-3-1-728x1092.jpg",

  };
  List veg=["Spinach Salad","Chocolate Lava Cake","New York Cheesecake","Coca-Cola","Iced Tea"];
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return  BlocConsumer<HomeBloc, HomeState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    int currentIndex=-1;
    for(int i=0;i<widget.cartDish.length;i++){
      if(widget.cartDish[i].id==widget.dish.id){
        currentIndex=i;
      }
    }
    return SizedBox(
      width: width*0.96,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width*0.05,
            child: veg.contains(widget.dish.name)?Image.asset("assets/veglogo.png"):Image.asset("assets/nonveglogo.png") ,
          ),
          SizedBox(
            width: width*0.7,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: width*0.7,
                    child: Text(widget.dish.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: width*0.05),)),
                SizedBox(
                  height: height*0.01,
                ),
                SizedBox(
                  width: width*0.69,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.dish.currency} ${widget.dish.price}",style: TextStyle(color: Colors.black,fontWeight:FontWeight.w500,fontSize: width*0.04),),
                      Text("${widget.dish.calories.toStringAsFixed(0)} Calories",style: TextStyle(color: Colors.black,fontWeight:FontWeight.w500,fontSize: width*0.04),),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.01,
                ),
                SizedBox(
                    width: width*0.7,
                    child: Text(widget.dish.description,style: TextStyle(color: Colors.black,fontSize: width*0.038),)
                ),
                SizedBox(
                  height: height*0.01,
                ),
                Container(
                  width: width*0.38,
                  height: height*0.06,
                  decoration:  BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF7BD556),Color(0xFF49A349)]),
                      borderRadius: BorderRadius.circular(width*0.085)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () {
                        context.read<HomeBloc>().add(HomeAddRemoveUpdateItemToCart(userId: widget.userId, add: false, dish: widget.dish));
                      }, icon:  Icon(CupertinoIcons.minus,color: Colors.white,weight: 5,size:width*0.08 ),),

                      Text(currentIndex==-1?"0":widget.cartDish[currentIndex].qty.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: width*0.05)),
                      IconButton(onPressed: () {
                        context.read<HomeBloc>().add(HomeAddRemoveUpdateItemToCart(userId: widget.userId, add: true, dish: widget.dish));
                      }, icon:  Icon(CupertinoIcons.plus,color: Colors.white,weight: 20,size:width*0.08),)


                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.01,
                ),
                widget.dish.addons.isEmpty?const SizedBox():GestureDetector(
                  onTap: () => showAddonPoPup(context: context, width: width, height: height, addons: widget.dish.addons),
                    child: Text("Customizations Available",style: TextStyle(color: Colors.red,fontSize: width*0.04),)),
                SizedBox(
                  height: height*0.01,
                ),

              ],
            ),

          ),
          SizedBox(
            width: width*0.15,
            height: height*0.1,
            child:image[widget.dish.name]==null?CachedNetworkImage(imageUrl:  "https://www.acouplecooks.com/wp-content/uploads/2020/09/Spinach-Salad-010.jpg"):CachedNetworkImage(imageUrl:  image[widget.dish.name])
          )

        ],
      ),
    );
  },
);
  }
}
