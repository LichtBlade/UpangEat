import 'package:flutter/material.dart';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/pages/admin_pages/edit_stall.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';

class AllStallsScreen extends StatefulWidget {
  const AllStallsScreen({Key? key}) : super(key: key);

  @override
  _AllStallsScreenState createState() => _AllStallsScreenState();
}

class _AllStallsScreenState extends State<AllStallsScreen> {
  late Future<List<Stall>> futureStalls;

  @override
  void initState() {
    super.initState();
    futureStalls = StallRepositoryImpl().fetchStalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Stalls'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Stall>>(
        future: futureStalls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading stalls: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No stalls available'));
          }

          final stalls = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Stall Name')),
                DataColumn(label: Text('Active')),
                DataColumn(label: Text('Actions')),
              ],
              rows: stalls.map((stall) {
                return DataRow(cells: [
                  DataCell(Text(stall.stallName)),
                  DataCell(
                    Icon(
                      stall.isActive ? Icons.check : Icons.close,
                      color: stall.isActive ? Colors.green : Colors.red,
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditStallScreen(stall: stall),
                              ),
                            );
                            // Refresh the data after editing
                            setState(() {
                              futureStalls = StallRepositoryImpl().fetchStalls();
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDelete(context, stall);
                          },
                        ),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, Stall stall) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete "${stall.stallName}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                _deleteStall(stall.stallId);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deleteStall(int stallId) async {
    try {
      await StallRepositoryImpl().deleteStall(stallId);
      setState(() {
        futureStalls = StallRepositoryImpl().fetchStalls();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stall deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete stall: $e')),
      );
    }
  }
}
