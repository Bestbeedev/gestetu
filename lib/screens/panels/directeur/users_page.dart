import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  // States
  String _searchText = '';
  String _selectedFilter = 'Toutes filières';
  final List<String> _filters = [
    'Toutes filières',
    'L1',
    'L2',
    'L3',
    'Informatique',
    'Gestion',
  ];

  // Simulated users data
  List<Map<String, dynamic>> allUsers = [
    {
      'name': 'Jean Dupont',
      'email': 'jean.dupont@email.com',
      'role': 'L2 Informatique',
      'type': 'student',
      'active': true,
      'avatar': 'JD',
    },
    {
      'name': 'Marie Lambert',
      'email': 'marie.lambert@email.com',
      'role': 'Professeur Eco',
      'type': 'teacher',
      'active': true,
      'avatar': 'ML',
    },
    {
      'name': 'Paul Martin',
      'email': 'paul.martin@email.com',
      'role': 'Admin Finances',
      'type': 'admin',
      'active': false,
      'avatar': 'PM',
    },
    {
      'name': 'Alice Dubois',
      'email': 'alice.dubois@email.com',
      'role': 'L1 Gestion',
      'type': 'student',
      'active': true,
      'avatar': 'AD',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildTabBar(),
              const SizedBox(height: 10),
              _buildFilters(),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildUserList('student'),
                    _buildUserList('teacher'),
                    _buildUserList('admin'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.07),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un utilisateur...',
                prefixIcon: const Icon(Iconsax.search_normal, size: 22),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Material(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _showAddUserDialog,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Iconsax.user_add,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.indigo,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.indigo,
        tabs: [
          Tab(icon: Icon(Iconsax.user, size: 20), text: 'Étudiants'),
          Tab(icon: Icon(Iconsax.teacher, size: 20), text: 'Enseignants'),
          Tab(
            icon: Icon(Iconsax.user_cirlce_add, size: 20),
            text: 'Administratifs',
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = _filters[index];
          final icon = _getFilterIcon(label);
          final selected = _selectedFilter == label;
          return FilterChip(
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = label;
              });
            },
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: selected ? Colors.indigo : Colors.grey[700],
                ),
                const SizedBox(width: 5),
                Text(label),
              ],
            ),
            backgroundColor: Colors.grey[100],
            selectedColor: Colors.indigo[100],
            labelStyle: TextStyle(
              color: selected ? Colors.indigo : Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }

  IconData _getFilterIcon(String label) {
    switch (label) {
      case 'L1':
      case 'L2':
      case 'L3':
        return Iconsax.calendar;
      case 'Informatique':
        return Iconsax.code;
      case 'Gestion':
        return Iconsax.chart;
      default:
        return Iconsax.filter;
    }
  }

  Widget _buildUserList(String type) {
    // Filtrage
    final users =
        allUsers.where((user) {
          if (user['type'] != type) return false;
          if (_selectedFilter != 'Toutes filières') {
            if (!(user['role'] as String).contains(_selectedFilter))
              return false;
          }
          if (_searchText.isNotEmpty) {
            final search = _searchText.toLowerCase();
            if (!(user['name'] as String).toLowerCase().contains(search) &&
                !(user['email'] as String).toLowerCase().contains(search)) {
              return false;
            }
          }
          return true;
        }).toList();

    if (users.isEmpty) {
      return Center(
        child: Text(
          'Aucun utilisateur trouvé.',
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final user = users[index];
        return _buildUserTile(user);
      },
    );
  }

  Widget _buildUserTile(Map<String, dynamic> user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              user['active'] ? Colors.indigo[100] : Colors.grey[300],
          child: Text(
            user['avatar'],
            style: TextStyle(
              color: user['active'] ? Colors.indigo : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: user['active'] ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user['email']),
            const SizedBox(height: 2),
            Text(
              user['role'],
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Iconsax.more, size: 22),
          onSelected: (value) {
            if (value == 'edit') {
              _showEditUserDialog(user);
            } else if (value == 'toggle') {
              _toggleUserStatus(user);
            }
          },
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: const [
                      Icon(Iconsax.edit, size: 18),
                      SizedBox(width: 8),
                      Text('Modifier'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'toggle',
                  child: Row(
                    children: [
                      Icon(
                        user['active']
                            ? Iconsax.user_remove
                            : Iconsax.user_tick,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(user['active'] ? 'Désactiver' : 'Activer'),
                    ],
                  ),
                ),
              ],
        ),
      ),
    );
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Ajouter un utilisateur'),
            content: const Text('Formulaire d\'ajout ici...'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ],
          ),
    );
  }

  void _showEditUserDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Modifier l\'utilisateur'),
            content: Text(
              'Formulaire de modification pour ${user['name']} ici...',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ],
          ),
    );
  }

  void _toggleUserStatus(Map<String, dynamic> user) {
    setState(() {
      user['active'] = !(user['active'] as bool);
    });
  }
}
