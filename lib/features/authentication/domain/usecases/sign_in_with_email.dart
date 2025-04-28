import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<void> call(String phoneNumber, Function(String, int?) onCodeSent) {
    return repository.sendOtp(phoneNumber, onCodeSent);
  }
}

class GetUserDataUseCase {
  final AuthRepository repository;

  GetUserDataUseCase(this.repository);

  Future<User?> call(String uid) {
    return repository.getUserData(uid);
  }
}

class SetUserDataUseCase {
  final AuthRepository repository;

  SetUserDataUseCase(this.repository);

  Future<void> call(User user) {
    return repository.setUserData(user);
  }
}

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<User> call(String verificationId, String smsCode) {
    return repository.verifyOtp(verificationId, smsCode);
  }
}

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User?> call() {
    return repository.getCurrentUser();
  }
}

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
