class Task{
  //int id;
  String title;
  String description;
  String date;
  Task(this.title,this.description,this.date);

  Task.map(dynamic obj){
    //this.id=obj['id'];
    this.title=obj['title'];
    this.description=obj['description'];
    this.date=obj['date'];
  }

  //int get _id => id;
  String get _title => title;
  String get _description => description;
  String get _date => date;

  Map<String , dynamic>toMap(){
    var map=new Map<String,dynamic>();
    //map['id']=_id;
    map['title']=_title;
    map['description']=_description;
    map['date']=_date;
    return map;
  }

  Task.fromMap(Map<String , dynamic>map)
  {
    //this.id=map['id'];
    this.title=map['title'];
    this.description=map['description'];
    this.date=map['date'];
  }
}