import 'package:course_scheduling/core/theme/app_pallet.dart';
import 'package:course_scheduling/features/lecturer/presentation/bloc/lecturer_schedule_bloc.dart';
import 'package:course_scheduling/features/lecturer/presentation/pages/lecture_section_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LectureCoursesPage extends StatefulWidget {
  final String userId;
  const LectureCoursesPage({super.key, required this.userId});

  @override
  State<LectureCoursesPage> createState() => _LectureCoursesPageState();
}

class _LectureCoursesPageState extends State<LectureCoursesPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<LecturerScheduleBloc>()
        .add(LoadLecturerSchedule(lecturerId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Custom header is inside the body
      body: BlocBuilder<LecturerScheduleBloc, LecturerScheduleState>(
        builder: (context, state) {
          if (state is LecturerScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          }
           if (state is LecturerScheduleFailure) {
            return Center(child: Text(state.message));
          }
          if (state is LecturerScheduleLoaded) {
            final assignments = state.assignments;
            if (assignments.isEmpty) {
              return const Center(child: Text('No courses assigned.'));
            }
            return Column(
              children: [
                // Custom Header
                Container(
                   width: double.infinity,
                   padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                   color: const Color(0xFF00C853),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text("Teaching", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                       Text("${assignments.length} courses this semester", style: const TextStyle(color: Colors.white70)),
                     ],
                   ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: assignments.length,
                    itemBuilder: (context, index) {
                      final assignment = assignments[index];
                      final courseName = assignment['courses']['name'];
                      final courseCode = assignment['courses']['code'] ?? "CS${100+index}"; // Mock code if missing
                      final sectionName = assignment['sections']['name'];


                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                             BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LectureSectionPage(
                                    courseId: assignment['course_id'],
                                    sectionId: assignment['section_id'],
                                    courseName: courseName,
                                    sectionName: sectionName,
                                    userId: widget.userId,
                                  ),
                                ),
                              );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Text(courseCode, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                     Container(
                                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                       decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                                       child: const Text("3 Credits", style: TextStyle(fontSize: 10, color: Colors.black54)),
                                     ),
                                     const Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(courseName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    const Text("Mon & Wed, 09:00-11:00", style: TextStyle(color: Colors.grey, fontSize: 13)), // Mocked schedule
                                  ],
                                ),
                                const SizedBox(height: 4),
                                 Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    const Text("Room 101", style: TextStyle(color: Colors.grey, fontSize: 13)), // Mocked Room
                                  ],
                                ),
                                 const SizedBox(height: 4),
                                 Row(
                                  children: [
                                    const Icon(Icons.people, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    const Text("45 students", style: TextStyle(color: Colors.grey, fontSize: 13)), // Mocked Count
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                     const Text("Course Progress", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                     const Spacer(),
                                      const Text("75%", style: TextStyle(fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                LinearProgressIndicator(
                                  value: 0.75,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2962FF)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Initializing...'));
        },
      ),
    );
  }
}
