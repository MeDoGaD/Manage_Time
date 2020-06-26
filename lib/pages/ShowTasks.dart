import 'package:flutter/material.dart';
import 'package:managetime/Model/dbhelper.dart';
import 'package:managetime/Model/Task.dart';
import 'package:managetime/pages/AddTask.dart';
import 'package:shared_preferences/shared_preferences.dart';

List tasks;
int count = 0;
void getTasks(int state) async {
  var db = new DbHelper();
  tasks = await db.getTasks(state);
  count = tasks.length;
}

Future<int> deleteTask(String title, DbHelper db) async {
  int r = await db.deleteTask(title);
  if (r != 0)
    return 1;
  else
    return 0;
}

class ShowTasks extends StatefulWidget {
  int state;
  ShowTasks(this.state);
  @override
  _ShowTasksState createState() => _ShowTasksState(state);
}

class _ShowTasksState extends State<ShowTasks> {
  int state;
  _ShowTasksState(this.state);

  String title = "All Tasks";
  var db = new DbHelper();

  @override
  void initState() {
    super.initState();
    db = DbHelper();

    setState(() {
      getTasks(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    getTasks(state);
      if (state == 1)
        title = "All Tasks";
      else
        title = "Today Tasks";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.deepPurple),
        ),
        backgroundColor: Colors.greenAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  getTasks(state);
                });
              })
        ],
      ),
      body: FutureBuilder(
        future: db.getTasks(state),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: count,
              itemBuilder: (_, int index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text('${Task
                            .fromMap(tasks[index])
                            .date}'),
                        Card(
                          child: new ListTile(
                            leading: Icon(
                              Icons.access_time,
                              color: Colors.deepPurple,
                              size: 33.0,
                            ),
                            title:
                            new Text('${Task
                                .fromMap(tasks[index])
                                .title}'),
                            subtitle: new Text(
                                '${Task
                                    .fromMap(tasks[index])
                                    .description}'),
                            trailing: Icon(Icons.delete, color: Colors.red),
                            onTap: () {
                              showDialog(context: context,builder:(BuildContext context){
                                  return AlertDialog(title: Text('Deleting'),content:Text('Do you want to Delete ?'),
                                  actions: <Widget>[
                                    FlatButton(child: Text('No',style: TextStyle(color: Colors.deepPurple),),onPressed: ()=> Navigator.of(context).pop(),),
                                    FlatButton(child: Text('Yes',style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                      deleteTask(Task.fromMap(tasks[index]).title, db);
                                      Navigator.of(context).pop();
                                      setState(() {
                                        getTasks(state);
                                      });
                                    },),
                                  ],);
                              } );

                            },
                            onLongPress: () {
                              String tit = Task
                                  .fromMap(tasks[index])
                                  .title;
                              String des = Task
                                  .fromMap(tasks[index])
                                  .description;
                              String dd = Task
                                  .fromMap(tasks[index])
                                  .date;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                  new AddTask(tit, des, dd, 0)));
                            },
                          ),
                          color: Colors.amber,
                          elevation: 3.0,
                        ),
                      ],
                    ),
                  );
              },);
          }
              },
    ),
    );
  }
}
