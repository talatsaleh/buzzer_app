import 'package:buzzer_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:buzzer_app/features/authentication/domain/entities/user.dart';
import 'package:buzzer_app/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<User?> getCurrentUser() async {
    final userId = await _authRemoteDataSource.getCurrentUserId();
    final phoneNumber =  _authRemoteDataSource.getCurrentUserPhone();
    if (userId != null) {
      return User(id: userId, name: '', phone: phoneNumber??'');
    }
    return null;
  }

  @override
  Future<void> sendOtp(
      String phoneNumber, Function(String, int?) onCodeSent) async {
    return _authRemoteDataSource.sendOtp(phoneNumber, onCodeSent);
  }

  @override
  Future<void> signOut() async {
    await _authRemoteDataSource.signOut();
  }

  @override
  Future<User> verifyOtp(String verificationId, String smsCode) async {
    final userId =
        await _authRemoteDataSource.verifyOtp(verificationId, smsCode);
    final phoneNumber = _authRemoteDataSource.getCurrentUserPhone();
    return User(id: userId, name: '', phone: phoneNumber ?? '');
  }

  @override
  Future<User?> getUserData(String uid) {
    return _authRemoteDataSource.getUserData(uid);
  }

  @override
  Future<void> setUserData(User user) {
    return _authRemoteDataSource.setUserData(user);
  }

  @override
  String? getUserPhoneNumber() {
    return _authRemoteDataSource.getCurrentUserPhone();
  }
}
