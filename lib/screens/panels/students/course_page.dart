import 'package:flutter/material.dart';

// Dummy data for demonstration
class Course {
  final String id;
  final String title;
  final String code;
  final String description;
  final List<Teacher> teachers;

  Course({
    required this.id,
    required this.title,
    required this.code,
    required this.description,
    required this.teachers,
  });
}

class Teacher {
  final String id;
  final String name;
  final String department;
  final String imageUrl; // For avatar/profile picture

  Teacher({
    required this.id,
    required this.name,
    required this.department,
    this.imageUrl = 'https://via.placeholder.com/150', // Placeholder image
  });
}

// Exemple de données (remplacez par votre récupération réelle)
final List<Course> mockCourses = [
  Course(
    id: 'CS101',
    title: 'Programmation Orientée Objet',
    code: 'CS101',
    description: 'Fondamentaux de la programmation avec Dart et Flutter.',
    teachers: [
      Teacher(id: 'T001', name: 'Dr. Alice Smith', department: 'Informatique'),
    ],
  ),
  Course(
    id: 'MA201',
    title: 'Mathématiques I',
    code: 'MA201',
    description: 'Premier cours sur le calcul différentiel et intégral.',
    teachers: [
      Teacher(id: 'T005', name: 'Dr. Émilie Vert', department: 'Physique'),
    ],
  ),
  Course(
    id: 'PH101',
    title: 'Physique I',
    code: 'PH101',
    description:
        'Principes de base de la mécanique classique et de la thermodynamique.',
    teachers: [
      Teacher(id: 'T004', name: 'Prof. Robert Blanc', department: 'Physique'),
      // Exemple d’un enseignant qui enseigne plusieurs cours
    ],
  ),
];

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    // FIX: Wrap the Container in a Scaffold
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.white],
            ),
          ),
          child: SizedBox(
            //height: MediaQuery.of(context).size.height * 1,
            height: 650,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: mockCourses.length,
              itemBuilder: (context, index) {
                final course = mockCourses[index];
                return CourseCard(course: course);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20.0),
      elevation: 0,
      color: Colors.white54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.indigo[800]!.withValues(alpha: 0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Title & Code
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.indigo[800]!.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                '${course.code}: ${course.title}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Course Description
            Text(
              course.description,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 6),
            Divider(thickness: 1),
            const SizedBox(height: 4),

            // Teachers Section Header
            const Text(
              'Enseignant:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.indigoAccent,
              ),
            ),
            const SizedBox(height: 6),

            // List of Teachers (using Wrap for flexibility)
            if (course.teachers.isEmpty)
              const Text(
                'No teachers assigned yet.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    course.teachers
                        .map(
                          (teacher) => Align(
                            alignment: Alignment.centerLeft,
                            child: TeacherChip(teacher: teacher),
                          ),
                        )
                        .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class TeacherChip extends StatelessWidget {
  final Teacher teacher;

  const TeacherChip({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Chip(
      // avatar: CircleAvatar(
      //   backgroundImage: NetworkImage(teacher.imageUrl),
      //   backgroundColor: Colors.grey.shade200,
      // ),
      label: Text(
        teacher.name,
        textAlign: TextAlign.start,
        style: const TextStyle(color: Colors.indigo),
      ),
      backgroundColor: Colors.green.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.green.shade200, width: 1),
      ),
      elevation: 2,
    );
  }
}
