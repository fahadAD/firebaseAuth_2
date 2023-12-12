class DataModels{
  String? names;
  num? classes;
  num? rolls;
  String? sections;

  DataModels({this.names,this.classes,this.rolls,this.sections});

  DataModels.fromJson({required Map<String, dynamic> json}){
    names=json['names'];
    classes=json['classes'];
    rolls=json['rolls'];
    sections=json['sections'];


  }

  Map<String, dynamic> toJson()=> <String, dynamic>{
   'names' : names,
   'classes' : classes,
   'rolls' : rolls,
   'sections' : sections,
  };
}