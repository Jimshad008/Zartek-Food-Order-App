import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:zartek_task/feature/home/domain/usecase/add_remove_update_item_to_cart.dart';
import 'package:zartek_task/feature/home/domain/usecase/fetch_dishes_and_category.dart';
import 'package:zartek_task/feature/home/domain/usecase/get_user_cart.dart';

import '../../data/model/category_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchDishesAndCategory _fetchDishesAndCategory;
  final GetUserCart _getUserCart;
  final AddRemoveUpdateItemToCart _addRemoveUpdateItemToCart;
  HomeBloc({required FetchDishesAndCategory fetchDishesAndCategory,required GetUserCart getUserCart,required AddRemoveUpdateItemToCart addRemoveUpdateItemToCart}) :_fetchDishesAndCategory=fetchDishesAndCategory,_getUserCart=getUserCart,
        _addRemoveUpdateItemToCart=addRemoveUpdateItemToCart,super(HomeInitial()) {
    on<HomeFetchDishesAndCategory>((event, emit) async {
      emit(HomeLoading());
      final res=await _fetchDishesAndCategory.homeRepository.fetchDishesAndCategory();
      res.fold(
            (l) => emit(HomeFailure( l.message)),
            (category) => emit(HomeSuccess( category)),
      );
    });
    on<HomeGetUserCart>((event, emit) async {
      emit(HomeLoading());
      final res=await _getUserCart.homeRepository.getUserCart(id: event.id);
      res.fold(
            (l) => emit(HomeFailure( l.message)),
            (user){

             emit(HomeSuccess1(user));
            }
      );
    });
    on<HomeAddRemoveUpdateItemToCart>((event, emit) async {
      emit(HomeLoading1());
      final res=await _addRemoveUpdateItemToCart.homeRepository.addRemoveUpdateItemToCart(userId: event.userId, dish: event.dish, add: event.add);
      res.fold(
            (l) => emit(const HomeFailure2()),
            (user){

             emit(HomeSuccess2(user));
            }
      );
    });
  }
}
