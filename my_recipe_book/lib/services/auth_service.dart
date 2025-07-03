import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  bool get isLoggedIn => user != null;

  AuthService() {
    _auth.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<String?> getUserNickname() async {
  final user = _auth.currentUser;
  if (user == null) return null;

  final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  return doc.data()?['nickname'];
}

  Future<void> signUp(String email, String password, {required String nickname}) async {
  try {
    final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final uid = userCredential.user?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'nickname': nickname,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  } on FirebaseAuthException catch (e) {
    throw Exception(e.message);
  }
}

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
