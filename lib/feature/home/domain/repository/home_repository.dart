import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:zartek_task/feature/home/data/model/category_data_model.dart';

import '../../../../core/error/Failure.dart';

abstract interface class HomeRepository {


  Future<Either<Failure, List<CategoryModel>>> fetchDishesAndCategory();
  Future<Either<Failure, StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>>> getUserCart({required String id});
  Future<Either<Failure, String>> addRemoveUpdateItemToCart({required String userId, required DishesModel dish, required bool add});

}