import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek_task/feature/auth/domain/usecase/google_login.dart';
import 'package:zartek_task/feature/home/domain/usecase/add_remove_update_item_to_cart.dart';
import 'package:zartek_task/feature/home/domain/usecase/fetch_dishes_and_category.dart';
import 'package:zartek_task/feature/home/domain/usecase/get_user_cart.dart';
import 'package:zartek_task/feature/home/presentation/bloc/home_bloc.dart';

import 'feature/auth/data/dataSource/auth_remote_data_source.dart';
import 'feature/auth/data/reposiotry/auth_repository_implement.dart';
import 'feature/auth/domain/repository/auth_repository.dart';
import 'feature/auth/domain/usecase/otp_verify.dart';
import 'feature/auth/domain/usecase/phone_login.dart';
import 'feature/auth/presentation/bloc/auth_bloc.dart';
import 'feature/home/data/dataSource/home_remote_data_source.dart';
import 'feature/home/data/repository/home_repository_implement.dart';
import 'feature/home/domain/repository/home_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initHome();


  final firebaseAuth = FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance;
  final googleSignIn=GoogleSignIn();

  serviceLocator.registerLazySingleton(() => firebaseAuth);
  serviceLocator.registerLazySingleton(() => firestore);
  serviceLocator.registerLazySingleton(() => googleSignIn);
}
_initAuth(){
  serviceLocator.registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
      serviceLocator(),serviceLocator(),serviceLocator()
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );


  serviceLocator.registerFactory(
        () => OtpVerify(
      serviceLocator(),
    ),

  );

  serviceLocator.registerFactory(
        () => PhoneLogin(
      serviceLocator(),
    ),

  );

  serviceLocator.registerFactory(
        () => GoogleLogin(
      serviceLocator(),
    ),

  );
  serviceLocator.registerLazySingleton(
        () => AuthBloc(phoneLogin: serviceLocator(), otpVerify: serviceLocator(), googleLogin: serviceLocator(),
    ),
  );
}
_initHome(){
  serviceLocator.registerFactory<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(
       serviceLocator()
    ),
  );
  serviceLocator.registerFactory<HomeRepository>(
        () => HomeRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => AddRemoveUpdateItemToCart(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => GetUserCart(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => FetchDishesAndCategory(
      serviceLocator(),
    ),

  );
  serviceLocator.registerLazySingleton(
        () => HomeBloc(fetchDishesAndCategory:serviceLocator(), getUserCart: serviceLocator() ,addRemoveUpdateItemToCart: serviceLocator()
    ),
  );
}

