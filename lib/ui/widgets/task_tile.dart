import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/size_config.dart';
import 'package:todo_app/ui/theme.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.task);
final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(SizeConfig.orientation==Orientation.landscape ?4:20)
        ),
        width: SizeConfig.orientation==Orientation.landscape?SizeConfig.screenWidth/2:SizeConfig.screenWidth,
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: getbgrclr(task.color)
          ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title!,style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),),
                      SizedBox(height: 10),
                      Row(children: [
                       Icon(Icons.access_time_rounded,color: Colors.grey[200],size: 18),
                       SizedBox(width: 10),
                        Text('${task.startTime} - ${task.endTime}',style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),)
                      ],),
                      SizedBox(height: 10),
                      Text(task.note!,style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[100],
                        ),
                      ),)
                    ],
                  ),
                ),),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  width: 0.5,
                  color: Colors.grey[200]!.withOpacity(0.7),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(task.isCompleted == 0?'TODO':'Completed',style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[100],
                      ),
                  ),),
                ),
              ],
            ),
        ),
        );
  }

  getbgrclr(int? color) {
    switch(color){
      case 0:
          return bluishClr;
      case 1:
          return pinkClr;
      case 2:
          return orangeClr;
      default:
          return bluishClr;
    }
  }
}
