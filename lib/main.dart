import 'package:flutter/material.dart';
import 'package:managetime/pages/Home.dart';
import 'package:managetime/pages/AddTask.dart';
import 'package:managetime/pages/ShowTasks.dart';

main()=> runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
   Widget build(BuildContext context) {
    return MaterialApp(home: Home(),);
  }
}
