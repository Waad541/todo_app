import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_functions.dart';

import '../TaskItem.dart';

class TaskTab extends StatefulWidget {
  static const String routeName = 'task';

   TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  DateTime date=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: date,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (dateTime) {
            date=dateTime;
            setState(() {

            });
          },
          leftMargin: 10,
          monthColor: Colors.blueGrey,
          dayColor: Color(0xff5D9CEC),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Color(0xff5D9CEC),
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        ),
        SizedBox(height: 18),
        StreamBuilder(
          stream: FirebaseFunction.getTask(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text('Something went wrong'),
                    ElevatedButton(onPressed: () {}, child: Text('Try again'))
                  ],
                ),
              );
            }
            var tasks = snapshot.data?.docs.map((e) => e.data()).toList() ??[];
            if (tasks.isEmpty) {
              return Center(
                  child: Text(
                'No Tasks',
                    style: Theme.of(context).textTheme.bodyLarge,
              ));
            }
            return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index){
                        return TaskItem(task: tasks[index],);
                      },
                      separatorBuilder: (context,index)=> SizedBox(
                        height: 10,
                      ),
                      itemCount: tasks.length,
                  ),
                );
          },
        )

      ],
    );
  }
}
