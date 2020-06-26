import 'dart:async';

import 'package:flutter/material.dart';
import 'package:managetime/Model/Task.dart';
import 'package:managetime/Model/dbhelper.dart';
import 'package:managetime/pages/Home.dart';
import 'package:flutter/services.dart';


int add=1;
class AddTask extends StatefulWidget {
  String title,des,date;
  int state;
  AddTask(this.title,this.des,this.date,this.state);
  @override
  _AddTaskState createState() => _AddTaskState(title,des,date,state);
}

class _AddTaskState extends State<AddTask> {
  _AddTaskState(this.title,this.des,this.date,this.state);
  bool _isenabled=true;
  final TitleController = TextEditingController();
  final descriptionController = TextEditingController();
  var db = new DbHelper();

  bool canVibrate = false;
  String title,des,date;
  int state;
  String savebtn="Save";
  String tit="Add Task";
  String datetxt="Pick a Date";
  String msg='Task Addes successfully :)';

  void showBottomSheet(){
    if(state==1)
      msg='Task Added successfully :)';
    else
      msg='Task Updated successfully :)';

    showModalBottomSheet(context: context, builder: (BuildContext context){
      return new Container(
        padding: EdgeInsets.all(22),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

          Text('$msg'),SizedBox(width: 40,),
          FlatButton(child: Text('Ok',style: TextStyle(color: Colors.deepPurple),),onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Home())),)
        ],),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    try {

      print(state.toString());
      if (state== 1) {
        tit = "Add Task";
        savebtn="Save";
      }
      else if(state==0) {

        tit = "Update Task";
        savebtn="Update";
        TitleController.text=title;
        descriptionController.text=des;
        datetxt=date;
        _isenabled=false;
        state=2;
      }
    }
    catch(e){
      tit="Add Task";
      savebtn="Save";}
      double scwidth = MediaQuery.of(context).size.width;
    double scheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: scheight * 1 / 14),
          height: scheight * 2 / 9,
          child: Row(
            children: <Widget>[
              SizedBox(
                width:scwidth * 4 / 18,
              ),
              Text(
                "$tit",
                style: TextStyle(fontSize: 36, color: Colors.deepPurple),
              ),
              Container(height: scheight*2/10,width:scwidth*2/12 ,child:
              Image.asset('images/t.png')
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 2),
          height: scheight*1/20,
          child: Text(
            '____________________________________________',
            style: TextStyle(color: Colors.greenAccent),
          ),
        ),
        Container(
          height: scheight * 5 / 9,
          width: scwidth,
          padding: EdgeInsets.only(left: 7),
          child: Column(
            children: <Widget>[
              TextField(controller: TitleController,
                style: TextStyle(color: Colors.deepPurple),
                decoration: InputDecoration(
                    hintText: "Enter Task title",
                    filled: true,enabled: _isenabled,
                    fillColor: Colors.grey),
                onChanged: null,
              ),
              SizedBox(
                height: scheight * 1 / 50,
              ),
              TextField(controller: descriptionController,
                maxLines: 15,
                style: TextStyle(color: Colors.deepPurple),
                decoration: InputDecoration(
                    hintText: "Enter Task description",
                    filled: true,
                    fillColor: Colors.grey),
                onChanged: null,
              ),
              SizedBox(
                height: scheight * 1 / 50,
              ),
              TextField(
                  style: TextStyle(color: Colors.deepPurple),
                  decoration: InputDecoration(
                      hintText: "$datetxt",
                      filled: true,
                      fillColor: Colors.grey),
                  onChanged: null,
                   readOnly: true,
                  onTap: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2200)).then((val){setState(() {
                          datetxt=val.day.toString()+"/"+val.month.toString()+"/"+val.year.toString();});
                        });
                  }),
            ],
          ),
        ),
        RaisedButton(
            child: Text(
              '$savebtn',
              style: TextStyle(color: Colors.deepPurple,fontSize: 22),
            ),
            color: Colors.grey,
            onPressed: ()async {
              if(savebtn=="Save") {
                int savedtask = await db.saveTask(new Task(
                    TitleController.text, descriptionController.text, datetxt));
                print(savedtask.toString());
              }
              else
                {
                  db.updateTask(new Task(title,descriptionController.text,datetxt));
                }
              HapticFeedback.vibrate();
              Timer(Duration(milliseconds: 120), () {
                HapticFeedback.vibrate();
              });
              showBottomSheet();
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(40.0))),
      ]),
    );
  }
}
