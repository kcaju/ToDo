import 'package:flutter/material.dart';
import 'package:sample_project/model/task_model.dart';

class TextFormProvider with ChangeNotifier {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController duration = TextEditingController();

  int? editId;

  //to set updated fields
  void setFields(TaskModel task) {
    title.text = task.title;
    description.text = task.description;
    duration.text = task.duration;
    editId = task.id;
    notifyListeners();
  }

  //create Taskmodel from Form
  TaskModel buildTask() {
    return TaskModel(
      id: editId,
      title: title.text.trim(),
      description: description.text.trim(),
      duration: duration.text.trim(),
    );
  }

  //clear all fields
  void clearFields() {
    title.clear();
    description.clear();
    duration.clear();
    editId = null;
    notifyListeners();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    duration.dispose();
    super.dispose();
  }
}
