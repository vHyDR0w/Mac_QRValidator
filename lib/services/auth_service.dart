import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> loginUserWithEmailAndPassword(
      {required String password, required String email}) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log('Something went wrong');
      Fluttertoast.showToast(
        msg: "Invalid credentials.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 4, 74, 100),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return null;
  }

  Future<void> signout() async {
    try {
      _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
