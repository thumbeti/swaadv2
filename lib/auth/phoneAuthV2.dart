import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaadv2/OrderingMenu.dart';
import 'package:swaadv2/auth/regestration.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneAuth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PhoneAuthState();
}

class PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _phoneNumberController = TextEditingController(text: '+16505559999');
  final TextEditingController _smsController = TextEditingController(text: '999999');

  String _message = '';
  String _verificationId;

  // Example code for sign out.
  void _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(builder: (BuildContext context) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: SizedBox(
                      height: 300.0,
                      child: Image(
                        alignment: Alignment.center,
                        image: AssetImage("assets/swaad_logo.png"),
                        //fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 45.0),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      labelText: 'Phone number (+x xxx-xxx-xxxx)',
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Phone number (+x xxx-xxx-xxxx)';
                      }
                      return null;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: () async {
                        _verifyPhoneNumber();
                      },
                      child: const Text('Send OTP'),
                    ),
                  ),
                  TextField(
                    controller: _smsController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: 'Verification code (xxxxxx)',
                        border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: () async {
                        _signInWithPhoneNumber();
                      },
                      child: const Text('Sign in'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _message,
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ],
          );
        }
      ),
    );
  }
  // Example code of how to verify phone number
  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
          print("Please check your phone for the verification code.");
          setState(() {
            _message = 'Please check your phone for the verification code.';
          });
          _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in!!';
        print(_message);
        var existingUser = _checkIfUserRegistered();

        existingUser.then((x) => {
          if(x == false) {
            regesterUser()
          } else {
            Navigator.push( context,
              MaterialPageRoute(builder: (context) => OrderingMenu(_phoneNumberController.text)),
              //MaterialPageRoute(builder: (context) => SwaadAdminPage(_phoneNumberController.text)),
              )
          }
        }).catchError((e) => print('in catch error'+ e.toString()));
      } else {
        _message = 'Sign in failed';
      }
    });
  }

  void regesterUser() {
    print('Welcome to Swaad living.. going for regestration.');
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => Regestration()),
    );
  }
  void addUserRecord() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    await Firestore.instance.collection('users')
        .document(currentUser.uid)
        .setData({
          'name' : 'Ram',
          'phoneNumber' : '+16505559999'
    });
  }
  Future<bool> _checkIfUserRegistered() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    var phoneNum = _phoneNumberController.text;

    DocumentReference qs = Firestore.instance.collection('users').document(phoneNum);
    DocumentSnapshot snap = await qs.get();
    if (snap.data == null) {
      print('User does not exist.');
      return false;
    } else {
      print('User already exists with ID' + currentUser.uid + phoneNum);
      return true;
    }
  }
}
