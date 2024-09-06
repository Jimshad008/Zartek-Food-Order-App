import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:zartek_task/core/error/Failure.dart';
import 'package:zartek_task/feature/home/data/dataSource/home_remote_data_source.dart';
import 'package:zartek_task/feature/home/data/model/category_data_model.dart';
import 'package:zartek_task/feature/home/domain/repository/home_repository.dart';

import '../../../../core/error/exception.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl( this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<CategoryModel>>> fetchDishesAndCategory() async {
    try {
      final categoryList = await homeRemoteDataSource.fetchDishesAndCategory();

      return right(categoryList);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>>> getUserCart({required String id}) async {
    try {
      final res = await homeRemoteDataSource.getUserCart(id: id);

      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addRemoveUpdateItemToCart({required String userId, required DishesModel dish, required bool add}) async {
    try {
      final res = await homeRemoteDataSource.addRemoveUpdateItemToCart(userId: userId, dish: dish, add: add);

      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

}