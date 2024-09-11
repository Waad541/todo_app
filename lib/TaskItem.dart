import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/edit.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/taskmodel.dart';

import 'Providers/my_provider.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
  TaskItem({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Container(
      height: 115,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color:  provider.appTheme==ThemeMode.dark ?
            Color(0xff141922)
            : Colors.white,
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunction.deleteTask(task.id);
            },
            label: 'delete'.tr(),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.only(
              topLeft: context.locale == Locale('en') ? Radius.circular(25) : Radius.zero,
              bottomLeft: context.locale == Locale('en') ? Radius.circular(25) : Radius.zero,
              topRight: context.locale == Locale('en') ? Radius.zero : Radius.circular(25),
              bottomRight: context.locale == Locale('en') ? Radius.zero : Radius.circular(25),
            )

          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, Edit.routeName, arguments: task);
            },
            label: 'edit'.tr(),
            backgroundColor: Colors.blue,
            icon: Icons.edit,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                    color: task.isDone ? Colors.green : Color(0xff5D9CEC),
                    borderRadius: BorderRadius.circular(25)),
              ),
              SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(task.title.toString(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: task.isDone
                                  ? Colors.green
                                  : Color(0xff5D9CEC),
                            )),
                    Text(task.subtitle.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: task.isDone ? Colors.green : Colors.grey)),
                  ],
                ),
              ),
              task.isDone
                  ? Text(
                      'Done !',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.green),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        task.isDone = true;
                        FirebaseFunction.updateTask(task);
                      },
                      child: Icon(
                        Icons.done_outline,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5D9CEC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
