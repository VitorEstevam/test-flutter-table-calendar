import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final tasks = LinkedHashMap(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll({
      DateTime(2022, 01, 02): ["aaa", "bbb"],
      DateTime(2022, 01, 06): ["ccc"],
    });

  List<String> getTasks(DateTime day) {
    return tasks[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TableCalendar(
        firstDay: DateTime.utc(2022, 01, 01),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.utc(2022, 01, 01),
        eventLoader: (day) {
          return getTasks(day);
        },
      ),
    );
  }
}
