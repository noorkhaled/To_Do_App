import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class ThemeServices {
  final GetStorage box = GetStorage();
  final key = 'isDarkMode';
   bool loadthemefromBox(){
         return box.read<bool>(key)?? false;
   }
    savethemeToBox(bool isDarkMode){
     box.write(key, isDarkMode);
    }
  ThemeMode get theme => loadthemefromBox()? ThemeMode.dark:ThemeMode.light;

  void switchthemes(){
    Get.changeThemeMode(loadthemefromBox()?ThemeMode.light:ThemeMode.dark);
    savethemeToBox(!loadthemefromBox());
  }
}
