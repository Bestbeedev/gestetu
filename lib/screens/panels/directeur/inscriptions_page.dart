import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Inscription {
  final String id;
  final String nom;
  final String email;
  final String statut; // 'valide', 'en_attente', 'rejete'
  final String details;

  Inscription({
    required this.id,
    required this.nom,
    required this.email,
    required this.statut,
    required this.details,
  });
}

class InscriptionsPageDirector extends StatefulWidget {
  const InscriptionsPageDirector({super.key});

  @override
  State<InscriptionsPageDirector> createState() =>
      _InscriptionsPageDirectorState();
}

class _InscriptionsPageDirectorState extends State<InscriptionsPageDirector> {
  List<Inscription> inscriptions = [
    Inscription(
      id: '1',
      nom: 'Jean Dupont',
      email: 'jean.dupont@email.com',
      statut: 'en_attente',
      details: 'Licence Informatique, Année 1',
    ),
    Inscription(
      id: '2',
      nom: 'Marie Claire',
      email: 'marie.claire@email.com',
      statut: 'valide',
      details: 'Master Mathématiques, Année 2',
    ),
    Inscription(
      id: '3',
      nom: 'Paul Martin',
      email: 'paul.martin@email.com',
      statut: 'en_attente',
      details: 'Licence Physique, Année 3',
    ),
    Inscription(
      id: '4',
      nom: 'Alice Bernard',
      email: 'alice.bernard@email.com',
      statut: 'rejete',
      details: 'Licence Chimie, Année 2',
    ),
  ];

  void _showDetails(Inscription inscription) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Iconsax.profile_circle,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    inscription.nom,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    inscription.email,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_statusBadge(inscription.statut)],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.document,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(inscription.details)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (inscription.statut == 'en_attente')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[50],
                            foregroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Iconsax.close_circle),
                          label: const Text('Rejeter'),
                          onPressed: () {
                            setState(() {
                              inscriptions =
                                  inscriptions.map((i) {
                                    if (i.id == inscription.id) {
                                      return Inscription(
                                        id: i.id,
                                        nom: i.nom,
                                        email: i.email,
                                        statut: 'rejete',
                                        details: i.details,
                                      );
                                    }
                                    return i;
                                  }).toList();
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[50],
                            foregroundColor: Colors.green[800],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Iconsax.tick_circle),
                          label: const Text('Valider'),
                          onPressed: () {
                            setState(() {
                              inscriptions =
                                  inscriptions.map((i) {
                                    if (i.id == inscription.id) {
                                      return Inscription(
                                        id: i.id,
                                        nom: i.nom,
                                        email: i.email,
                                        statut: 'valide',
                                        details: i.details,
                                      );
                                    }
                                    return i;
                                  }).toList();
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        child: const Text('Fermer'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _statusBadge(String statut) {
    Color color;
    String label;
    IconData icon;
    switch (statut) {
      case 'valide':
        color = Colors.green;
        label = 'Validée';
        icon = Iconsax.verify5;
        break;
      case 'en_attente':
        color = Colors.orange;
        label = 'En attente';
        icon = Iconsax.timer;
        break;
      case 'rejete':
        color = Colors.red;
        label = 'Rejetée';
        icon = Iconsax.close_circle;
        break;
      default:
        color = Colors.grey;
        label = statut;
        icon = Iconsax.info_circle;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final enAttente =
        inscriptions.where((i) => i.statut == 'en_attente').toList();
    final valides = inscriptions.where((i) => i.statut == 'valide').toList();
    final rejetes = inscriptions.where((i) => i.statut == 'rejete').toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _sectionTitle('🕒 Inscriptions en attente', Colors.orange),
            ...enAttente.map((i) => _inscriptionCard(i)),
            const SizedBox(height: 28),
            _sectionTitle('✅ Inscriptions validées', Colors.green),
            ...valides.map((i) => _inscriptionCard(i)),
            if (rejetes.isNotEmpty) ...[
              const SizedBox(height: 28),
              _sectionTitle('❌ Inscriptions rejetées', Colors.red),
              ...rejetes.map((i) => _inscriptionCard(i)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _inscriptionCard(Inscription inscription) {
    Color cardColor;
    switch (inscription.statut) {
      case 'valide':
        cardColor = Colors.green.withOpacity(0.07);
        break;
      case 'en_attente':
        cardColor = Colors.orange.withOpacity(0.07);
        break;
      case 'rejete':
        cardColor = Colors.red.withOpacity(0.07);
        break;
      default:
        cardColor = Colors.grey.withOpacity(0.07);
    }

    return Card(
      color: cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              inscription.statut == 'rejete'
                  ? Colors.red.shade100
                  : inscription.statut == 'valide'
                  ? Colors.green.shade100
                  : Colors.orange.shade100,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Iconsax.profile_2user, color: Colors.white),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                inscription.nom,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            _statusBadge(inscription.statut),
          ],
        ),
        subtitle: Text(
          inscription.details,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: IconButton(
          icon: const Icon(Iconsax.eye, color: Colors.blueAccent),
          onPressed: () => _showDetails(inscription),
          tooltip: 'Voir détails',
        ),
      ),
    );
  }
}
