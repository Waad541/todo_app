import 'package:flutter/material.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/taskmodel.dart';

class Edit extends StatefulWidget {
  static const routeName = 'edit';
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  DateTime selectDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var task=ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      body: Card(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Theme.of(context).brightness == Brightness.light
            ? Color(0xff141922)
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Task',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              TextFormField(
                initialValue: task.title,
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: (value) {
                  task.title=value;
                },
                decoration: InputDecoration(
                    label: Text('Title',
                       style: Theme.of(context).textTheme.bodyMedium,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              Spacer(),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                initialValue: task.subtitle,
                onChanged: (value) {
                  task.subtitle=value;
                },
                decoration: InputDecoration(
                    label: Text('Description',
                      style: Theme.of(context).textTheme.bodyMedium,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(height: 10,),
              Text(
                'Selected Time :',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                  onTap: () async{
                    DateTime? newDate=await selectDateFun();
                    if(newDate !=null){
                      task.date=newDate.millisecondsSinceEpoch;
                    }
                    setState(() {

                    });
                  },
                  child: Text(selectDate.toString().substring(0, 10),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16))),
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () async{
                  await FirebaseFunction.updateTask(task);
                  Navigator.pop(context);
                  setState(() {

                  });
                },
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff5D9CEC)),
              ),
              Spacer(flex: 6)

            ],
          ),
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
    return chosenDate;
  }
}
