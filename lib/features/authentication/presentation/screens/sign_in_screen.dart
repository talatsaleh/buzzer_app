import 'package:buzzer_app/core/widgets/stack_background.dart';
import 'package:buzzer_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:buzzer_app/features/authentication/presentation/screens/login_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  final phoneNumberRegex = RegExp(r'^(010|011|012|015)\d{8}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            print('loooooadddddddddiiiiiinnnnng!!!!!!!');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            throw Exception([state.message, state.stackTrace]);
          } else if (state is AuthOtpSent) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  OtpLoginScreen(
                    phoneNumber: _textEditingController.text.trim(),
                    verificationId: state.verificationId,
                  ),
            ));
          }
        },
        builder: (context, state) {
          return StackBackground(
            height: MediaQuery
                .of(context)
                .size
                .height * .61,
            borderRadiusGeometry:
            const BorderRadius.only(bottomRight: Radius.circular(140)),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .64,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40),
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Welcome!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Please enter your phone number to continue using our app.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 32),
                            TextField(
                              controller: _textEditingController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            Center(
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: state is AuthLoading
                                      ? null
                                      : () {
                                    final phoneNumber =
                                    _textEditingController.text
                                        .trim();
                                    if (phoneNumber.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Invalid phone number',
                                          ),
                                        ),
                                      );
                                    } else if (!phoneNumberRegex
                                        .hasMatch(phoneNumber)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Invalid phone number. Ensure it starts with 010, 011, 012, or 015 and is 11 digits long.',
                                          ),
                                        ),
                                      );
                                    } else {
                                      context.read<AuthBloc>().add(
                                          SendOtpEvent(
                                              '+2$phoneNumber'));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFFC107),
                                    // Yellow color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Text(
                                    'NEXT',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'By tapping next you agree to ',
                              style: TextStyle(color: Colors.black87),
                              children: [
                                TextSpan(
                                  text: 'T&C',
                                  style: TextStyle(color: Colors.redAccent),
                                  // Add a gesture recognizer for T&C
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: TextStyle(color: Colors.redAccent),
                                  // Add a gesture recognizer for Privacy Policy
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
