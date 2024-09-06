part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}
final class HomeFetchDishesAndCategory extends HomeEvent{
  HomeFetchDishesAndCategory();
}
final class HomeGetUserCart extends HomeEvent{
  final String id;
  HomeGetUserCart({required this. id});
}
final class HomeAddRemoveUpdateItemToCart extends HomeEvent{
  final String userId;
  final DishesModel dish;
  final bool add;

  HomeAddRemoveUpdateItemToCart({required this.userId,required this.add,required this.dish});
}
