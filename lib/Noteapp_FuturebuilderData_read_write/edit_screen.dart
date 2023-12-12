import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth2/Future%20&%20Stremebuilder%20in%20datamodel/student_get_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'noteapp_in_futurebuilder.dart';
import 'notedatamodels.dart';
class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.editNoteDataModels });
 final NoteDataModels editNoteDataModels;
  @override
  State<EditScreen> createState() => _EditScreenState();
}
class _EditScreenState extends State<EditScreen> {
  TextEditingController tittleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  // CollectionReference notesUer = FirebaseFirestore.instance.collection('notes');

  Future<void> editData({required NoteDataModels notemodels})async{
    DocumentReference notesUer = FirebaseFirestore.instance.collection("notes").doc(widget.editNoteDataModels.tittle);
    notesUer.update(notemodels.toJson());
     EasyLoading.show(status: "Loding...");
    // await notesUer.add(notemodels.toJson());

    EasyLoading.showSuccess("Data push Succesfully Done");
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tittleController.text=widget.editNoteDataModels.tittle??"";
    descriptionController.text=widget.editNoteDataModels.description??"";
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tittleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text("Edit Screen"),
          actions: [
            IconButton(
              icon: const Icon(Icons.swap_vert),
              tooltip: 'Open Store Page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NoteappinFuturebuilder(),));
              },
            ),
          ]),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: tittleController,
              decoration: InputDecoration(
                hintText: "Tittle",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 30,),

          ElevatedButton(onPressed: () {
            NoteDataModels _noteDataModels=NoteDataModels(description: descriptionController.text, tittle: tittleController.text,);
            editData(notemodels: _noteDataModels);
            descriptionController.clear();
            tittleController.clear();
            Navigator.push(context, MaterialPageRoute(builder: (context) => NoteappinFuturebuilder(),));
          }, child: Text("Save Edit")),

        ],
      ),
    );
  }
}