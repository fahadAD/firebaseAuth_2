class NoteDataModels{
  String? description;
  String? tittle;
  NoteDataModels({this.description,this.tittle});

  NoteDataModels.fromJson({required Map<String, dynamic> json}){
  tittle=json['tittle'];
    description=json['description'];

  }

  Map<String, dynamic> toJson()=> <String, dynamic>{
    'tittle' : tittle,
    'description' : description,
  };
}