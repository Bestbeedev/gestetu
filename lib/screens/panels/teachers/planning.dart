import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PlanningTeachers extends StatefulWidget {
  const PlanningTeachers({super.key});

  @override
  State<PlanningTeachers> createState() => _PlanningTeachersState();
}

class _PlanningTeachersState extends State<PlanningTeachers> {
  final List<String> _tasks = [];
  final List<String> _homeworks = [];
  final List<String> _courses = [];

  void _showAddBottomSheet(String type) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ajouter $type',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Iconsax.add),
                    label: const Text(
                      'Ajouter',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      if (controller.text.trim().isEmpty) return;
                      setState(() {
                        if (type == 'Tâche') {
                          _tasks.add(controller.text.trim());
                        } else if (type == 'Devoir à corriger') {
                          _homeworks.add(controller.text.trim());
                        } else if (type == 'Cours à planifier') {
                          _courses.add(controller.text.trim());
                        }
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildSection(
    String title,
    List<String> items,
    String type,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: color, size: 26),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        children: [
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Aucun élément',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ...items.map(
            (e) => ListTile(
              title: Text(e, style: const TextStyle(fontSize: 15)),
              trailing: IconButton(
                icon: const Icon(Iconsax.trash, color: Colors.redAccent),
                onPressed: () {
                  setState(() {
                    items.remove(e);
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: color,
                side: BorderSide(color: color.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              icon: const Icon(Iconsax.add_circle, size: 20),
              label: Text(
                'Ajouter $type',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onPressed: () => _showAddBottomSheet(type),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Planification de la journée",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 18),
            _buildSection(
              'Tâches à faire',
              _tasks,
              'Tâche',
              Iconsax.task_square,
              Colors.blueAccent,
            ),
            _buildSection(
              'Devoirs à corriger',
              _homeworks,
              'Devoir à corriger',
              Iconsax.document_text,
              Colors.deepPurple,
            ),
            _buildSection(
              'Cours à planifier',
              _courses,
              'Cours à planifier',
              Iconsax.book,
              Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
