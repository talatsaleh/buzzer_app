import 'package:buzzer_app/core/utils/firebase_config.dart';
import 'package:buzzer_app/core/utils/sharedPreferencesManager.dart';
import 'package:buzzer_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:buzzer_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:buzzer_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:buzzer_app/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:buzzer_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:buzzer_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:buzzer_app/features/cart/domain/usecases/cart_usecases.dart';
import 'package:buzzer_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:buzzer_app/features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'package:buzzer_app/features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'package:buzzer_app/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:buzzer_app/features/restaurant/domain/usecases/restaurants_usecases.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/authentication/data/datasources/auth_remote_data_source.dart';
import 'features/authentication/domain/usecases/sign_in_with_email.dart';

final getIt = GetIt.instance;

void setUp() {
  //bloc
  getIt.registerFactory(
    () => AuthBloc(
        sendOtpUseCase: getIt(),
        verifyOtpUseCase: getIt(),
        getCurrentUserUseCase: getIt(),
        signOutUseCase: getIt(),
        getUserDataUseCase: getIt(),
        setUserDataUseCase: getIt()),
  );
  getIt.registerFactory(
    () => RestaurantBloc(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory(
    () => CartBloc(getIt(), getIt(), getIt(), getIt()),
  );
//Use Cases
  getIt.registerLazySingleton(() => SendOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => VerifyOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserDataUseCase(getIt()));
  getIt.registerLazySingleton(() => SetUserDataUseCase(getIt()));
  getIt.registerLazySingleton(
    () => GetAllRestaurantsUseCase(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetRestaurantDetailsUseCase(getIt()),
  );
  getIt.registerLazySingleton(
    () => SearchRestaurantsUseCase(getIt()),
  );
  getIt.registerLazySingleton(
    () => ClearAllItemsUseCase(getIt()),
  );
  getIt.registerLazySingleton(
    () => AddItemToCartUseCase(getIt()),
  );
  getIt.registerLazySingleton(
    () => RemoveItemFromCartUseCase(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetCartItemsUseCase(getIt()),
  );
//repo
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt()),
  );
//datasource
  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  getIt.registerFactory<RestaurantDataSource>(
    () => RestaurantDataSourceImpl(),
  );
  getIt.registerFactory<CartDataSource>(
    () => CartDataSourceImpl(getIt()),
  );

//core
  getIt.registerFactory(
    () => SharedPreferencesManager(),
  );
}
