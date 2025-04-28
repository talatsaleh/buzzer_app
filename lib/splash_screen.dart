import 'package:buzzer_app/core/const/images.dart';
import 'package:buzzer_app/core/widgets/customNavigationBar.dart';
import 'package:buzzer_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:buzzer_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:buzzer_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/restaurant_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            splashScreen,
          ),
        ),
      ),
      child: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) => CircularProgressIndicator(
            color: Colors.redAccent,
          ),
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
              );
            }
            if (state is Authenticated) {
              context
                  .read<AuthBloc>()
                  .add(GetUserDataEvent(state.uid, state.phoneNumber));
            }
            if (state is NotFullyAuthenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(),
                ),
              );
            }
            if (state is FullyAuthenticated) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>  CustomNavigationScreen(),
              ));
            } else {
              print('there is Error!');
            }
          },
        ),
      ),
    );
  }
}
