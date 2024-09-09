import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek_task/core/common/loader.dart';
import 'package:zartek_task/feature/auth/data/model/user_data_model.dart';
import 'package:zartek_task/feature/home/data/model/category_data_model.dart';
import 'package:zartek_task/feature/home/presentation/bloc/home_bloc.dart';
import 'package:zartek_task/feature/home/presentation/pages/cart_page.dart';
import 'package:zartek_task/feature/home/presentation/pages/category_tab_widget.dart';
import 'package:zartek_task/feature/home/presentation/pages/home_drawer.dart';

import '../../../../core/utils/show_snackbar.dart';

class HomePage extends StatefulWidget {
  final String data;
  final String id;

  const HomePage({super.key,required this.data,required this.id});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserDataModel? user;
  List<CategoryModel> category=[];
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeFetchDishesAndCategory());
    context.read<HomeBloc>().add(HomeGetUserCart(id: widget.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return BlocConsumer<HomeBloc, HomeState>(
  listener: (context, state) {
    if (state is HomeFailure) {
      showSnackBar(context, state.message.toString());
    }
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
    if(state is HomeSuccess){

        category=state.success;
        if(mounted){
          setState(() {

          });
        }

    }
  },
  builder: (context, state,) {




    if(user!=null && category.isNotEmpty){

      return DefaultTabController(
        length: category.length,
        child: Scaffold(
            backgroundColor: Colors.white,

            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: true,
                actionsIconTheme:const IconThemeData(color: Colors.black) ,
                iconTheme:const IconThemeData(color: Colors.black),
                bottom: TabBar(

                  isScrollable: true,

                  labelColor: Colors.red, // Selected tab text color
                  unselectedLabelColor: Colors.black, // Unselected tab text color
                  indicatorColor: Colors.red, // Indicator color for selected tab
                  tabs: List.generate(category.length, (index) => Tab(text: category[index].name))
                ),
                actions: [
                  IconButton(onPressed: () {

                    Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return ScaleTransition(
                            alignment: Alignment.topRight,
                            scale: animation,
                            child: CartPage(userId: user?.id??""),
                          );
                        }
                    ));
                  }, icon: Badge(
                      label:Text(user!.cart.length.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                      backgroundColor: Colors.red.shade700,
                      smallSize: width*0.04,
                      child: Icon(CupertinoIcons.cart_fill,size: width*0.08,))),
                  SizedBox(
                    width: width*0.015,
                  )
                ]

            ),
            drawer: HomeDrawer(data: widget.data, id: widget.id),
            body: SizedBox(
              width:  width,
              height: height,
           child: TabBarView(children: List.generate(category.length, (index) => CategoryTabWidget(dishes: category[index].dishes,cartDishes: user?.cart??[],userId: widget.id,))),

            )
        ),
      );
    }
    else {
      if(user==null){
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              actionsIconTheme:const IconThemeData(color: Colors.black) ,
              iconTheme:const IconThemeData(color: Colors.black)
          ),
          drawer: HomeDrawer(data: widget.data, id: widget.id),
          body: const Center(
            child: Loader(),
          ),
        );
      }
      else{
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              actionsIconTheme:const IconThemeData(color: Colors.black) ,
              iconTheme:const IconThemeData(color: Colors.black)  ,
              actions: [
                IconButton(onPressed: () {

                  Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ScaleTransition(
                          scale: animation,
                          child: CartPage(userId: user?.id??"",key: UniqueKey(),),
                        );
                      }
                  ));
                }, icon: Badge(
                    label: Text(user!.cart.length.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                    backgroundColor: Colors.red.shade700,
                    smallSize: width*0.04,
                    child: Icon(CupertinoIcons.cart_fill,size: width*0.08,))),
                SizedBox(
                  width: width*0.015,
                )
              ]

          ),
          drawer: HomeDrawer(data: widget.data, id: widget.id),
          body: const Center(
            child: Loader(),
          ),
        );
      }

    }

  },
);
  }
}
