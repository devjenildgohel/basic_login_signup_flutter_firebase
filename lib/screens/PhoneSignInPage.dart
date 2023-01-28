import 'package:basic_login_signup_firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneSignInPage extends StatefulWidget {
  @override
  _PhoneSignInPageState createState() => _PhoneSignInPageState();
}

class _PhoneSignInPageState extends State<PhoneSignInPage> {
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _verificationId;

  Future<void> _submitOTP() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        // Sign in successful
        print("User signed in: ${user.uid}");
      } else {
        // Sign in failed
        print("Error signing in with OTP");
      }
    } catch (e) {
      // OTP verification failed
      print("Error: $e");
    }
  }

  Future<void> _verifyPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authCredential) {
      auth().signInWithCredential(authCredential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      verificationId = verificationId;
    };

    await auth().verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.purple])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(23),
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.black))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: () {
                                _verifyPhoneNumber();
                              },
                              child: Text("Get OTP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
