import 'package:firebase_auth/firebase_auth.dart';

class FireAuthHelper {
  FireAuthHelper._();

  static FireAuthHelper fireAuthHelper = FireAuthHelper._();
  FirebaseAuth fba = FirebaseAuth.instance;

  Future<String> createAccount(email, password) async {
    UserCredential userCredential = await fba.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user.uid;
  }

  Future<String> getUserAccount(email, password) async {
    UserCredential userCredential =
        await fba.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user.uid;
  }
}
