import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/theme.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/notification_screen.dart';

void main()async {
 WidgetsFlutterBinding.ensureInitialized();
await DBHelper().initDb();
await GetStorage.init();
 runApp(MyApp());
 // NotifyHelper().initializeNotification();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      darkTheme: Themes.dark,
      theme: Themes.light,
      themeMode: ThemeServices().theme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
