import 'dart:async';

import 'package:buzzer_app/core/utils/firebase_config.dart';
import 'package:buzzer_app/features/authentication/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/sign_in_with_email.dart';

// Events
abstract class AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  SendOtpEvent(
    this.phoneNumber,
  );
}

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;

  VerifyOtpEvent(this.verificationId, this.smsCode);
}

class CheckCurrentUserEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class GetUserDataEvent extends AuthEvent {
  final String uid;
  final String phoneNumber;
  GetUserDataEvent(this.uid, this.phoneNumber);
}

class SetUserDataEvent extends AuthEvent {
  final User user;

  SetUserDataEvent(this.user);
}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthOtpSent extends AuthState {
  final String verificationId;

  AuthOtpSent(this.verificationId);
}

class Authenticated extends AuthState {
  final String uid;
  final String phoneNumber;

  Authenticated(this.uid, this.phoneNumber);
}

class NotFullyAuthenticated extends AuthState {
  final String uid;
  final String phoneNumber;
  NotFullyAuthenticated(this.uid, this.phoneNumber);
}

class FullyAuthenticated extends AuthState {
  final User user;

  FullyAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  final StackTrace stackTrace;

  AuthError(this.message, this.stackTrace);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignOutUseCase signOutUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  final SetUserDataUseCase setUserDataUseCase;

  AuthBloc({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.getCurrentUserUseCase,
    required this.signOutUseCase,
    required this.setUserDataUseCase,
    required this.getUserDataUseCase,
  }) : super(AuthInitial()) {
    on<SetUserDataEvent>(_setUserData);
    on<GetUserDataEvent>(_getUserData);
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<CheckCurrentUserEvent>(_onCheckCurrentUser);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final complete = Completer<String>();
      late final String verificationId;
      await sendOtpUseCase(
        event.phoneNumber,
        (p0, p1) async {
          complete.complete(p0);
        },
      );
      verificationId = await complete.future;
      emit(AuthOtpSent(verificationId));
    } catch (e, s) {
      emit(AuthError(e.toString(), s));
    }
  }

  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await verifyOtpUseCase(event.verificationId, event.smsCode);
      emit(Authenticated(user.id,user.phone));
    } catch (e, s) {
      emit(AuthError(e.toString(), s));
    }
  }

  Future<void> _onCheckCurrentUser(
      CheckCurrentUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await getCurrentUserUseCase();
      if (user != null) {
        emit(Authenticated(user.id,user.phone));
      } else {
        emit(AuthInitial());
      }
    } catch (e, s) {
      emit(AuthError(e.toString(), s));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signOutUseCase();
      emit(AuthInitial());
    } catch (e, s) {
      emit(AuthError(e.toString(), s));
    }
  }

  Future<void> _getUserData(
      GetUserDataEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await getUserDataUseCase(event.uid);
      if (user != null) {
        emit(FullyAuthenticated(user));
      } else {
        emit(NotFullyAuthenticated(event.uid,event.phoneNumber));
      }
    } catch (e, s) {
      emit(AuthError(e.toString(), s));
    }
  }

  Future<void> _setUserData(
      SetUserDataEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await setUserDataUseCase(event.user);
      emit(FullyAuthenticated(event.user));
    } catch (e, s) {
      emit(AuthError(e.toString(), s));
    }
  }
}
