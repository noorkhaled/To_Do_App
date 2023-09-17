import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/pages/add_task_page.dart';
import 'package:todo_app/ui/size_config.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyhelper;

  @override
  void initState() {
    super.initState();
    notifyhelper = NotifyHelper();
    notifyhelper.requestiospermissions();
    notifyhelper.initializeNotification();
  }

  final TaskController _taskController = Get.put(TaskController());
  late var selecteddate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              ThemeServices().switchthemes();
              notifyhelper.displaynotification(
                  title: 'Theme changed', body: 'yes');
              notifyhelper.selectNotification;
            },
            icon: Icon(
              Get.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
              color: Get.isDarkMode ? Colors.white : darkGreyClr,
            ),
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
        body: Column(
          children: [
            addtaskbar(),
            adddatebar(),
            SizedBox(height: 10),
            showtasks(),
          ],
        ));
  }

  addtaskbar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat().add_yMMMMd().format(DateTime.now()).toString(),
                  style: Themes().headingStyle),
              Text('Today', style: Themes().subheadingStyle)
            ],
          ),

          MyButton(
              label: '+ Add Task',
               ontap: ()
               async {
                await Get.to(() => AddTaskPage());
                _taskController.gettasks();
              })
        ],
      ),
    );
  }

  adddatebar() {
    return Container(
      margin: EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 60,
        height: 100,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        onDateChange: (newdate) {
          setState(() {
            selecteddate = newdate;
          });
        },
        dayTextStyle:
            TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        dateTextStyle:
            TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        monthTextStyle:
            TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
      ),
    );
  }

  showtasks() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var _task = _taskController.tasklist[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: 1375),
            child: SlideAnimation(
              horizontalOffset: 300,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    showbottomsheet(context, _task);
                  },
                  child: TaskTile(_task),
                ),
              ),
            ),
          );
        },
        itemCount: _taskController.tasklist.length,
      ),
    );
    // return Expanded(
    //   child: GestureDetector(
    //     onTap: () {
    //       showbottomsheet(context,Task(
    //         title: 'T1',
    //         note: 'NOTE',
    //         isCompleted: 1,
    //         startTime: '8:18',
    //         endTime: '2:22',
    //         color: 2,
    //       ),
    //     );
    //   },
    //     child: TaskTile(
    //         Task(
    //       title: 'T1',
    //       note: 'NOTE',
    //       isCompleted: 0,
    //       startTime: '8:18',
    //       endTime: '2:22',
    //       color: 2,
    //     ),
    // ),
    //   ),
    // Obx((){
    //   if(_taskController.tasklist.isEmpty){
    //      return
    //
    //   }else{
    //     return Container(height: 0);
    //   }
    //
    // })
    // );
  }

  Notaskmsg() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              SizeConfig.orientation == Orientation.landscape
                  ? SizedBox(height: 120)
                  : SizedBox(height: 220),
              SvgPicture.asset('images/task.svg',
                  height: 90,
                  semanticsLabel: 'Task',
                  color: primaryClr.withOpacity(0.5)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'You dont have any tasks yet you can add any task as you want!',
                  style: Themes().subtitleStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  buildbottomsheet(
      {required String label,
      required Function() ontap,
      required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        child: Center(
          child: Text(label,
              style: isClose
                  ? Themes().titleStyle
                  : Themes().titleStyle.copyWith(color: Colors.white)),
        ),
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
      ),
    );
  }

  showbottomsheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.30
                : SizeConfig.screenHeight * 0.4),
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
              ),
            ),
            SizedBox(height: 20),
            task.isCompleted == 1
                ? Container()
                : buildbottomsheet(
                    label: 'Task Completed',
                    ontap: () {
                      Get.back();
                    },
                    clr: primaryClr),
            buildbottomsheet(
                label: 'Delete Task',
                ontap: () {
                  Get.back();
                },
                clr: primaryClr),
            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            buildbottomsheet(
                label: 'cancel',
                ontap: () {
                  Get.back();
                },
                clr: primaryClr),
            SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }
}
