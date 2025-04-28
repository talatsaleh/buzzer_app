import 'dart:async';

import 'package:buzzer_app/core/utils/firebase_config.dart';
import 'package:buzzer_app/features/authentication/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

abstract class AuthRemoteDataSource {
  Future<void> sendOtp(String phoneNumber, Function(String, int?) onCodeSent);

  Future<String> verifyOtp(String verificationId, String smsCode);

  Future<String?> getCurrentUserId();

  String? getCurrentUserPhone();

  Future<User?> getUserData(String uid);

  Future<void> setUserData(User user);

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fb.FirebaseAuth _firebaseAuth = FirebaseConfig.auth;

  AuthRemoteDataSourceImpl();

  @override
  Future<void> sendOtp(
      String phoneNumber, Function(String, int?) onCodeSent) async {
    return _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (fb.PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (fb.FirebaseAuthException e) {
        throw Exception(e.message);
      },
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Future<String> verifyOtp(String verificationId, String smsCode) async {
    final fb.AuthCredential credential = fb.PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final fb.UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    final fb.User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      return firebaseUser.uid;
    } else {
      throw Exception("User verification failed");
    }
  }

  @override
  Future<String?> getCurrentUserId() async {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<User> getUserData(String uid) async {
    final doc = await FirebaseConfig.usersCollection.doc(uid).get();
    final phoneNumber = FirebaseConfig.auth.currentUser?.phoneNumber;
    if (doc.exists) {
      return User.fromMap(doc.data() as Map<String, dynamic>,uid);
    } else {
      return User(id: uid, name: '', phone: phoneNumber!);
    }
  }

  @override
  Future<void> setUserData(User user) async {
    return FirebaseConfig.usersCollection.doc(user.id).set(user.toMap());
  }

  @override
  String? getCurrentUserPhone() {
    return _firebaseAuth.currentUser?.phoneNumber;
  }
}
