import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  Future<String?> registerUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException ${e.code}');
      return e.code;
    } on FirebaseException catch (e) {
      print('FirebaseException ${e.code}');
      return e.code;
    }
  }
}