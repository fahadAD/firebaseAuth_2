
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth2/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'home.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneAuthController = TextEditingController();
  // TextEditingController very_pinsAuthController = TextEditingController();

  Future phoneAuthsend_OTP({required String phone_number}) async {
    // if (phoneAuthController.text != '') {
    //   try {
    //     EasyLoading.show(status: "Loding..");
    //     var auth = FirebaseAuth.instance;
    //     await auth.verifyPhoneNumber(
    //       timeout: Duration(seconds: 60),
    //       phoneNumber: phoneAuthController.text,
    //       verificationCompleted: (PhoneAuthCredential credential) async {
    //
    //       },
    //       verificationFailed: (FirebaseAuthException exception) {
    //         print(exception);
    //       },
    //       codeSent: (verificationId, forceResendingToken) {
    //         showDialog(context: context,
    //           builder: (context) {
    //             return AlertDialog(title: Text("Enter the code"),
    //               content: Column(
    //                 children: [TextFormField(controller: very_pinsAuthController),
    //                   ElevatedButton(onPressed: () async {
    //                         PhoneAuthCredential _phoneauthcreendital = PhoneAuthProvider.credential(verificationId: verificationId,
    //                             smsCode: very_pinsAuthController.text);
    //                         var users = await auth.signInWithCredential(_phoneauthcreendital);
    //                         if (users.user != null) {print(users);
    //                           EasyLoading.showSuccess("Sussessful done Pin code");
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                 builder: (context) => Home(),
    //                               ));
    //                         } else {EasyLoading.showError(" Pin code is wrong");}},
    //                       child: Text("Submit")),],),);},);},
    //       codeAutoRetrievalTimeout: (String verificatiobId) {},);
    //   } catch (e) {
    //     print(e.toString());}
    // } else {
    //   EasyLoading.showError("Enter Your Phone num");}
var auth= FirebaseAuth.instance;
await auth.verifyPhoneNumber(
    phoneNumber: phone_number,
    verificationCompleted: (phoneAuthCredential) {},
    verificationFailed: (error) {print(error.message);},
    codeSent: (verificationId, forceResendingToken) {
      EasyLoading.dismiss();
      Navigator.push(context, MaterialPageRoute(builder: (context) =>OTPScreen(id: verificationId) ,));

    },
    codeAutoRetrievalTimeout: (verificationId) {},);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneAuthController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhoneAuth"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: phoneAuthController,
              decoration: InputDecoration(
                  labelText: "Number", border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
EasyLoading.show(status: "Loding...");
await phoneAuthsend_OTP(phone_number: phoneAuthController.text);
              },
              child: Text("Send otp")),
        ],
      ),
    );
  }
}

 
