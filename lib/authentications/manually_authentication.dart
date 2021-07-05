// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthenticationService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//
//
//
//   Future signUpWithEmailAndPassword(
//       String name, String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       User firebaseUser = result.user;
//
//
//       return firebaseUser;
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future logInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       User firebaseUser = result.user;
//
//       return firebaseUser;
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future signOut() async {
//     try {
//       print('logout');
//       return _auth.signOut();
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
