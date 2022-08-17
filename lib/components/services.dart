import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static void firebaseConnect() async => await Firebase.initializeApp();
}
