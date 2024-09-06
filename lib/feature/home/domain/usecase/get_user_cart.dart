import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/Failure.dart';
import '../../../../core/usecases/usecases.dart';

import '../repository/home_repository.dart';

class GetUserCart implements UseCase<StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>,String> {
  final HomeRepository homeRepository;
  const GetUserCart(this.homeRepository);

  @override
  Future<Either<Failure, StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>>> call( String id) async{
    return await homeRepository.getUserCart(id: id);

  }

}