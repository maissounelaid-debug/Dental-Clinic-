import 'package:flutter/material.dart';

// تعريف الألوان محلياً لضمان عدم وجود أخطاء
class AppColors {
  static const Color bgDark = Color(0xFF0F172A);
  static const Color panel = Color(0xFF1E293B);
  static const Color neonCyan = Color(0xFF22D3EE);
  static const Color textMuted = Color(0xFF94A3B8);
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(),
              const SizedBox(height: 30),
              _buildProfileMenu(),
              const SizedBox(height: 30),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.neonCyan, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonCyan.withOpacity(0.2),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: const CircleAvatar(
                backgroundColor: AppColors.panel,
                child: Icon(Icons.person, size: 60, color: AppColors.neonCyan),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.neonCyan,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, size: 16, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Dr. Sadik Bessou",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Specialist in Oral Surgery",
          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildProfileMenu() {
    return Column(
      children: [
        _buildMenuTile(Icons.person_outline, "Personal Information"),
        _buildMenuTile(Icons.history_edu, "Medical Qualifications"),
        _buildMenuTile(Icons.notifications_none, "Notification Settings"),
        _buildMenuTile(Icons.security, "Security & Privacy"),
        _buildMenuTile(Icons.help_outline, "Help & Support"),
      ],
    );
  }

  Widget _buildMenuTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.neonCyan.withOpacity(0.05)),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.neonCyan, size: 22),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.textMuted,
          size: 14,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.logout, color: Colors.redAccent),
        label: const Text(
          "Logout Session",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
