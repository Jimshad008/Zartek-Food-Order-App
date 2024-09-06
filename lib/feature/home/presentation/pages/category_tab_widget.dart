import 'package:flutter/material.dart';
import 'package:zartek_task/feature/home/data/model/category_data_model.dart';
import 'package:zartek_task/feature/home/presentation/pages/dishes_widget.dart';

class CategoryTabWidget extends StatelessWidget {
  final List<DishesModel> dishes;
  final List<DishesModel> cartDishes;
  final String userId;
  const CategoryTabWidget({super.key,required this.dishes,required this.cartDishes,required this.userId});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: height*0.02,),
        SizedBox(
          width: width,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: dishes.length,
            itemBuilder: (context, index) {
            return Column(
              children: [
                DishesWidget(dish: dishes[index],cartDish: cartDishes,userId: userId),
                const Divider()
              ],
            );
          },),
        ),
      ],
    );
  }
}
