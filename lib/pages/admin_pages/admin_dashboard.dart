import 'package:flutter/material.dart';
import 'package:upang_eat/main.dart';
import 'package:upang_eat/pages/admin_pages/all_stalls.dart';
import 'package:upang_eat/pages/admin_pages/create_stall_form.dart';
import 'package:upang_eat/pages/admin_pages/create_user_form.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';
import 'package:upang_eat/repositories/user_repository_impl.dart';
import 'package:upang_eat/widgets/admin_widgets/linechart_card.dart';

import '../../main.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<AdminDashboard> {
  final stallRepository = StallRepositoryImpl();
  final userRepository = UserRepositoryImpl(baseUrl: IpAddress.ipAddress);

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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          totalStalls == null || totalUsers == null || activeStalls == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Welcome Admin',
                          style: TextStyle(
                            color: Color(0xFFffffff),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatCard('Total Stalls', totalStalls!),
                            _buildStatCard('Active Stalls', activeStalls!),
                            _buildStatCard('Total Users', totalUsers!),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Card.filled(
                          color: Colors.white,
                          elevation: 8,
                          child: LineChartCard(),
                        ),
                        const SizedBox(height: 20),
                        _buildExpansionTile(
                          title: _stallTitle(),
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const CreateStallForm()
                                  ),
                                );
                                if (result == true) {
                                  _loadDashboardData();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFc5473d),
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              ),
                              child: const Text(
                                  'Add Stall',
                                  style: TextStyle(color: Color(0xFFFFFFFF))
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const AllStallsScreen()
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFc5473d),
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              ),
                              child: const Text(
                                  'See All Stalls',
                                  style: TextStyle(color: Color(0xFFFFFFFF))
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildExpansionTile(
                          title: _userTitle(),
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const CreateUserForm()
                                  ),
                                );
                                if (result == true) {
                                  _loadDashboardData();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFc5473d),
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              ),
                              child: const Text(
                                  'Add User',
                                  style: TextStyle(color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),

    );
  }

  Widget _buildStatCard(String title, int value) {
    return Card.filled(
      color: Colors.white,
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value',
              style: const TextStyle(
                color: Color(0xFFc5473d),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF202020),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile({required Widget title, required List<Widget> children}) {
    return Card.filled(
      color: Colors.white,
      elevation: 8,
      child: ExpansionTile(
        title: title,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stallTitle() {
    return const Text(
      'Stalls',
      style: TextStyle(
        color: Color(0xFFc5473d),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _userTitle() {
    return const Text(
      'Users',
      style: TextStyle(
        color: Color(0xFFc5473d),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
