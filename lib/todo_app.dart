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
    }else {
      setState(() {
        _autoValidate = AutovalidateMode.onUserInteraction;
      });
    }
  }
void _showDatePicker(){
    BottomPicker.dateTime(
      pickerTitle: Text(
        'Pilih Tanggal & Waktu Deadline',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
      ),
       onSubmit: (date) {
        setState(() {
          selectedDate = date;
        });
 },
      onCloseButtonPressed: () {
        print('Picker closed');
      },
minDateTime: DateTime.now(),
      maxDateTime: DateTime(2025, 12, 31),
      initialDateTime: selectedDate ?? DateTime.now(),
      gradientColors: [Color(0xfffdcbf1), Color(0xffe6dee9)],
    ).show(context);
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Page"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 4, 215, 243),
        leading: Icon(Icons.menu),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deadline :",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year} ${selectedDate!.hour}:${selectedDate!.minute}"
                          : "Pilih Deadline",
                      style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 73, 74, 73)),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.date_range, color: Color.fromARGB(174, 4, 158, 193), size: 35),
                  onPressed: _showDatePicker,
                ),
              ],
            ),
             SizedBox(height: 20),
            Form(
              key: key,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: taskController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Task masih kosong";
                        }
                        return null;
                      },
                      autovalidateMode: _autoValidate,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Task",
                        hintText: "Masukkan Task",
                      ),
                    ),
                  ),




