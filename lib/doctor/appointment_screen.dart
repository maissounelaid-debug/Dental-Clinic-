import 'package:flutter/material.dart';

class AppColors {
  static const Color bgDark = Color(0xFF0F172A);
  static const Color panel = Color(0xFF1E293B);
  static const Color neonCyan = Color(0xFF22D3EE);
  static const Color neonTeal = Color(0xFF2DD4BF);
  static const Color textMuted = Color(0xFF94A3B8);
}

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Appointments',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.neonCyan,
          labelColor: AppColors.neonCyan,
          unselectedLabelColor: AppColors.textMuted,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentList([
            _AppointmentData(
              "Amira Benali",
              "09:30 AM",
              "Cleaning",
              "Confirmed",
              AppColors.neonTeal,
            ),
            _AppointmentData(
              "Youssef Khaldi",
              "11:00 AM",
              "Root Canal",
              "Pending",
              Colors.orange,
            ),
            _AppointmentData(
              "Ahmed Toumi",
              "01:30 PM",
              "Extraction",
              "Confirmed",
              AppColors.neonCyan,
            ),
          ]),
          _buildAppointmentList([
            _AppointmentData(
              "Sara Meziane",
              "Yesterday",
              "Checkup",
              "Completed",
              Colors.grey,
            ),
            _AppointmentData(
              "Mounir Kasmi",
              "15 Apr",
              "Scaling",
              "Completed",
              Colors.grey,
            ),
          ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.neonCyan,
        child: const Icon(Icons.add, color: AppColors.bgDark),
        onPressed: () {},
      ),
    );
  }

  Widget _buildAppointmentList(List<_AppointmentData> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.neonCyan.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Today",
                    style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Container(
                width: 1,
                height: 35,
                color: AppColors.neonCyan.withOpacity(0.2),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      item.type,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(item.status, item.statusColor),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _AppointmentData {
  final String name, time, type, status;
  final Color statusColor;
  _AppointmentData(
    this.name,
    this.time,
    this.type,
    this.status,
    this.statusColor,
  );
}
