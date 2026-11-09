import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyToDoListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Task {
  String taskName;
  bool isCompleted;
  Recurrence recurrence;
  DateTime? reminderTime;

  Task({
    required this.taskName,
    this.isCompleted = false,
    this.recurrence = Recurrence.none,
    this.reminderTime,
  });
}

class MyToDoListPage extends StatefulWidget {
  const MyToDoListPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyToDoListPageState createState() => _MyToDoListPageState();
}

enum Recurrence { none, daily, weekly, once }

class _MyToDoListPageState extends State<MyToDoListPage> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 182, 142),
      appBar: AppBar(
        title: const Text(
          'To Do List',
          style: TextStyle(
            color: Colors.white, // Change the color here
          ),
        ),
        backgroundColor: Color.fromARGB(255, 13, 61, 23),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: tasks[index].isCompleted,
              onChanged: (value) {
                setState(() {
                  tasks[index].isCompleted = value!;
                });
              },
            ),
            title: Text(
              tasks[index].taskName,
              style: TextStyle(
                decoration: tasks[index].isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_getRecurrenceString(tasks[index].recurrence)),
                if (tasks[index].reminderTime != null)
                  Text(
                    'Reminder: ${_formatTime(tasks[index].reminderTime!)}',
                  ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editTask(context, index),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Handle menu button tap
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addTask(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    Recurrence selectedRecurrence = Recurrence.none;
    DateTime? selectedReminderTime;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(labelText: 'Task'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: selectedRecurrence,
              onChanged: (value) {
                setState(() {
                  selectedRecurrence = value as Recurrence;
                });
              },
              items: Recurrence.values.map((recurrence) {
                return DropdownMenuItem(
                  value: recurrence,
                  child: Text(_getRecurrenceString(recurrence)),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Recurrence'),
            ),
            const SizedBox(height: 10),
            DateTimePicker(
              onChanged: (DateTime dateTime) {
                selectedReminderTime = dateTime;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasks.add(Task(
                  taskName: taskController.text,
                  recurrence: selectedRecurrence,
                  reminderTime: selectedReminderTime,
                ));
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editTask(BuildContext context, int index) {
    TextEditingController taskController =
        TextEditingController(text: tasks[index].taskName);
    Recurrence selectedRecurrence = tasks[index].recurrence;
    DateTime? selectedReminderTime = tasks[index].reminderTime;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(labelText: 'Task'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: selectedRecurrence,
              onChanged: (value) {
                setState(() {
                  selectedRecurrence = value as Recurrence;
                });
              },
              items: Recurrence.values.map((recurrence) {
                return DropdownMenuItem(
                  value: recurrence,
                  child: Text(_getRecurrenceString(recurrence)),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Recurrence'),
            ),
            const SizedBox(height: 10),
            DateTimePicker(
              initialDateTime: selectedReminderTime,
              onChanged: (DateTime dateTime) {
                selectedReminderTime = dateTime;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasks[index].taskName = taskController.text;
                tasks[index].recurrence = selectedRecurrence;
                tasks[index].reminderTime = selectedReminderTime;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String _getRecurrenceString(Recurrence recurrence) {
    switch (recurrence) {
      case Recurrence.none:
        return 'None';
      case Recurrence.daily:
        return 'Daily';
      case Recurrence.weekly:
        return 'Weekly';
      case Recurrence.once:
        return 'Once';
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }
}

class DateTimePicker extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;
  final DateTime? initialDateTime;

  const DateTimePicker({
    Key? key,
    required this.onChanged,
    this.initialDateTime,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text("Date & Time"),
            subtitle: Text(_formatDateTime(_selectedDateTime)),
            onTap: () => _selectDateTime(context),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMMM d, y - h:mm a').format(dateTime);
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      // ignore: use_build_context_synchronously
      TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (timePicked != null) {
        DateTime combined = DateTime(
          picked.year,
          picked.month,
          picked.day,
          timePicked.hour,
          timePicked.minute,
        );

        setState(() {
          _selectedDateTime = combined;
        });

        widget.onChanged(combined);
      }
    }
  }
}
