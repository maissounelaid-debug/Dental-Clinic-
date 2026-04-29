import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';


class MedicalRecordsPage extends StatefulWidget {
  const MedicalRecordsPage({super.key});

  @override
  State<MedicalRecordsPage> createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _records = [
    {
      'title': 'Blood Test Report',
      'doctor': 'Dr. Amrani Karim',
      'date': '15 Mar 2025',
      'type': 'Lab',
      'icon': Icons.science_rounded,
      'color': const Color(0xFF2EF3FF),
      'size': '1.2 MB',
      'status': 'Normal',
      'statusColor': const Color(0xFF10D7C8),
    },
    {
      'title': 'Cardiology Report',
      'doctor': 'Dr. Benmoussa Leila',
      'date': '02 Feb 2025',
      'type': 'Cardiology',
      'icon': Icons.favorite_rounded,
      'color': Colors.pinkAccent,
      'size': '3.4 MB',
      'status': 'Review',
      'statusColor': Colors.orange,
    },
    {
      'title': 'General Checkup',
      'doctor': 'Dr. Hadj Ali Nour',
      'date': '10 Jan 2025',
      'type': 'General',
      'icon': Icons.medical_services_rounded,
      'color': const Color(0xFF10D7C8),
      'size': '0.8 MB',
      'status': 'Normal',
      'statusColor': const Color(0xFF10D7C8),
    },
    {
      'title': 'Allergy Panel',
      'doctor': 'Dr. Amrani Karim',
      'date': '05 Dec 2024',
      'type': 'Lab',
      'icon': Icons.biotech_rounded,
      'color': Colors.purple,
      'size': '2.1 MB',
      'status': 'Abnormal',
      'statusColor': Colors.red,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered {
    if (_searchQuery.isEmpty) return _records;
    return _records
        .where((r) =>
            (r['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (r['doctor'] as String).toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _statCard('Total', '${_records.length}', Icons.folder_rounded, AppColors.neonCyan),
                    const SizedBox(width: 12),
                    _statCard('Normal',
                        '${_records.where((r) => r['status'] == 'Normal').length}',
                        Icons.check_circle_rounded, AppColors.neonTeal),
                    const SizedBox(width: 12),
                    _statCard('Review',
                        '${_records.where((r) => r['status'] != 'Normal').length}',
                        Icons.warning_rounded, Colors.orange),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: const TextStyle(color: AppColors.text),
                  decoration: InputDecoration(
                    hintText: 'Search records...',
                    hintStyle: const TextStyle(color: AppColors.textMuted),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.neonCyan),
                    filled: true,
                    fillColor: AppColors.panel,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.stroke)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.stroke)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.neonCyan, width: 1.5)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.panel,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.stroke),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.textMuted,
                    labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    tabs: const [Tab(text: 'All'), Tab(text: 'Lab'), Tab(text: 'Reports')],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _filtered.isEmpty
                    ? _emptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _filtered.length,
                        itemBuilder: (ctx, i) => _recordCard(_filtered[i]),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.neonTeal,
        onPressed: () {},
        child: const Icon(Icons.upload_file_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 20, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.neonCyan),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 4),
          const Text('Medical Records',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: AppColors.neonCyan),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.panel,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final color = record['color'] as Color;
    final statusColor = record['statusColor'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neonCyan.withOpacity(0.12)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(record['icon'] as IconData, color: color, size: 24),
        ),
        title: Text(record['title'] as String,
            style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(record['doctor'] as String,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 10, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text(record['date'] as String,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                const SizedBox(width: 10),
                const Icon(Icons.storage_rounded, size: 10, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text(record['size'] as String,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(record['status'] as String,
                  style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            const Icon(Icons.download_rounded, size: 18, color: AppColors.neonCyan),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open_rounded, size: 60, color: AppColors.textMuted.withOpacity(0.4)),
          const SizedBox(height: 12),
          const Text('No records found', style: TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
