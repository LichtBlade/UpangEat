import 'package:flutter/material.dart';
import 'package:upang_eat/pages/admin_pages/create_stall_form.dart';
import 'package:upang_eat/pages/admin_pages/create_user_form.dart';
import 'package:upang_eat/pages/admin_pages/stall_data_display_list.dart';
import 'package:upang_eat/pages/admin_pages/user_data_display.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color.fromARGB(255, 255, 169, 186),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
                child: Text(
              'Welcome Admin',
              style: TextStyle(
                color: Color(0xFF202020),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Card.filled(
              color: const Color(0xFFF2AAB6),
              elevation: 8,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 380,
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Color(0xFF202020),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    height: 120,
                    width: 380,
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //   color:  const Color(0xFFF2AAB6),
                    //   borderRadius: BorderRadius.circular(8.0),
                    // ),
                    child: const Text(
                      'Something',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
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
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateStallForm())),
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
                                    builder: (context) =>
                                        const StallDataDisplayList())),
                            child: const Text('See All Stalls'),
                          ),
                        ],
                      ),
                    )
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
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateUserForm())),
                            child: const Text('Add User'),
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
                                    builder: (context) =>
                                        const UserDataDisplay())),
                            child: const Text('See All Users'),
                          ),
                        ],
                      ),
                    )
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
