import 'package:course_scheduling/main.dart';
import 'package:course_scheduling/models/class.dart';
import 'package:course_scheduling/widgets/calander.dart';
import 'package:course_scheduling/widgets/tile.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {

  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    final myClasses = [
      ClassItem(day: "Monday", startHour: 9, endHour: 10, title: "Math", color: Colors.blue, room: "1001", lecturer: 'Mr araham',code: 'cs132' ),
      ClassItem(day: "Tuesday", startHour: 9, endHour: 11, title: "Math", color: Colors.blue, room: "1001", lecturer: 'Mr araham',code: 'cs132' ),

    ];
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      body: SingleChildScrollView(  // <-- scrollable
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Weekly Schedule"),
                        SizedBox(height: 4),
                        Text("Your weekly class schedule"),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),

                // First row of Tiles
                Row(
                  children: [
                    Expanded(
                        child: Tile(
                            title: "This Week",
                            subTitle: "5 Classes",
                            icon: Icons.check_circle_outline)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Tile(
                            title: "Total Hours",
                            subTitle: "10 hours",
                            icon: Icons.watch_rounded)),
                  ],
                ),
                const SizedBox(height: 12),

                // Second row of Tiles
                Row(
                  children: [
                    Expanded(
                        child: Tile(
                            title: "Total Hours",
                            subTitle: "10 hours",
                            icon: Icons.check_circle_outline)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Tile(
                            title: "Total Hours",
                            subTitle: "10 hours",
                            icon: Icons.check_circle_outline)),
                  ],
                ),
                const SizedBox(height: 16),

                // Calendar

                WeeklyCalendar(classes: myClasses,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
