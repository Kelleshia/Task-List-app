import 'package:flutter/material.dart';
import 'package:tasklistk/screens/add_task_screen.dart';
import 'package:tasklistk/widgets/tasks_list.dart' hide localStorage;
import 'package:tasklistk/models/task_data.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[700],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ),
          );
        },
        backgroundColor: Colors.yellowAccent[700],
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: localStorage.ready,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 30.0,
                    right: 30.0,
                    bottom: 30.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Task List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${localStorage.getItem('todos') != null ? localStorage.getItem('todos').length : 0} tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: TasksList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
