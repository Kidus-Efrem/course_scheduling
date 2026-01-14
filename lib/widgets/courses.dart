import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  String courseName;
  String lecturer;
  String room;
  String courseNumber;
  String numberOfStudent;
  Courses({
    super.key,
    required this.lecturer,
    required this.courseName,
    required this.numberOfStudent,
    required this.room,
    required this.courseNumber
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow:[BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 6),
              color: Colors.black.withOpacity(0.15)
            )]
            ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.book_outlined,
                          color: Colors.white,
                        ),
                      ),
                SizedBox(height: 8,),
                Text(courseNumber),
                SizedBox(height: 8,),

                Text(courseName),
                SizedBox(height: 8,),

                 Text(lecturer),
                SizedBox(height: 8,),

                  Text(room),

                SizedBox(height: 8,),

                  Text(numberOfStudent),
                SizedBox(height: 8,),

               SizedBox(
                  height: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ),
                  ),
                ),


               ]),
          ),
        ),

    );
  }
}
