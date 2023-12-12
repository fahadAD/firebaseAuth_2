 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'future builder.dart';
import 'login.dart';
class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    EasyLoading.showSuccess("Log out done");
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

  CollectionReference user_s = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.red,
    appBar: AppBar(
leading: CircleAvatar(backgroundImage: NetworkImage("${FirebaseAuth.instance.currentUser?.photoURL}")),
      title: Column(
        children: [
           Text("${FirebaseAuth.instance.currentUser?.displayName}"),
           Text("${FirebaseAuth.instance.currentUser?.email}"),
       

        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          tooltip: 'Open shopping cart',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FutureBuilderDataRead(),));
          },
        ),
      ],

    ),
     floatingActionButton: FloatingActionButton(onPressed:logOut,child: Icon(Icons.logout),),

      body: FutureBuilder<DocumentSnapshot>(
        future: user_s.doc("bxGFKXJOo954MnD6NvzX").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // if (snapshot.hasError) {
          //   return Text("Something went wrong");
          // }
          //
          // if (snapshot.hasData && !snapshot.data!.exists) {
          //   return Text("Document does not exist");
          // }
          //
          // if (snapshot.connectionState == ConnectionState.done) {
          //   Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          //   return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          // }
              Map<String, dynamic> name = snapshot.data?.data() as Map<String, dynamic>;

              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if(snapshot.hasData){

                return ListTile(
                  title: Text(name["name"]),
                  subtitle: Text(name["age"].toString()),

                );


}else{
   return CircularProgressIndicator();
}

        },
      ),
    );
  }
}
