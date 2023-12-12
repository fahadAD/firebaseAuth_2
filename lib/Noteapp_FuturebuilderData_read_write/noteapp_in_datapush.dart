import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'noteapp_in_futurebuilder.dart';
import 'notedatamodels.dart';
class DatapushinNoteapp extends StatefulWidget {
  const DatapushinNoteapp({super.key});
  @override
  State<DatapushinNoteapp> createState() => _DatapushinNoteappState();
}
class _DatapushinNoteappState extends State<DatapushinNoteapp> {
  TextEditingController tittleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  CollectionReference notesUer = FirebaseFirestore.instance.collection("notes");

  Future<void> dataPost({required NoteDataModels notemodels})async{
    EasyLoading.show(status: "Loding...");
    await notesUer.add(notemodels.toJson());
    EasyLoading.showSuccess("Data push Succesfully Done");
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
      appBar: AppBar(title: Text("Data Push in Note app"),
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
             dataPost(notemodels: _noteDataModels);
             descriptionController.clear();
             tittleController.clear();
             Navigator.push(context, MaterialPageRoute(builder: (context) => NoteappinFuturebuilder(),));
           }, child: Text("Data post")),

         ],
       ),
    );
  }
}
