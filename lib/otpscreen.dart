import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth2/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pinput/pinput.dart';
class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.id});
final String id;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  Future<void> CheckOTPfunction({required String sms_code, required String id_s})async{
 try{
   var auth=FirebaseAuth.instance;
   PhoneAuthCredential _crendital= PhoneAuthProvider.credential(verificationId: id_s, smsCode: sms_code);
 UserCredential users= await auth.signInWithCredential(_crendital);
    if(users.user != null){
      EasyLoading.showSuccess("Phone Autentication Successful done");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
    }else{
      EasyLoading.showError("Phone Autentication is went wrong");
    }
 }catch(e){
EasyLoading.showError(e.toString());
 }
  }

String otp="";
  @override
  Widget build(BuildContext context) {
    return     Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(
            child: Pinput(
              length: 6,
              onChanged: (value) {
                otp = value;
              },
            ),
          ),
Center(
  child:   ElevatedButton(onPressed: () {
    CheckOTPfunction(sms_code: otp,id_s:widget.id );
  }, child: const Text("press to login")),
),


        ],
      ),
    );
  }
}
