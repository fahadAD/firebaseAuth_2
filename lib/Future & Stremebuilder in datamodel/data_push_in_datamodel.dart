import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth2/Future%20&%20Stremebuilder%20in%20datamodel/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../Noteapp_FuturebuilderData_read_write/noteapp_in_datapush.dart';
import '../Noteapp_FuturebuilderData_read_write/noteapp_in_futurebuilder.dart';
import 'futurebilderin_datamodel.dart';
class DataPushinDatamodel extends StatefulWidget {
  const DataPushinDatamodel({super.key});

  @override
  State<DataPushinDatamodel> createState() => _DataPushinDatamodelState();
}

class _DataPushinDatamodelState extends State<DataPushinDatamodel> {
  TextEditingController namePushController=TextEditingController();
  TextEditingController rollPushController=TextEditingController();
  TextEditingController classPushController=TextEditingController();
  TextEditingController sectionPushController=TextEditingController();

  CollectionReference _students = FirebaseFirestore.instance.collection('${FirebaseAuth.instance.currentUser?.uid}');


  Future<void> data_Post({required DataModels datamodels}) async {
    EasyLoading.show(status: "Loding...");
    await _students.add(datamodels.toJson());
    EasyLoading.showSuccess("Data post done");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     namePushController.dispose();
     rollPushController.dispose();
     classPushController.dispose();
    sectionPushController.dispose();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text("Data push screen"),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              tooltip: 'Open vext',
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NoteappinFuturebuilder(),));

              },
            ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
              child: TextFormField(
                controller: namePushController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
              child: TextFormField(
                controller: classPushController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Class"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
              child: TextFormField(
                controller: rollPushController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    labelText: "Roll"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
              child: TextFormField(
                controller: sectionPushController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    labelText: "Section"
                ),
              ),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DataModels  _Data=DataModels(names: namePushController.text, sections: sectionPushController.text, classes: int.parse(classPushController.text), rolls: int.parse(rollPushController.text),);
         data_Post(datamodels: _Data);
          namePushController.clear();
          sectionPushController.clear();
          rollPushController.clear();
          classPushController.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context) => FutureinData_Model(),));
        },child: Icon(Icons.save_as),),
    );
  }
}
