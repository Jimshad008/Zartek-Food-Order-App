import 'package:fpdart/src/either.dart';

import 'package:zartek_task/core/error/Failure.dart';
import 'package:zartek_task/feature/home/data/model/category_data_model.dart';

import '../../../../core/usecases/usecases.dart';
import '../repository/home_repository.dart';

class AddRemoveUpdateItemToCart implements UseCase<String,CartParam> {
  final HomeRepository homeRepository;
  const AddRemoveUpdateItemToCart(this.homeRepository);

  @override
  Future<Either<Failure, String>> call(CartParam params) async{
    return await homeRepository.addRemoveUpdateItemToCart(userId: params.userId, dish:params.dish, add: params.add);
  }



}
class CartParam{
  final String userId;
  final DishesModel dish;
  final bool add;
  CartParam({required this.dish,required this.add,required this.userId});
}