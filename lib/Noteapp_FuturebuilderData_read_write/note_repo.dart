import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth2/Noteapp_FuturebuilderData_read_write/notedatamodels.dart';

Future<List<NoteDataModels>> get_noteUser()async{

  List<NoteDataModels> _listofAll_noteUser=[];

  CollectionReference students_users = FirebaseFirestore.instance.collection("notes");


  final QuerySnapshot _data = await students_users.get();
  // for (int i = 0; i < data.docs.length; i++) {
  //   Map<String, dynamic> student = data.docs[i].data() as Map<String, dynamic>;
  //   StudentModel s = StudentModel.fromJson(json: student);
  //   s.id = data.docs[i].id;
  //   allStudent.add(s);
  // }

  // for(int i=0;i<_data.docs.length;i++){
  //   Map<String, dynamic> _student =_data.docs[i].data() as Map<String, dynamic>;
  //   NoteDataModels _NoteDataModels=NoteDataModels.fromJson(json: _student);
  //   _NoteDataModels.tittle=_data.docs[i].id;
  //    _listofAll_noteUser.add(_NoteDataModels);
  // }


  for (var element in _data.docs) {
    Map<String, dynamic> _student =element.data() as Map<String, dynamic>;
    _listofAll_noteUser.add(NoteDataModels.fromJson(json: _student));
  }
  return _listofAll_noteUser;

}