import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/controller/database_controller.dart';
import 'package:sample_project/model/task_model.dart';
import 'package:sample_project/view/widgets/task_card.dart';
import 'add_new_task_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //instead of initState
    context.read<DatabaseController>().getTasks();
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'All Tasks',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<DatabaseController>(
                builder: (context, controller, child) {
                  if (controller.myDataList.isEmpty) {
                    return Center(
                      child: Text(
                        "No Tasks !!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.myDataList.length,
                    itemBuilder: (context, index) {
                      var task = controller.myDataList[index];
                      final tasks = TaskModel(
                        id: task['id'],
                        title: task['name'],
                        description: task['description'],
                        duration: task['duration'],
                      );
                      return TaskCard(
                        title: tasks.title,
                        description: tasks.description,
                        duration: tasks.duration,
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Task'),
                              content: const Text(
                                'Are you sure you want to delete this task?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ///to delete
                                    controller.deleteTasks(tasks: tasks);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddNewTaskScreen(isUpdate: true, task: tasks),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewTaskScreen(isUpdate: false),
            ),
          );
        },
        backgroundColor: const Color(0xFF8F73F8),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
