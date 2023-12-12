import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotEmailcontroller=TextEditingController();
 Future forgotPasswordFunction()async{
 try{
   EasyLoading.show(status: "loding...");
   final auth=FirebaseAuth.instance;
   auth.sendPasswordResetEmail(email: forgotEmailcontroller.text);
   EasyLoading.showSuccess(duration: Duration(seconds: 3),"We have send you e-mail to recover password,\n please chek e-mail");
 }catch(e){
   print(e.toString());
 }
 }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    forgotEmailcontroller.text;
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text("Forgot password Screen"),),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: forgotEmailcontroller,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder()),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: () {
            forgotPasswordFunction();
          }, child: Text("Forgot"))
        ],
      ),
    );
  }
}
