import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/controller/database_controller.dart';
import 'package:sample_project/controller/text_form_provider.dart';
import 'package:sample_project/model/task_model.dart';

class AddNewTaskScreen extends StatelessWidget {
  final bool isUpdate;
  final TaskModel? task;

  const AddNewTaskScreen({super.key, required this.isUpdate, this.task});

  @override
  Widget build(BuildContext context) {
    //providerObject
    final db = context.read<DatabaseController>();
    final form = context.read<TextFormProvider>();

    if (isUpdate && task != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        form.setFields(task!);
      });
    }
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: isUpdate
            ? Text(
                "Update Task",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                'Add New Task',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Work Label
              const Text(
                'Work',
                style: TextStyle(
                  color: Color(0xFF8F73F8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Work TextField
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: TextField(
                  controller: form.title,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter task title',
                    hintStyle: TextStyle(color: Colors.white30),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Description Label
              const Text(
                'Description',
                style: TextStyle(
                  color: Color(0xFF8F73F8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Description TextField
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: TextField(
                  maxLines: 4,
                  controller: form.description,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter task description',
                    hintStyle: TextStyle(color: Colors.white30),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Duration Label
              const Text(
                'Duration',
                style: TextStyle(
                  color: Color(0xFF8F73F8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Duration TextField
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: TextField(
                  maxLines: 1,
                  controller: form.duration,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'e.g., 3 Hrs',
                    hintStyle: TextStyle(color: Colors.white30),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),

              SizedBox(height: 100),

              // const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8F73F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    // Build task model from form input fields
                    final taskModel = form.buildTask();

                    if (isUpdate) {
                      await db.updateTask(tasks: taskModel);
                    } else {
                      await db.addTasks(tasks: taskModel);
                    }
                    form.clearFields();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          isUpdate
                              ? "Task Updated Successfully"
                              : "Task Added Successfully",
                        ),
                      ),
                    );
                  },
                  child: isUpdate
                      ? Text(
                          "Update Task",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          'Create Task',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
