import 'package:buzzer_app/core/widgets/stack_background.dart';
import 'package:buzzer_app/features/authentication/domain/entities/user.dart';
import 'package:buzzer_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/restaurant_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController name = TextEditingController();

  RegisterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StackBackground(
            height: MediaQuery.of(context).size.height,
            borderRadiusGeometry:
                BorderRadius.only(bottomRight: Radius.circular(140)),
            child: BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is NotFullyAuthenticated) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      title: Text(
                        'Hello ${state.phoneNumber}.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .61,
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Register..',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .03),
                              TextField(
                                controller: name,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Full Name',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white24),
                                  ),
                                  labelStyle: TextStyle(color: Colors.white),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .03),
                              TextField(
                                enabled: false, // Phone number is static here
                                decoration: InputDecoration(
                                  labelText: state.phoneNumber,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white24),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .1),
                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: state is NotFullyAuthenticated
                                        ? () {
                                            final newName = name.text.trim();
                                            if (newName.isEmpty ||
                                                newName.length < 6) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Name is not Valid',
                                                  ),
                                                ),
                                              );
                                            } else {
                                              context
                                                  .read<AuthBloc>()
                                                  .add(SetUserDataEvent(User(
                                                    id: state.uid,
                                                    phone: state.phoneNumber,
                                                    name: newName,
                                                  )));
                                            }
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
              },
              listener: (context, state) {
                if (state is AuthLoading) {
                  print('loading!!');
                } else if (state is FullyAuthenticated) {
                  print('fully Authenticated!');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RestaurantsScreen(),
                  ));
                } else if (state is AuthError) {
                  throw Exception(state.message);
                }
              },
            )),
      ),
    );
  }
}
