import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'chatScreen_in_stremebuilder.dart';
class DatapushScreen extends StatefulWidget {
  const DatapushScreen({super.key});

  @override
  State<DatapushScreen> createState() => _DatapushScreenState();
}

class _DatapushScreenState extends State<DatapushScreen> {

  CollectionReference user_s = FirebaseFirestore.instance.collection('users');

  TextEditingController datapushController=TextEditingController();

  Future<void> data_Post({required String name}) async {
    EasyLoading.show(status: "Loding...");
    await user_s.add({
      "name": "${name}",
      "ages": 123,
    });
    EasyLoading.showSuccess("Data post done");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    datapushController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text("Data push in firebase"),
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          tooltip: 'Open shopping cart',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Chatscreen(),));
          },
        ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: TextFormField(
              controller: datapushController,

            ),
          ),
          Center(
            child: ElevatedButton(onPressed: () {
            setState(() {
              data_Post(name: datapushController.text);
              datapushController.clear();
            });
            }, child: Text("Data push")),
          ),
        ],
      ),
    );
  }
}
