import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CoursePageDirector extends StatelessWidget {
  const CoursePageDirector({super.key});

  @override
  Widget build(BuildContext context) {
    return CourseManagementPanel();
  }
}

class CourseManagementPanel extends StatefulWidget {
  const CourseManagementPanel({super.key});

  @override
  State<CourseManagementPanel> createState() => _CourseManagementPanelState();
}

enum Operation { filiere, matiere, assignProf }

class _CourseManagementPanelState extends State<CourseManagementPanel> {
  Operation? _selectedOperation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height, // Adjust for AppBar height
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Operation selection section
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            child: Text(
              "Gestion des cours",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              spacing: 16,
              children: [
                _OperationButton(
                  icon: Iconsax.add_square,
                  label: "Ajouter Filière",
                  selected: _selectedOperation == Operation.filiere,
                  onTap:
                      () => setState(
                        () => _selectedOperation = Operation.filiere,
                      ),
                ),
                _OperationButton(
                  icon: Iconsax.book,
                  label: "Ajouter Matière",
                  selected: _selectedOperation == Operation.matiere,
                  onTap:
                      () => setState(
                        () => _selectedOperation = Operation.matiere,
                      ),
                ),
                _OperationButton(
                  icon: Iconsax.user_tag,
                  label: "Assigner Professeur",
                  selected: _selectedOperation == Operation.assignProf,
                  onTap:
                      () => setState(
                        () => _selectedOperation = Operation.assignProf,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Dynamic content based on operation
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  _selectedOperation == null
                      ? Center(
                        child: Icon(
                          Iconsax.arrow_down_1,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                      )
                      : SingleChildScrollView(child: _buildOperationContent()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationContent() {
    switch (_selectedOperation) {
      case Operation.filiere:
        return _AddFiliereSection();
      case Operation.matiere:
        return _AddMatiereSection();
      case Operation.assignProf:
        return _AssignProfSection();
      default:
        return const SizedBox.shrink();
    }
  }
}

class _OperationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OperationButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selected;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final surface = theme.colorScheme.surface;
    final borderColor = isSelected ? primary : Colors.grey[300];
    final bgColor = isSelected ? primary.withOpacity(0.08) : surface;
    final iconColor = isSelected ? primary : Colors.grey[700];
    final textColor = isSelected ? primary : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor!, width: isSelected ? 2 : 1),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: primary.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 26),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Section for adding a filiere
class _AddFiliereSection extends StatefulWidget {
  @override
  State<_AddFiliereSection> createState() => _AddFiliereSectionState();
}

class _AddFiliereSectionState extends State<_AddFiliereSection> {
  final _controller = TextEditingController();
  final List<String> _filieres = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ajouter une nouvelle filière",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Nom de la filière",
                    prefixIcon: Icon(Iconsax.building_3),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Iconsax.add_circle, color: Colors.green),
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty && !_filieres.contains(text)) {
                    setState(() {
                      _filieres.add(text);
                      _controller.clear();
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            fit: FlexFit.loose,
            child:
                _filieres.isEmpty
                    ? Center(
                      child: Text(
                        "Aucune filière ajoutée.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                    : ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filieres.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder:
                          (context, index) => ListTile(
                            leading: const Icon(Iconsax.building_3),
                            title: Text(_filieres[index]),
                            trailing: IconButton(
                              icon: const Icon(
                                Iconsax.trash,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                setState(() => _filieres.removeAt(index));
                              },
                            ),
                          ),
                    ),
          ),
        ],
      ),
    );
  }
}

// Section for adding a matiere to a filiere
class _AddMatiereSection extends StatefulWidget {
  @override
  State<_AddMatiereSection> createState() => _AddMatiereSectionState();
}

class _AddMatiereSectionState extends State<_AddMatiereSection> {
  final _matiereController = TextEditingController();
  String? _selectedFiliere;
  final List<String> _filieres = ["Informatique", "Mathématiques", "Physique"];
  final Map<String, List<String>> _matieres = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ajouter une matière à une filière",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedFiliere,
            items:
                _filieres
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
            onChanged: (v) => setState(() => _selectedFiliere = v),
            decoration: const InputDecoration(
              labelText: "Choisir une filière",
              prefixIcon: Icon(Iconsax.building_3),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _matiereController,
                  decoration: const InputDecoration(
                    hintText: "Nom de la matière",
                    prefixIcon: Icon(Iconsax.book),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Iconsax.add_circle, color: Colors.green),
                onPressed:
                    _selectedFiliere == null
                        ? null
                        : () {
                          final matiere = _matiereController.text.trim();
                          if (matiere.isNotEmpty) {
                            setState(() {
                              _matieres.putIfAbsent(
                                _selectedFiliere!,
                                () => [],
                              );
                              if (!_matieres[_selectedFiliere!]!.contains(
                                matiere,
                              )) {
                                _matieres[_selectedFiliere!]!.add(matiere);
                                _matiereController.clear();
                              }
                            });
                          }
                        },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            fit: FlexFit.loose,
            child:
                _selectedFiliere == null
                    ? Center(
                      child: Text(
                        "Sélectionnez une filière.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                    : (_matieres[_selectedFiliere!] == null ||
                        _matieres[_selectedFiliere!]!.isEmpty)
                    ? Center(
                      child: Text(
                        "Aucune matière ajoutée.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                    : ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _matieres[_selectedFiliere!]!.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder:
                          (context, index) => ListTile(
                            leading: const Icon(Iconsax.book),
                            title: Text(_matieres[_selectedFiliere!]![index]),
                            trailing: IconButton(
                              icon: const Icon(
                                Iconsax.trash,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _matieres[_selectedFiliere!]!.removeAt(index);
                                });
                              },
                            ),
                          ),
                    ),
          ),
        ],
      ),
    );
  }
}

// Section for assigning professors to matieres
class _AssignProfSection extends StatefulWidget {
  @override
  State<_AssignProfSection> createState() => _AssignProfSectionState();
}

class _AssignProfSectionState extends State<_AssignProfSection> {
  String? _selectedFiliere;
  String? _selectedMatiere;
  String? _selectedProf;
  final List<String> _filieres = ["Informatique", "Mathématiques", "Physique"];
  final Map<String, List<String>> _matieres = {
    "Informatique": ["Programmation", "Réseaux"],
    "Mathématiques": ["Algèbre", "Analyse"],
    "Physique": ["Mécanique", "Optique"],
  };
  final List<String> _profs = ["Dr. Diallo", "Mme. Traoré", "M. Konaté"];
  final Map<String, String> _assignments = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assigner un professeur à une matière",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedFiliere,
            items:
                _filieres
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
            onChanged:
                (v) => setState(() {
                  _selectedFiliere = v;
                  _selectedMatiere = null;
                }),
            decoration: const InputDecoration(
              labelText: "Choisir une filière",
              prefixIcon: Icon(Iconsax.building_3),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedMatiere,
            items:
                (_selectedFiliere == null
                        ? <String>[]
                        : _matieres[_selectedFiliere!] ?? <String>[])
                    .map<DropdownMenuItem<String>>(
                      (m) => DropdownMenuItem<String>(value: m, child: Text(m)),
                    )
                    .toList(),
            onChanged: (v) => setState(() => _selectedMatiere = v),
            decoration: const InputDecoration(
              labelText: "Choisir une matière",
              prefixIcon: Icon(Iconsax.book),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedProf,
            items:
                _profs
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
            onChanged: (v) => setState(() => _selectedProf = v),
            decoration: const InputDecoration(
              labelText: "Choisir un professeur",
              prefixIcon: Icon(Iconsax.user),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Iconsax.user_tag),
            label: const Text("Assigner"),
            onPressed:
                (_selectedFiliere != null &&
                        _selectedMatiere != null &&
                        _selectedProf != null)
                    ? () {
                      final key = "${_selectedFiliere!}-${_selectedMatiere!}";
                      setState(() {
                        _assignments[key] = _selectedProf!;
                      });
                    }
                    : null,
          ),
          const SizedBox(height: 16),
          Flexible(
            fit: FlexFit.loose,
            child:
                _assignments.isEmpty
                    ? Center(
                      child: Text(
                        "Aucune assignation.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                    : ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _assignments.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final key = _assignments.keys.elementAt(index);
                        final parts = key.split('-');
                        return ListTile(
                          leading: const Icon(Iconsax.user_tag),
                          title: Text("${parts[1]} (${parts[0]})"),
                          subtitle: Text(_assignments[key]!),
                          trailing: IconButton(
                            icon: const Icon(
                              Iconsax.trash,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                _assignments.remove(key);
                              });
                            },
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
