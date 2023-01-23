import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:to_do/pages/home_page.dart';

import '../models/task_widget_model.dart';
import '../services/service.dart';

final CalendarController _controller = CalendarController();
  String text='' ;

class Time1 extends StatefulWidget {
  final String whatabout;
  final dynamic uid;
  const Time1({super.key, required this.whatabout, this.uid});

  @override
  State<Time1> createState() => _Time1State();
}

class _Time1State extends State<Time1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:8.0,left: 10),
            child: Row(children: [
               InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child:const  Icon(Icons.arrow_back))
            ],),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 150,
              child: SfCalendar(
                showNavigationArrow: true,
                showDatePickerButton: true,
                view: CalendarView.month,
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month,
                  CalendarView.timelineDay,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek,
                  CalendarView.timelineMonth
                                     ],
                initialSelectedDate: DateTime.now(),
                controller: _controller,
                onSelectionChanged:  (CalendarSelectionDetails details) {
                    if (_controller.view == CalendarView.month || _controller.view == CalendarView.timelineMonth) {
                        text = DateFormat('dd, MMMM yyyy').format(details.date!).toString();
                        print(text);
                  } else {
                        text = DateFormat('dd, MMMM yyyy hh:mm a').format(details.date!).toString();
                       print(text);
                        }}
                ),
            ),
          ),
          TextButton(onPressed: ()async{
            Model model =  Model( data: whatabout.text , date :text );
            Services().addDataToCollection(model);
              Navigator.push(context, CupertinoPageRoute(builder: (context) => const HomePage()));
              whatabout.text = '';
          }, child:const  Center(child: Text('Save',style: TextStyle(fontSize: 20),)))
        ],
      )),
    );
  }
}