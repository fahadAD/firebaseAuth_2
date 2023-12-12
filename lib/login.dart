
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth2/phoneauth.dart';
import 'package:firebaseauth2/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'forgot_password.dart';
import 'googleauth.dart';
import 'home.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailcontroller=TextEditingController();
  TextEditingController loginPasswordcontroller=TextEditingController();
Future<void> loginEmail_PasswordFun() async {
  if(loginEmailcontroller.text != '' &&  loginPasswordcontroller.text != ''){
    if(loginEmailcontroller.text.contains("@") && loginEmailcontroller.text.contains(".com")){
      try{
        EasyLoading.show(status: "Loding..");
        var auth=FirebaseAuth.instance;
        UserCredential user=await auth.signInWithEmailAndPassword(email: loginEmailcontroller.text, password: loginPasswordcontroller.text);
        if(user.user != null){
          EasyLoading.showSuccess("Login done");
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
        }else{
          EasyLoading.showError("Something is wrong");
        }
      }on FirebaseAuthException catch (e) {
        EasyLoading.showError(e.code);
      }catch(e){
        EasyLoading.showError(e.toString());

      }
    }else{
      EasyLoading.showError("Enter a valid email");
    }
  }else{
    EasyLoading.showError("Required email & password");
  }
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginEmailcontroller.dispose();
    loginPasswordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("LoginScreen")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: loginEmailcontroller,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder()),
                ),
              ),SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: loginPasswordcontroller,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder()),
                ),
              ),SizedBox(height: 30,),

              ElevatedButton(onPressed: () async {
                loginEmail_PasswordFun();
              }, child: Text("Login")),

              SizedBox(height: 20,),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                }, child: Text("Forgot password?",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)),
              ),

              SizedBox(height: 20,),

              TextButton(onPressed: () {
 Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
              }, child: Text("Signup",style: TextStyle(fontWeight: FontWeight.bold),)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("OR"),
              ),
              TextButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneAuth(),
                    ));
              }, child: Text("Login with Phone num",style: TextStyle(fontWeight: FontWeight.bold),)),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("OR"),
              ),
              TextButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleSignin(),
                    ));
              }, child: Text("Login with Google id",style: TextStyle(fontWeight: FontWeight.bold),)),


            ],
          ),
        ),
      ),
    );
  }
}