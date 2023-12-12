import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'datapush.dart';
class FutureBuilderDataRead extends StatefulWidget {
  const FutureBuilderDataRead({super.key});

  @override
  State<FutureBuilderDataRead> createState() => _FutureBuilderDataReadState();
}

class _FutureBuilderDataReadState extends State<FutureBuilderDataRead> {
  CollectionReference user_s = FirebaseFirestore.instance.collection('users');




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data read page"),
          actions: [
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          tooltip: 'Open shopping cart',
          onPressed: () {
setState(() {
  Navigator.push(context, MaterialPageRoute(builder: (context) => DatapushScreen(),));

});          },
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: user_s.get(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                if(snapshot.hasData){

                  return  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount:snapshot.data?.docs.length ,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> name =snapshot.data?.docs[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text("${name["name"]}"),
                        subtitle: Text("${name["ages"]}"),
                      );},);
                }else{
                  return CircularProgressIndicator();
                }

              },
            ),

          ],
        ),
      )
    );
  }
}
