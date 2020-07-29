import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:tasklistk/models/task_data.dart';
import 'package:tasklistk/widgets/task_tile.dart';

final LocalStorage localStorage = LocalStorage('toDoList.json');

bool initialised = false;
List tasksList = [];

class TasksList extends StatelessWidget {
  Future<bool> get getData async {
    TaskData taskData = TaskData();

    if (!initialised) {
      await localStorage.ready;
      tasksList = await localStorage.getItem('todos');
      await taskData.init(tasksList);
      initialised = true;
      return true;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: localStorage.ready,
      builder: (context, snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<TaskData>(
            builder: (context, taskData, child) {
              if (!initialised) {
                tasksList = localStorage.getItem('todos');
                taskData.init(tasksList);
                initialised = true;
              }
              print(taskData.tasks);
              return ListView.builder(
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index];
                  return TaskTile(
                    index: index,
                    title: task.title,
                    isChecked: task.isChecked,
                    callback: (newValue) {
                      taskData.toggleCheck(task);
                    },
                    deleteCallback: () {
                      taskData.deleteTask(task);
                    },
                  );
                },
                itemCount: taskData.tasks.length,
              );
            },
          );
        }
      },
    );
  }
}
