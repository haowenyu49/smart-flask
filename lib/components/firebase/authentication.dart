import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  get uid => user.uid;

  //creates a new user with email and password
  Future signUp({required String email, required String password}) async {
    //print(uid);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  String getUID() {
    return user.uid;
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // print(uid);
      // print(email);
      // print(password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}