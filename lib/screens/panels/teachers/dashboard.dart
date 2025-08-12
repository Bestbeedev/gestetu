import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../stores/states.dart';

class DashboardTeachers extends StatefulWidget {
  const DashboardTeachers({super.key});

  @override
  State<DashboardTeachers> createState() => _DashboardTeachersState();
}

class _DashboardTeachersState extends State<DashboardTeachers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.grey[50],
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        child: TeacherDashboard(),
      ),
    );
  }
}

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        // Header avec infos personnelles
        const HeaderWidget(),
        const SizedBox(height: 20),

        // Statistiques rapides
        _buildQuickStats(context),
        const SizedBox(height: 30),

        // Prochains cours
        _buildNextClasses(context),
        const SizedBox(height: 30),

        // Tâches à faire
        _buildTodoList(context),
        SizedBox(height: 40),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.3,
      children: [
        _buildStatCard(
          context,
          title: "Total Cours",
          value: "3",
          icon: Iconsax.calendar_1,
          color: Colors.blue,
        ),
        _buildStatCard(
          context,
          title: "Étudiants",
          value: "84",
          icon: Iconsax.people,
          color: Colors.green,
        ),
        _buildStatCard(
          context,
          title: "Devoirs à corriger",
          value: "12",
          icon: Iconsax.document_text,
          color: Colors.orange,
        ),
        _buildStatCard(
          context,
          title: "Moyenne classe",
          value: "14.5",
          icon: Iconsax.chart_2,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
              ),
            ],
          ),

          Divider(thickness: 1, color: Colors.grey[300], height: 20),
          const SizedBox(height: 5),
          Center(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextClasses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Prochains cours",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              _buildClassItem(
                course: "Algorithmique avancée",
                time: "08:00 - 10:00",
                room: "B203",
                group: "L3 Info - Groupe A",
              ),
              const Divider(height: 1),
              _buildClassItem(
                course: "Base de données",
                time: "10:30 - 12:30",
                room: "A101",
                group: "L2 Info - Groupe B",
              ),
              const Divider(height: 1),
              _buildClassItem(
                course: "Programmation mobile",
                time: "14:00 - 16:00",
                room: "C305",
                group: "L3 Info - Groupe C",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassItem({
    required String course,
    required String time,
    required String room,
    required String group,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.indigo.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Iconsax.book_1, color: Colors.indigo),
      ),
      title: Text(course, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(group),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Iconsax.clock, size: 12, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(time),
              const SizedBox(width: 15),
              Icon(Iconsax.building_3, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(room),
            ],
          ),
        ],
      ),
      trailing: const Icon(
        Iconsax.arrow_right_3,
        size: 16,
        color: Colors.indigo,
      ),
      onTap: () {
        // Navigation vers les détails du cours
      },
    );
  }

  Widget _buildTodoList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tâches à faire",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900],
              ),
            ),
            TextButton(onPressed: () {}, child: const Text("Voir tout")),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildTodoItem(
                task: "Corriger le DS Algorithmique",
                due: "Pour demain",
                urgent: true,
              ),
              const SizedBox(height: 10),
              _buildTodoItem(
                task: "Préparer le TP de BD",
                due: "3 jours restants",
                urgent: false,
              ),
              const SizedBox(height: 10),
              _buildTodoItem(
                task: "Envoyer les notes intermédiaires",
                due: "5 jours restants",
                urgent: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        TeacherClassesPanel(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTodoItem({
    required String task,
    required String due,
    required bool urgent,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 40,
          decoration: BoxDecoration(
            color: urgent ? Colors.red : Colors.orange,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Text(
                due,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        Checkbox(
          value: false,
          onChanged: (value) {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  Map<String, dynamic>? _user;

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 0)); // animation/splash delay
    final user = await Store.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.indigo[100],
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/category/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // "Professeur ${_user != null ? _user!['name'] : "Loading..."}",
                'Jacob Gourou',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Informatique - L2/L3",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget pour afficher les filières/classes de l'enseignant
class TeacherClassesPanel extends StatelessWidget {
  final List<Map<String, dynamic>> classes = [
    {
      "name": "L3 Info - Groupe A",
      "students": 28,
      "subject": "Algorithmique avancée",
      "color": Colors.blue,
    },
    {
      "name": "L2 Info - Groupe B",
      "students": 32,
      "subject": "Base de données",
      "color": Colors.green,
    },
    {
      "name": "L3 Info - Groupe C",
      "students": 24,
      "subject": "Programmation mobile",
      "color": Colors.purple,
    },
  ];

  TeacherClassesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mes Classes",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
          ),
        ),
        const SizedBox(height: 15),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: classes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final classe = classes[index];
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                // Naviguer vers la page de la classe
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ClassDetailPage(
                          className: classe["name"],
                          subject: classe["subject"],
                          students: classe["students"],
                        ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.07),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 18,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (classe["color"] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Iconsax.teacher,
                        color: classe["color"],
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classe["name"],
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.book,
                                    size: 15,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    classe["subject"],
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(width: 15),
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.people,
                                    size: 15,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${classe["students"]} élèves",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Iconsax.arrow_right_3,
                      color: Colors.indigo,
                      size: 22,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

// Exemple de page de détails de la classe (à personnaliser selon besoin)
class ClassDetailPage extends StatefulWidget {
  final String className;
  final String subject;
  final int students;

  // Exemple de liste d'étudiants (à remplacer par vos données réelles)
  final List<Map<String, dynamic>> studentList = const [
    {"name": "Alice Dupont"},
    {"name": "Benoit Martin"},
    {"name": "Chloé Bernard"},
    {"name": "David Leroy"},
  ];

  const ClassDetailPage({
    super.key,
    required this.className,
    required this.subject,
    required this.students,
  });

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  late List<TextEditingController> note1Controllers;
  late List<TextEditingController> note2Controllers;

  @override
  void initState() {
    super.initState();
    note1Controllers = List.generate(
      widget.studentList.length,
      (_) => TextEditingController(),
    );
    note2Controllers = List.generate(
      widget.studentList.length,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final c in note1Controllers) {
      c.dispose();
    }
    for (final c in note2Controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _saveNotes() {
    // Récupérer les notes saisies
    List<Map<String, dynamic>> notes = [];
    for (int i = 0; i < widget.studentList.length; i++) {
      notes.add({
        "name": widget.studentList[i]["name"],
        "note1": note1Controllers[i].text,
        "note2": note2Controllers[i].text,
      });
    }
    // Afficher ou enregistrer les notes (à remplacer par votre logique)
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Notes enregistrées !")));
    // print(notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Statistiques/Fiche classe
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.indigo.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Iconsax.people, color: Colors.indigo, size: 32),
                        const SizedBox(height: 6),
                        Text(
                          "${widget.students}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Élèves",
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 48, color: Colors.indigo[100]),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Iconsax.book, color: Colors.blue, size: 32),
                        const SizedBox(height: 6),
                        Text(
                          widget.subject,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Cours",
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 48, color: Colors.indigo[100]),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Iconsax.building_3, color: Colors.green, size: 32),
                        const SizedBox(height: 6),
                        Text(
                          widget.className,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Filière",
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              "Liste des étudiants",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: widget.studentList.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final student = widget.studentList[index];
                  return StudentNoteRow(
                    name: student["name"],
                    note1Controller: note1Controllers[index],
                    note2Controller: note2Controllers[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Iconsax.save_2, color: Colors.white),
                label: const Text(
                  "Enregistrer les notes",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: _saveNotes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget pour afficher une ligne étudiant avec saisie des notes
class StudentNoteRow extends StatelessWidget {
  final String name;
  final TextEditingController note1Controller;
  final TextEditingController note2Controller;

  const StudentNoteRow({
    super.key,
    required this.name,
    required this.note1Controller,
    required this.note2Controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(name, style: const TextStyle(fontSize: 16)),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: note1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Note 1",
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextField(
              controller: note2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Note 2",
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Ajoutez ce widget dans le Column de TeacherDashboard (par exemple juste après les statistiques rapides)
