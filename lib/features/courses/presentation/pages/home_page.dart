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
      appBar: AppBar(
  toolbarHeight: 110,
  elevation: 4,
  backgroundColor: Colors.transparent,
  
  centerTitle: false,

  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blue.shade200,
          Colors.blue.shade700,
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 3),
          blurRadius: 8,
        ),
      ],
    ),
  ),

  title: Row(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.calendar_today_outlined,
          color: Colors.white,
          size: 22,
        ),
      ),
      const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Weekly Schedule",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Your weekly class schedule",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ],
  ),
),

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
