import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:intl/intl.dart';

import 'Future & Stremebuilder in datamodel/data_push_in_datamodel.dart';
import 'Future & Stremebuilder in datamodel/futurebilderin_datamodel.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({Key? key}) : super(key: key);


  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController textController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('massages').snapshots();

  Future<void> dataPost({required String name_s, required String text_s}) async {
    CollectionReference c = FirebaseFirestore.instance.collection('massages');
    await c.add({
      "name": name_s,
      "text": text_s,
    });

    EasyLoading.showSuccess("Massage Sent");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    textController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("${FirebaseAuth.instance.currentUser?.photoURL}"),
            ),
          ),
          backgroundColor: Colors.teal,
          title: ListTile(
            title: Text("${FirebaseAuth.instance.currentUser?.displayName}", style: TextStyle(color: Colors.white)),
            subtitle: Text("${FirebaseAuth.instance.currentUser?.email}", style: TextStyle(color: Colors.white)),
          ),
          actions: [
            Icon(Icons.call, color: Colors.white),
            Icon(Icons.video_call, color: Colors.white),
           IconButton(onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => DataPushinDatamodel(),));
           }, icon:  Icon(Icons.arrow_forward, color: Colors.white),)
          ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 55,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: " Name", focusedBorder: InputBorder.none, enabledBorder: InputBorder.none),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 55,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.textsms_outlined), labelText: "Text", focusedBorder: InputBorder.none, enabledBorder: InputBorder.none),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                tooltip: 'Massage Send',
                onPressed: () async {
              setState(() async {
                await dataPost(name_s: nameController.text, text_s: textController.text);
                nameController.clear();
                textController.clear();
              });
                },
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> names = snapshot.data?.docs[index].data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    // width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.teal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                             "${names["name"]}",
                             style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold, fontSize: 16),
                           ),
                         ),
                         Text(DateFormat("yyyy-MM-dd KK:mm:ss: a").format(DateTime.now()),style: TextStyle(color: Colors.white)),
                       ],
                     ),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "${names["text"]}",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}