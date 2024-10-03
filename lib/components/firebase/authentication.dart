import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get user => _auth.currentUser;

  get uid => user.uid;

  // Creates a new user with email and password
  Future<String?> signUp({required String email, required String password, required String username}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _createUserDocument(username: username, email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null; // Null means success
    } catch (e) {
      return e.toString(); // Return error message in case of failure
    }
  }
  String getUID() {
    return user.uid;
  }

  // Sign in method
  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _saveLoginState();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> _saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }
  Future<void> _clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        await _auth.signInWithCredential(credential);
        await _createUserDocument(username: googleUser!.displayName ?? "Unknown", email: googleUser.email);
        return null; // Indicating success
      }
      return "No Google authentication details received"; // A clear error message
    } catch (e) {
      return e.toString(); // Return error as string
    }
  }

  Future<String?> signUpWithGoogle() async {
    return signInWithGoogle();
  }

  Future<void> _createUserDocument({required String username, required String email}) async {
    final userDoc = _firestore.collection('users').doc(uid);
    final userData = {
      'username': username,
      'email': email,
      'deviceID': '',
      'dateJoined':DateTime.now().millisecondsSinceEpoch / 1000,
    };
    await userDoc.set(userData);
  }
  Future signOut() async {
    await _auth.signOut();
    await _clearLoginState();
  }
  Future<List<int>> getWaterLevel(String date) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('water-drank')
        .doc(date);

    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<int> waterLevels = List<int>.from(data['drank']);
      print('Water levels: $waterLevels'); // Debug print
      return waterLevels;
    } else {
      print('No data found for date $date'); // Debug print
      return [];
    }
  }
  Future<void> deleteAccount(String password) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Reauthenticate user
        AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: password);
        await user.reauthenticateWithCredential(credential);

        // Delete user data from Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // Delete user authentication account
        await user.delete();
        await _clearLoginState();
      }
    } catch (e) {
      print('Error deleting account: $e');
    }
  }

}

