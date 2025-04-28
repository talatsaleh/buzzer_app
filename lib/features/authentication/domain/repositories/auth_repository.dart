import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String phoneNumber, Function(String, int?) onCodeSent);

  Future<User> verifyOtp(String verificationId, String smsCode);

  Future<User?> getCurrentUser();

  Future<User?> getUserData(String uid);

  Future<void> setUserData(User user);

  Future<void> signOut();
}
