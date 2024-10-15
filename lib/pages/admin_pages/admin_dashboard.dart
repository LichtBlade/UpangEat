import 'package:flutter/material.dart';
import 'package:upang_eat/main.dart';
import 'package:upang_eat/pages/admin_pages/all_stalls.dart';
import 'package:upang_eat/pages/admin_pages/create_stall_form.dart';
import 'package:upang_eat/pages/admin_pages/create_user_form.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';
import 'package:upang_eat/repositories/user_repository_impl.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<AdminDashboard> {
  final stallRepository = StallRepositoryImpl();
  final userRepository = UserRepositoryImpl(baseUrl: 'http"//192.168.100.25:3000');

  int? totalStalls;
  int? totalUsers;
  int? activeStalls;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      final stalls = await stallRepository.fetchTotalStalls();
      final users = await userRepository.fetchTotalUsers();
      final active = await stallRepository.fetchActiveStalls();

      setState(() {
        totalStalls = stalls ?? 0;
        totalUsers = users ?? 0;
        activeStalls = active ?? 0;
      });
    } catch (error) {
      print('Error loading dashboard data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color.fromARGB(255, 255, 169, 186),
      ),
      body: totalStalls == null || totalUsers == null || activeStalls == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome Admin',
                    style: TextStyle(
                      color: Color(0xFF202020),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card.filled(
                    color: const Color(0xFFF2AAB6),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 380,
                        child: Text(
                          'Overview\nTotal Stalls: $totalStalls\nActive Stalls: $activeStalls\nTotal Users: $totalUsers',
                          style: const TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Card.filled(
                    color: const Color(0xFFF2AAB6),
                    elevation: 8,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        title: _stallTitle(),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () async {
                                    final result = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => const CreateStallForm()),
                                    );
                                    if (result == true) {
                                      _loadDashboardData();
                                    }
                                  },
                                  child: const Text('Add Stall'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const AllStallsScreen()),
                                  ),
                                  child: const Text('See All Stalls'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Card.filled(
                    color: const Color(0xFFF2AAB6),
                    elevation: 8,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        title: _userTitle(),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () async {
                                    final result = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => const CreateUserForm()),
                                    );
                                    if (result == true) {
                                      _loadDashboardData();
                                    }
                                  },
                                  child: const Text('Add User'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _stallTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Stalls',
              style: TextStyle(
                color: Color(0xFF202020),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _userTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Users',
              style: TextStyle(
                color: Color(0xFF202020),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
