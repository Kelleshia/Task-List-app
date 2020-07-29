import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasklistk/models/task_data.dart';
import 'package:tasklistk/screens/task_info_screen.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {this.title,
      this.isChecked,
      this.callback,
      this.deleteCallback,
      this.index});

  final String title;
  final bool isChecked;
  final Function callback;
  final Function deleteCallback;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: deleteCallback,
      onDoubleTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TaskInfoScreen(
            index: index,
            task: Provider.of<TaskData>(context).tasks[index],
          );
        }));
      },
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          activeColor: Colors.yellowAccent[700],
          value: isChecked,
          onChanged: callback,
        ),
      ),
    );
  }
}
