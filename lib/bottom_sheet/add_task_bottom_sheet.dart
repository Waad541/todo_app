import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/my_provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/taskmodel.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectDate = DateTime.now();
  var titleController = TextEditingController();
  var subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: provider.appTheme == ThemeMode.dark
              ? Color(0xff141922)
              : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'addNewTask'.tr(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text(
                  'title'.tr(),
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
                  'description'.tr(),
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
              'selectTime'.tr(),
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
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 16))),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                TaskModel task = TaskModel(
                    title: titleController.text,
                    subtitle: subtitleController.text,
                    date: DateUtils.dateOnly(selectDate).millisecondsSinceEpoch,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                );
                FirebaseFunction.addTask(task);
                Navigator.pop(context);
              },
              child: Text(
                'addTask'.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff5D9CEC)),
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
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectDate = chosenDate;
      setState(() {});
    }
  }
}
