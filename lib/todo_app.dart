import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}
class _TodoAppState extends State<TodoApp> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime? selectedDate;
  List<Map<String, dynamic>> daftarTask = [];
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  void addTask() {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Silakan pilih deadline terlebih dahulu!")),
      );
      return;
    }

 if (key.currentState!.validate()) {
      setState(() {
        daftarTask.add({
          "task": taskController.text,
          "deadline": selectedDate,
          "status": false,
        });

         taskController.clear();
        selectedDate = null;
        _autoValidate = AutovalidateMode.disabled;
      });
 ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task berhasil ditambahkan!")),
      );
    }