import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'datamodel.dart';
// students
Future<List<DataModels>> get_student()async{
  List<DataModels> _listofAllstudent=[];
  CollectionReference students_users = FirebaseFirestore.instance.collection('${FirebaseAuth.instance.currentUser?.uid}');

final QuerySnapshot _data=await students_users.get();

  for (var element in _data.docs) {
    Map<String, dynamic> _student =element.data() as Map<String, dynamic>;
    _listofAllstudent.add(DataModels.fromJson(json: _student));
  }
return _listofAllstudent;

}