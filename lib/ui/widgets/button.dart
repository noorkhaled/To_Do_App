import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/pages/add_task_page.dart';
import 'package:todo_app/ui/pages/home_page.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function ontap;

  const MyButton({super.key, required this.label, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ontap();
        },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: primaryClr,
        ),
        width: 100,
        height: 45,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
