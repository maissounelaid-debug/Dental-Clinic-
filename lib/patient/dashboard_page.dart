import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text('Dashboard',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text)),
              const Text('Your health overview',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13)),

              const SizedBox(height: 24),

              // Stats
              Row(
                children: [
                  Expanded(child: _buildStatCard('Total Visits', '12', Icons.local_hospital_rounded, const Color(0xFF00897B))),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard('Upcoming', '2', Icons.calendar_today_rounded, const Color(0xFF00ACC1))),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildStatCard('Prescriptions', '5', Icons.medical_services_rounded, const Color(0xFF26A69A))),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard('X-Rays', '3', Icons.image_rounded, const Color(0xFF00695C))),
                ],
              ),

              const SizedBox(height: 24),

              // Medical Record Summary
              const Text('Medical Record',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text)),
              const SizedBox(height: 12),

              NeonPanel(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRecordRow('Blood Type', 'A+', Icons.bloodtype_rounded, Colors.red),
                    const Divider(),
                    _buildRecordRow('Last Visit', 'Mar 1, 2026', Icons.calendar_today_rounded, const Color(0xFF00897B)),
                    const Divider(),
                    _buildRecordRow('Diagnosis', 'Cavity Treatment', Icons.medical_information_rounded, const Color(0xFF00ACC1)),
                    const Divider(),
                    _buildRecordRow('Next Appointment', 'Tomorrow', Icons.alarm_rounded, Colors.orange),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Recent Activity
              const Text('Recent Activity',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text)),
              const SizedBox(height: 12),

              _buildActivityItem('Appointment Confirmed', 'Dr. Ahmed Benali confirmed your appointment', '2h ago', Icons.check_circle_rounded, const Color(0xFF00897B)),
              const SizedBox(height: 8),
              _buildActivityItem('New Prescription', 'Dr. Sara added a new prescription', '1d ago', Icons.medical_services_rounded, const Color(0xFF00ACC1)),
              const SizedBox(height: 8),
              _buildActivityItem('X-Ray Uploaded', 'Your X-Ray results are ready', '3d ago', Icons.image_rounded, const Color(0xFF26A69A)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panel.withOpacity(0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke.withOpacity(0.9), width: 1),
        boxShadow: [
          BoxShadow(color: AppColors.neonCyan.withOpacity(0.16), blurRadius: 14),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRecordRow(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.text)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.panel.withOpacity(0.92),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.stroke.withOpacity(0.9), width: 1),
        boxShadow: [
          BoxShadow(color: AppColors.neonCyan.withOpacity(0.10), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.text)),
                Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
        ],
      ),
    );
  }
}