import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:managetime/Model/Task.dart';

class DbHelper{
  static Database _db ;
  final String taskTable='Task';
  final String colTitle='title';
  final String colDes='description';
  final String colDate='date';
  //final String columnId = 'id';


  Future<Database> get db async{
    if(_db !=null)
      return _db ;
    _db =await intDB();
    return _db ;
  }

  intDB()async{
    Directory docdirectory=await getApplicationDocumentsDirectory();
    String path =join(docdirectory.path,'mydb.db');
    var myOwnDB=await openDatabase(path,version: 1,onCreate: _onCreate);
    return myOwnDB;
  }

  void _onCreate(Database db , int newversion)async{
    var sql="CREATE TABLE $taskTable($colTitle TEXT , $colDes TEXT,$colDate TEXT)";
    await db.execute(sql);
  }

  Future<int> saveTask(Task task)async{
    var dbClient = await  db;
    int result = await dbClient.insert("$taskTable", task.toMap());
    return result;
  }

  Future<List> getTasks(int state) async{
    var sql;
    String today = DateTime.now().day.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().year.toString();;
    var dbClient = await  db;
    sql = "SELECT * FROM $taskTable";
    // sql = "SELECT * FROM $taskTable WHERE $colTitle=yarb";
    List result = await dbClient.rawQuery(sql);
    List<dynamic>todaytasks=[];
    if(state==0) {
      for (int i = 0; i < result.length; i++) {
        if (Task.fromMap(result[i]).date == today) {
          todaytasks.add(result[i]);
        }
      }
    }
      if (state == 0)
        return todaytasks.toList();
      else
        return result.toList();
  }
  Future<int> deleteTask(String title) async{
    var dbClient = await  db;
    return  await dbClient.delete(
        taskTable , where: "$colTitle = ?" , whereArgs: [title]
    );
  }

  Future<int> updateTask(Task task)async
  {
    var dbclient = await db;
    return await dbclient.update(taskTable,task.toMap(),where:"$colTitle=?",whereArgs: [task.title]);
  }

  void close() async{
    var dbClient = await  db;
    return await dbClient.close();
  }
}
