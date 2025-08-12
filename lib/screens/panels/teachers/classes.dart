import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Classes extends StatefulWidget {
  const Classes({super.key});

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: TeacherClassesPanel(),
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
        SizedBox(height: 10),
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
                              const SizedBox(width: 15),
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
