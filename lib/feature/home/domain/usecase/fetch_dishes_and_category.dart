import 'package:fpdart/fpdart.dart';
import 'package:zartek_task/feature/home/data/model/category_data_model.dart';
import 'package:zartek_task/feature/home/domain/repository/home_repository.dart';

import '../../../../core/error/Failure.dart';
import '../../../../core/usecases/usecases.dart';

class FetchDishesAndCategory implements UseCase<List<CategoryModel>,String> {
  final HomeRepository homeRepository;
  const FetchDishesAndCategory(this.homeRepository);

  @override
  Future<Either<Failure, List<CategoryModel>>> call( String a) async{
    return await homeRepository.fetchDishesAndCategory();

  }

}