import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController signupEmailcontroller=TextEditingController();
  TextEditingController signupPasswordcontroller=TextEditingController();

  Future<void> signupEmail_PasswordFun() async {
    if(signupEmailcontroller.text != '' &&  signupPasswordcontroller.text != ''){
      if(signupEmailcontroller.text.contains("@") && signupEmailcontroller.text.contains(".com")){
        try{
          EasyLoading.show(status: "Loding..");
          var auth=FirebaseAuth.instance;
          UserCredential user=await auth.createUserWithEmailAndPassword(email: signupEmailcontroller.text, password: signupPasswordcontroller.text);
          if(user.user != null){
            EasyLoading.showSuccess("Signup done");
            Navigator.pop(context);
          }else{
            EasyLoading.showError("Something is wrong");
          }
        }on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            EasyLoading.showError('The password provided is too weak.');
          }
          else if (e.code == 'email-already-in-use') {
            EasyLoading.showError('The account already exists for that email.');
          }
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
    signupPasswordcontroller.dispose();
    signupEmailcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text("SignupScreen")),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: signupEmailcontroller,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder()),
            ),
          ),SizedBox(height: 20,),

          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: signupPasswordcontroller,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder()),
            ),
          ),SizedBox(height: 20,),

          ElevatedButton(onPressed: () async {
            signupEmail_PasswordFun();
          }, child: Text("Sign Up")),
          SizedBox(height: 20,),

          ElevatedButton(onPressed: () async {
           Navigator.pop(context);
          }, child: Text("Log In")),
        ],
      ),
    );
  }
}
