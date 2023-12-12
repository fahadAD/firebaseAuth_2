import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauth2/Future%20&%20Stremebuilder%20in%20datamodel/datamodel.dart';
import 'package:firebaseauth2/Future%20&%20Stremebuilder%20in%20datamodel/student_get_repo.dart';
import 'package:flutter/material.dart';
class FutureinData_Model extends StatefulWidget {
  const FutureinData_Model({super.key});
  @override
  State<FutureinData_Model> createState() => _FutureinData_ModelState();
}
class _FutureinData_ModelState extends State<FutureinData_Model> {


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
     appBar: AppBar(title: Text("FutureBuilder in data show screen")),
body: FutureBuilder<List<DataModels>>(
  future: get_student(),
  builder: (BuildContext context,snapshot) {
    if(snapshot.hasData){
      return  ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount:snapshot.data?.length ,
        itemBuilder: (BuildContext context, int index) {
          DataModels singleStudentdata= snapshot.data?[index] as DataModels ;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6,),
            child: Card(
              child: ListTile(

                title: Center(child: Text("Name: ${singleStudentdata.names}")),
                subtitle: Center(child: Text("Class: ${singleStudentdata.classes}")),
                leading: Text("Roll:${singleStudentdata.rolls}"),
                trailing: Text("Section:${singleStudentdata.sections}"),
              ),
            ),
          );},);
    }else{
      return const CircularProgressIndicator();
    }

  },
),
    );
  }
}
