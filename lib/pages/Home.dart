import 'package:flutter/material.dart';
import 'package:managetime/pages/AddTask.dart';
import 'package:managetime/pages/ShowTasks.dart';
import "dart:io";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double scwidth = MediaQuery.of(context).size.width;
    double scheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50),
            height: scheight * 2 / 10,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Manage Your Time",
                  style: TextStyle(fontSize: 32, color: Colors.deepPurple),
                ),
                Container(
                    height: scheight * 2 / 10,
                    width: scwidth * 2 / 12,
                    child: Image.asset('images/c.png')),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            height: scheight * 1 / 13,
            child: Text(
              '________________________________________________',
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
          Container(
            height: scheight * 5 / 9,
            width: scwidth,
            padding: EdgeInsets.only(left: scwidth * 3 / 20),
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: scwidth / 1000,
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: scheight * 1 / 11,
              children: <Widget>[
                RaisedButton(
                    child: Text(
                      'All Tasks',
                      style: TextStyle(color: Colors.deepPurple, fontSize: 22),
                    ),
                    color: Colors.grey,
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => new ShowTasks(1))),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0))),
                RaisedButton(
                    child: Text(
                      'Today Tasks',
                      style: TextStyle(color: Colors.deepPurple, fontSize: 22),
                    ),
                    color: Colors.grey,
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => new ShowTasks(0))),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0))),
                RaisedButton(
                    child: Text(
                      'Add Task',
                      style: TextStyle(color: Colors.deepPurple, fontSize: 22),
                    ),
                    color: Colors.grey,
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddTask("","","",1))),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0))),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    onPressed: ()=>exit(0) )),
          ),
        ],
      ),
    );
  }
}
