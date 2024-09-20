import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // for storing to firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // function for signup

  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firestore
          .collection('user')
          .doc(credential.user!.uid)
          .set({"name": name, "email": email, "password": password});
      res = 'Success';
    } catch (e) {
      // print(e.toString());
    }
    return res;
  }
  // login Function

  Future<String> login(
      {required String email, required String password}) async {
   
    return '';
  }
}
