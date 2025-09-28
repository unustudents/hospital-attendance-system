import 'package:flutter/material.dart';
import 'home_controller.dart';

/// Example usage of the hybrid attendance service
class AttendanceExampleUsage {
  /// Basic usage with automatic mode detection
  static Future<void> basicUsage() async {
    final controller = HomeController.instance;

    try {
      // This will use dummy data in debug mode, online data in release mode
      final attendanceData = await controller.loadAttendanceData(userId: 1);

      print('Name: ${attendanceData.nama}');
      print('Shift: ${attendanceData.namaShift}');
      print('Total Present: ${attendanceData.totalHadir}');
      print('Data Source: ${controller.dataSourceDescription}');
    } catch (e) {
      print('Error: $e');
    }
  }

  /// Force dummy data usage
  static Future<void> dummyDataUsage() async {
    final controller = HomeController.instance;

    try {
      final attendanceData = await controller.loadDummyData();
      print('Dummy Data - Name: ${attendanceData.nama}');
    } catch (e) {
      print('Error loading dummy data: $e');
    }
  }

  /// Force online data usage
  static Future<void> onlineDataUsage() async {
    final controller = HomeController.instance;

    try {
      // Test connection first
      final isConnected = await controller.testConnection();
      if (!isConnected) {
        print('Backend not accessible');
        return;
      }

      final attendanceData = await controller.loadOnlineData(1);
      print('Online Data - Name: ${attendanceData.nama}');
    } catch (e) {
      print('Error loading online data: $e');
    }
  }

  /// Usage in widget with error handling
  static Widget buildAttendanceWidget() {
    return FutureBuilder<AttendanceDataResult>(
      future: HomeController.instance.loadDataSafely(userId: 1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        final result = snapshot.data!;

        if (!result.isSuccess) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Error: ${result.error}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Retry logic here
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final data = result.data!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama: ${data.nama}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Shift: ${data.namaShift}'),
                      Text(
                        'Jam Shift: ${data.jamMasukShift} - ${data.jamPulangShift}',
                      ),
                      Text(
                        'Data Source: ${HomeController.instance.dataSourceDescription}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Attendance summary
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      'Hadir',
                      data.totalHadir,
                      Colors.green,
                    ),
                  ),
                  Expanded(
                    child: _buildSummaryCard(
                      'Izin',
                      data.totalIzin,
                      Colors.orange,
                    ),
                  ),
                  Expanded(
                    child: _buildSummaryCard(
                      'Sakit',
                      data.totalSakit,
                      Colors.red,
                    ),
                  ),
                  Expanded(
                    child: _buildSummaryCard(
                      'Cuti',
                      data.totalCuti,
                      Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Weekly attendance
              const Text(
                'Presensi Mingguan:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              ...data.presensiMingguan
                  .map(
                    (daily) => Card(
                      child: ListTile(
                        title: Text(daily.tanggal),
                        subtitle: Text(
                          '${daily.jamMasuk ?? '-'} - ${daily.jamPulang ?? '-'}',
                        ),
                        trailing: Chip(
                          label: Text(daily.status),
                          backgroundColor: _getStatusColor(daily.status),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildSummaryCard(String title, int count, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(title, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  static Color _getStatusColor(String status) {
    switch (status) {
      case 'hadir':
        return Colors.green.withOpacity(0.2);
      case 'izin':
        return Colors.orange.withOpacity(0.2);
      case 'sakit':
        return Colors.red.withOpacity(0.2);
      case 'cuti':
        return Colors.blue.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }
}

/// Example page that uses the attendance service
class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {}); // Refresh the data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: AttendanceExampleUsage.buildAttendanceWidget(),
      ),
    );
  }
}
