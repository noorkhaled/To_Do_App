import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/ui/pages/home_page.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';
import 'package:todo_app/ui/widgets/input_field.dart';

import '../../models/task.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController notecontroller = TextEditingController();
  DateTime selecteddate = DateTime.now();
  String starttime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endtime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int selectedremind = 5;
  List<int> remindlist = [5, 10, 15, 20];
  String selectedrepeat = 'None';
  List<String> repeatlist = ['None', 'Daily', 'weekly', 'Monthly'];
  int selectedcolor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, size: 24, color: primaryClr),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 18,
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Add Task', style: Themes().headingStyle),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Title here'),
                controller: titlecontroller,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Note',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Note here'),
                controller: notecontroller,
              ),
              // InputField(
              //   title: 'Note',
              //   hint: 'Enter Note here',
              //   controller: notecontroller,
              // ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(selecteddate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
                  onPressed: () {
                   getdatefromuser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: starttime,
                      widget: IconButton(
                        icon:
                            Icon(Icons.access_time_rounded, color: Colors.grey),
                        onPressed: () {
                          gettimefromuser(isStarttime: true);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: endtime,
                      widget: IconButton(
                        icon:
                            Icon(Icons.access_time_rounded, color: Colors.grey),
                        onPressed: () {
                          gettimefromuser(isStarttime: false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$selectedremind minutes early',
                widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  items: remindlist
                      .map((items) => DropdownMenuItem(
                          value: items,
                          child: Text('$items',
                              style: TextStyle(color: Colors.white))))
                      .toList(),
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  elevation: 4,
                  iconSize: 32,
                  underline: Container(height: 0),
                  style: Themes().subtitleStyle,
                  onChanged: (value) {
                    setState(() {
                      selectedremind = value!;
                    });
                  },
                ),
              ),
              InputField(
                title: 'Repeat',
                hint: selectedrepeat,
                widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  items: repeatlist
                      .map((items) => DropdownMenuItem(
                          value: items,
                          child: Text('$items',
                              style: TextStyle(color: Colors.white))))
                      .toList(),
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  elevation: 4,
                  iconSize: 32,
                  underline: Container(height: 0),
                  style: Themes().subtitleStyle,
                  onChanged: (value) {
                    setState(() {
                      selectedrepeat = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Color', style: Themes().titleStyle),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedcolor = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                child: selectedcolor == index
                                    ? Icon(Icons.done,
                                        size: 16, color: Colors.white)
                                    : null,
                                backgroundColor: index == 0
                                    ? primaryClr
                                    : index == 1
                                        ? pinkClr
                                        : orangeClr,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  MyButton(
                      label: 'Create Task',
                      ontap: () {
                        validatedata();
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  addtasktodb() async {
    int value = await _taskController.addtask(
      task: Task(
        title: titlecontroller.text,
        note: notecontroller.text,
        isCompleted: 0,
        date: DateFormat().add_yMd().format(selecteddate),
        startTime: starttime,
        endTime: endtime,
        color: selectedcolor,
        remind: selectedremind,
        repeat: selectedrepeat,
      ),
    );
  }

  validatedata() {
    if (titlecontroller.text.isNotEmpty && notecontroller.text.isNotEmpty) {
      addtasktodb();
      Get.to(HomePage());
    } else if (titlecontroller.text.isEmpty || notecontroller.text.isEmpty) {
      Get.snackbar('required', '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.pink,
          icon: Icon(Icons.warning_amber_rounded, color: Colors.red));
    } else {
      print('########### somethingbadhappens ###########');
    }
  }

  void gettimefromuser({required bool isStarttime}) async{
    TimeOfDay? pickedtime =  await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime:isStarttime? TimeOfDay.now() :TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 15))),
    );
    String formattime = pickedtime!.format(context);
   if(isStarttime) {
     setState(() {
       starttime = formattime;
     });
   }else if(!isStarttime){
      setState(() {
        endtime = formattime;
      });
    }
  }

  getdatefromuser() async {
  DateTime? pickeddate =  await showDatePicker(
      context: context,
      initialDate: selecteddate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );
  setState(() {
    selecteddate = pickeddate!;
  });
  }
}
