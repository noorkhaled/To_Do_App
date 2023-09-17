import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
   NotificationScreen({ required this.payload});
  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          'Title',
          style: TextStyle(
            color:Get.isDarkMode? Colors.white:Colors.black87,
          ),
        )
      ),
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text('hello, Noor',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight:FontWeight.w900,
                        color:Get.isDarkMode? Colors.white:Colors.black87
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('you have new reminder',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight:FontWeight.w900,
                      color:Get.isDarkMode? Colors.white:Colors.grey[400],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:primaryClr,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.text_format,size: 30,color: Colors.white),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Title',
                                style: TextStyle(color:Colors.white, fontSize: 30),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            _payload.toString().split('|')[0],
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.description,size: 30,color: Colors.white),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(color:Colors.white, fontSize: 30),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                        _payload.toString().split('|')[1],
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 20
                            ),
                          ),
                          SizedBox(
                              height: 20
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,size: 30,color: Colors.white),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Date',
                                style: TextStyle(color:Colors.white, fontSize: 30),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            _payload.toString().split('|')[2],
                            style: TextStyle(
                                color:Colors.white,
                                fontSize: 20
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ), 
              SizedBox(
                height: 10,
              ),
            ],
          )
      ),
    );
  }
}
