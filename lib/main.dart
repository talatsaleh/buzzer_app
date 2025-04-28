import 'package:buzzer_app/core/utils/firebase_config.dart';
import 'package:buzzer_app/core/utils/sharedPreferencesManager.dart';
import 'package:buzzer_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:buzzer_app/features/authentication/presentation/screens/login_code_screen.dart';
import 'package:buzzer_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:buzzer_app/features/cart/presentation/blocs/cart_events.dart';
import 'package:buzzer_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_bloc.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/restaurant_detail_screen.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/restaurants_detail_product_detail_screen.dart';
import 'package:buzzer_app/firebase_options.dart';
import 'package:buzzer_app/injection.dart';
import 'package:buzzer_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/presentation/screens/sign_in_screen.dart';
import 'features/restaurant/presentation/screens/restaurant_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  await FirebaseConfig.init();
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>()..add(CheckCurrentUserEvent()),
        ),
        BlocProvider<RestaurantBloc>(
          create: (context) => getIt<RestaurantBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => getIt<CartBloc>()..add(GetCartItemsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Buzzer App',
        home: SplashScreen(),
      ),
    );
  }
}
