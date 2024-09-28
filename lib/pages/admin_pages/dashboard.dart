// TODO: Dami pa ng wala dito.
import 'package:flutter/material.dart';
import 'package:upang_eat/pages/admin_pages/create_stall_form.dart';
import 'package:upang_eat/pages/admin_pages/create_user_form.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color.fromARGB(255, 255, 169, 186),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Text(
                      'Welcome Admin!',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  color: const Color.fromARGB(255, 255, 169, 186),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  color: const Color.fromARGB(255, 255, 169, 186),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  color: const Color.fromARGB(255, 255, 169, 186),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  color: const Color.fromARGB(255, 255, 169, 186),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const CreateUserForm())),
              child: const Text('Create User'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const CreateStallForm())),
              child: const Text('Create Stall'),
            ),
          ],
        ),
      ),
    );
  }
}
