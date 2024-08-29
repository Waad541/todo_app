import 'package:flutter/material.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/taskmodel.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectDate = DateTime.now();
  var titleController=TextEditingController();
  var subtitleController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
        ? Color(0xff141922)
        : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Task',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text(
                  'Title',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: subtitleController,
              decoration: InputDecoration(
                label: Text(
                  'Description',
                    style: Theme.of(context).textTheme.bodyMedium,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Select Time',
               style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 18),
            InkWell(
                onTap: () {
                  selectDateFun();
                },
                child: Text(selectDate.toString().substring(0, 10),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16))),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                TaskModel task= TaskModel(
                    title: titleController.text,
                    subtitle: subtitleController.text,
                    date: DateUtils.dateOnly(selectDate).millisecondsSinceEpoch);
                FirebaseFunction.addTask(task);
                Navigator.pop(context);
              },
              child: Text(
                'Add task',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xff5D9CEC)),
            ),
          ],
        ),
      ),
    );
  }

  selectDateFun() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                primary: Color(0xff5D9CEC),
              )),

              child: child!,
            ),
        initialDate: selectDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if (chosenDate != null) {
      selectDate = chosenDate;
      setState(() {});
    }
  }
}
