// ignore_for_file: use_build_context_synchronously

 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'home.dart';
class GoogleSignin extends StatefulWidget {
  const GoogleSignin({super.key});

  @override
  State<GoogleSignin> createState() => _GoogleSigninState();
}
class _GoogleSigninState extends State<GoogleSignin> {


  Future GoogleSign()async{
//     EasyLoading.show(status: "Loding");
//     final GoogleSignInAccount? googleSign_InAccount=await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication? googleSignIn_Authentication=await googleSign_InAccount?.authentication;
// AuthCredential authCredential=GoogleAuthProvider.credential(idToken: googleSignIn_Authentication?.idToken,
//     accessToken: googleSignIn_Authentication?.accessToken);
//      var  users=await FirebaseAuth.instance.signInWithCredential(authCredential);
//
//    if(users.user != null){
//      EasyLoading.showSuccess("Google signup sussessful done ");
//      Navigator.push(context, MaterialPageRoute( builder: (context) =>  Home(),
//          ));
//    }else{
//      EasyLoading.showError("Something is wrong");
//
//    }
//
    EasyLoading.show(status: "Loding");

final GoogleSignInAccount? _googleSignInAccount_user=await GoogleSignIn().signIn();
final GoogleSignInAuthentication?  _googleauth=await _googleSignInAccount_user?.authentication;

final _crediental=GoogleAuthProvider.credential(accessToken: _googleauth?.accessToken, idToken: _googleauth?.idToken);
    UserCredential users= await FirebaseAuth.instance.signInWithCredential(_crediental);

    if(users.user != null){
      EasyLoading.showSuccess("Google signup sussessful done ");
      Navigator.push(context, MaterialPageRoute( builder: (context) =>  Home()));
    }else{
      EasyLoading.showError("Something is wrong");
    }

   }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(title: Text("Google Loginin"),),
       body:  Center(child: ElevatedButton(onPressed: () async{
         GoogleSign();
       }, child: Text("Google Login"))),
    );
  }
}


