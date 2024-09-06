
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:zartek_task/core/constant/firebase_constant.dart';
import 'package:zartek_task/feature/auth/data/model/user_data_model.dart';
import '../../../../core/error/exception.dart';
import '../model/category_data_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<CategoryModel>> fetchDishesAndCategory();
  Future <StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>> getUserCart({
    required String id,
  });
  Future<String> addRemoveUpdateItemToCart({required String userId,required DishesModel dish,required bool add});


}
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource{
  final FirebaseFirestore firestore;
  HomeRemoteDataSourceImpl(this.firestore);
  @override
  Future<List<CategoryModel>> fetchDishesAndCategory() async {
    try{
      List<CategoryModel> category=[];
      const String apiUrl ="https://run.mocky.io/v3/18e8dae4-f39d-46bc-9cf6-9f8b97c32f9c";
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List data = jsonData['categories'];
         for (Map<String,dynamic> i in data){
           category.add(CategoryModel.fromMap(i));
         }

       return category;
      } else {
        throw const ServerException( message: 'Failed to load videos');
      }
    }catch (e) {

      throw ServerException(message: e.toString());
    }

  }

  @override
  Future<StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>> getUserCart({required String id,}) async{
  try{
    print(id);
    print("DSAAAAAAAAAAAAAAA");
    return firestore.collection(FirebaseConstants.userCollection).doc(id).snapshots().listen((event) {
    });
  }on FirebaseException catch(e){
    throw ServerException(message: e.toString());
  } catch(e){
    throw ServerException(message: e.toString());
  }
  }

  @override
  Future<String> addRemoveUpdateItemToCart({required String userId, required DishesModel dish, required bool add}) async {
    try{
      UserDataModel? user=await firestore.collection(FirebaseConstants.userCollection).doc(userId).get().then((value) => UserDataModel.fromMap(value.data() as Map<String,dynamic>));
      if(user!=null){
        if(add){
          if(user.cart.isEmpty){
            List<DishesModel> dishList=[];
            var newDish=dish.copyWith(qty: 1);
            dishList.add(newDish);
            var res=user.copyWith(cart: dishList);
            res.reference.update(res.toMap());
            return "";
          }
          else{
            int index=-1;
            for(int i=0;i<user.cart.length;i++ ){
              if(user.cart[i].id==dish.id){
                  index=i;
              }
            }
            if(index==-1){
              List<DishesModel> dishList=[];
              dishList.addAll(user.cart);
              var newDish=dish.copyWith(qty: 1);
              dishList.add(newDish);
              var res=user.copyWith(cart: dishList);
              res.reference.update(res.toMap());
              return "";
            }
            else{
              List<DishesModel> dishList=[];
              dishList.addAll(user.cart);
              var newDish=dishList[index].copyWith(qty:dishList[index].qty+1 );
              dishList[index]=newDish;
              var res=user.copyWith(cart: dishList);
              res.reference.update(res.toMap());
              return "";
            }
          }
        }
        else{
          int index=-1;
          for(int i=0;i<user.cart.length;i++ ){
            if(user.cart[i].id==dish.id){
              index=i;
            }
          }
          if(index==-1){
            return "";
          }
          else{
            List<DishesModel> dishList=[];
            dishList.addAll(user.cart);
            if(dishList[index].qty>1){
              var newDish=dishList[index].copyWith(qty:dishList[index].qty-1 );
              dishList[index]=newDish;
              var res=user.copyWith(cart: dishList);
              res.reference.update(res.toMap());
              return "";
            }
            else{
              dishList.removeAt(index);
              var res=user.copyWith(cart: dishList);
              res.reference.update(res.toMap());
              return "";
            }
          }
        }
      }
      else{
        throw "user not found";
      }

    }on FirebaseException catch(e){
      throw ServerException(message: e.toString());
    } catch(e){
      throw ServerException(message: e.toString());
    }
  }

}