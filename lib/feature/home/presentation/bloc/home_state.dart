part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeLoading1 extends HomeState {}
final class HomeSuccess extends HomeState{
  final List<CategoryModel> success;
  const HomeSuccess(this.success);
}
final class HomeSuccess1 extends HomeState{
  final StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> success;
  const HomeSuccess1(this.success);
}
final class HomeSuccess2 extends HomeState{
  final String success;
  const HomeSuccess2(this.success);
}
final class HomeFailure extends HomeState {
  final String message;
  const  HomeFailure(this.message);
}
final class HomeFailure2 extends HomeState {

  const HomeFailure2();
}
