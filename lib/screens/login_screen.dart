import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool _isPasswordVisible = false;

  void tooglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
  // bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthService().loginUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Device Validator');
  }

  Widget _entryField(
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
        hintText: 'Email',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
            // width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _entryFieldPassword(
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: tooglePasswordVisibility,
        ),
        filled: true,
        fillColor: Colors.black,
        hintText: 'Password',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
            // width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ?  $errorMessage');
  }

  Widget _submitButton() {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          // var connectivityResult = await (Connectivity().checkConnectivity());
          // bool result = await InternetConnection().hasInternetAccess;

          if (!(await InternetConnection().hasInternetAccess)) {
            Fluttertoast.showToast(
              msg:
                  "No network connection. Please connect to a network and try again.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: const Color.fromARGB(255, 4, 74, 100),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            signInWithEmailAndPassword();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        child: const Text(
          'Log In',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Image.asset('assets/images/banner.png'),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Login',
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _entryField(_controllerEmail),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _entryFieldPassword(_controllerPassword),
            ),
            _errorMessage(),
            _submitButton(),
            // _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
