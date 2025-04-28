import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

class FirebaseConfig {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static CollectionReference get restaurantCollection =>
      fireStore.collection('restaurants');

  static CollectionReference get usersCollection =>
      fireStore.collection('users');

  static CollectionReference get ordersCollection =>
      fireStore.collection('orders');
}
