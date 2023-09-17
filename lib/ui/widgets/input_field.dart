import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/size_config.dart';
import 'package:todo_app/ui/theme.dart';

class InputField extends StatelessWidget {
 const  InputField(
      {Key? key,
      required this.title,
      required this.hint,
       this.controller,
        this.widget,
       })
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller ;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: Themes().titleStyle),
            Container(
              padding: EdgeInsets.only(left: 14),
              margin: EdgeInsets.only(top: 8),
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: Themes().subtitleStyle,
                      cursorColor: Get.isDarkMode? Colors.grey[300]:Colors.grey[700],
                      readOnly: Widget != null ? true : false,
                      controller: controller,
                      autofocus: false,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle:  Themes().subtitleStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color: context.theme.backgroundColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color: context.theme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
