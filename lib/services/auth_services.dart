import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? getCurrentUser(){
    return auth.currentUser;
  }
  //login
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    firestore.collection("Users").doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
    });
    return userCredential;
  }

  // sign up
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
   
  }

  //logout
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
