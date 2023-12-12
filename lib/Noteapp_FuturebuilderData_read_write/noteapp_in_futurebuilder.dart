import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth2/Noteapp_FuturebuilderData_read_write/notedatamodels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'edit_screen.dart';
import 'note_repo.dart';
import 'noteapp_in_datapush.dart';
 class NoteappinFuturebuilder extends StatefulWidget {
   const NoteappinFuturebuilder({super.key});

   @override
   State<NoteappinFuturebuilder> createState() => _NoteappinFuturebuilderState();
 }

 class _NoteappinFuturebuilderState extends State<NoteappinFuturebuilder> {
   Future<void> deleteStudent({required NoteDataModels studentModel}) async {

     DocumentReference students = FirebaseFirestore.instance.collection("notes").doc(studentModel.tittle);

     students.delete();

     EasyLoading.show(status: 'Loading...');

     EasyLoading.showSuccess('Delete Done');
     setState(() {});
   }
   @override
   Widget build(BuildContext context) {
     return   Scaffold(
       appBar: AppBar(title: Text("NoteappinFuturebuilder"),),
       floatingActionButton: FloatingActionButton(onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => DatapushinNoteapp(),));

       },child: Icon(Icons.add),),
       body: FutureBuilder<List<NoteDataModels>>(
         future: get_noteUser(),
         builder: (context, snapshot) {
         if(snapshot.hasData){
           return ListView.builder(
             primary: false,
             shrinkWrap: true,
             itemCount: snapshot.data?.length,
             itemBuilder: (BuildContext context, int index) {
                NoteDataModels _NoteDataModels=snapshot.data?[index] as NoteDataModels;
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 color: Colors.orange,
                 width: MediaQuery.of(context).size.width*0.9,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),

                       child: ListTile(
                         leading: GestureDetector(
                             onTap: () {
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditScreen(editNoteDataModels: _NoteDataModels,),));
                             },
                             child: Icon(Icons.edit)),
                         title: Text("Tittle: ${_NoteDataModels.tittle}"),
                         trailing: GestureDetector(
                           onTap: () {
                             deleteStudent(studentModel: _NoteDataModels);

                            },
                             child: Icon(Icons.delete)),),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("Description: ${_NoteDataModels.description}"),
                     ),
                   ],
                 ),
               ),
             );
           },

           );
         }else{
           return Center(child: CircularProgressIndicator());
         }
       },),
     );
   }
 }

