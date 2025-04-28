import 'package:buzzer_app/core/widgets/stack_background.dart';
import 'package:buzzer_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:buzzer_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/restaurant_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpLoginScreen extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;
  final TextEditingController otpController = TextEditingController();

  OtpLoginScreen(
      {super.key, required this.phoneNumber, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StackBackground(
            height: MediaQuery.of(context).size.height * .65,
            child: BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) => Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    'Login Code',
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
                            'Login by OTP',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Enter the authentication code we sent at}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
                          TextField(
                            enabled: false, // Phone number is static here
                            decoration: InputDecoration(
                              labelText: phoneNumber,
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white24),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
                          TextField(
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Login Code',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white24),
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .1),
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: state is AuthOtpSent
                                    ? () {
                                        final otp = otpController.text.trim();
                                        if (otp.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Invalid phone number',
                                              ),
                                            ),
                                          );
                                        } else {
                                          context
                                              .read<AuthBloc>()
                                              .add(VerifyOtpEvent(
                                                verificationId,
                                                otp,
                                              ));
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
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code?",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle resend OTP
                            },
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              listener: (context, state) {
                if (state is AuthLoading) {
                  print('loading!!');
                } else if (state is Authenticated) {
                  context.read<AuthBloc>().add(GetUserDataEvent(state.uid,phoneNumber));
                } else if (state is NotFullyAuthenticated) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) =>
                          RegisterScreen(),
                    ),
                    (route) => false,
                  );
                } else if (state is FullyAuthenticated) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const RestaurantsScreen(),
                    ),
                    (route) => false,
                  );
                } else if (state is AuthError) {
                  throw Exception(state.message);
                }
              },
            )),
      ),
    );
  }
}
