import 'package:flutter/material.dart';
// ── 1. تعريف الألوان (AppColors) لضمان عدم حدوث أخطاء ──
class AppColors {
  static const Color bgDark1 = Color(0xFF0F172A);
  static const Color bgDark2 = Color(0xFF1E293B);
  static const Color panel = Color(0xFF1E293B);
  static const Color neonCyan = Color(0xFF22D3EE);
  static const Color neonTeal = Color(0xFF2DD4BF);
  static const Color text = Colors.white;
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color danger = Color(0xFFF87171);
  
  static const Gradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F172A), Color(0xFF020617)],
  );
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ── 2. ميزة الـ Loading (طلب الأستاذ) ──
  bool _isLoading = true;
  int _selectedDay = 4;

  @override
  void initState() {
    super.initState();
    // محاكاة تحميل البيانات من السيرفر لمدة 1.5 ثانية
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark1,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.neonCyan),
              )
            : SafeArea(
                child: Column(
                  children: [
                    _buildHero(), // يحتوي على التنبيهات (Notifications)
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildStatsGrid(),
                          const SizedBox(height: 20),
                          _buildQuickActions(),
                          const SizedBox(height: 20),
                          _buildScheduleSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ── 3. ميزة الـ Notifications (طلب الأستاذ) ──
  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Good morning,', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  SizedBox(height: 2),
                  Text('Dr. Sadik Bessou', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.text)),
                ],
              ),
              const Spacer(),
              // الجرس مع Badge التنبيهات
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: AppColors.neonCyan),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center),
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          // حقل البحث
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: AppColors.bgDark2, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: const [
                Icon(Icons.search, color: AppColors.textMuted, size: 18),
                SizedBox(width: 8),
                Text('Search patients...', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        _buildStatCard("128", "Patients", Icons.people_outline, AppColors.neonCyan),
        const SizedBox(width: 12),
        _buildStatCard("12", "Visits", Icons.calendar_today, AppColors.neonTeal),
      ],
    );
  }

  Widget _buildStatCard(String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.panel, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 12),
            Text(val, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quick actions", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _actionBtn(Icons.person_add, "Add", AppColors.neonCyan),
            _actionBtn(Icons.assignment, "Record", AppColors.neonTeal),
            _actionBtn(Icons.medical_services, "Surgery", Colors.purpleAccent),
            _actionBtn(Icons.bar_chart, "Reports", AppColors.danger),
          ],
        ),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 55, height: 55,
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
      ],
    );
  }

  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Today's Schedule", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _aptCard("Amira Benali", "09:30 AM", "Cleaning", AppColors.neonTeal),
        _aptCard("Youssef Khaldi", "11:00 AM", "Extraction", Colors.orangeAccent),
      ],
    );
  }

  Widget _aptCard(String name, String time, String type, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.panel, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Text(name[0], style: TextStyle(color: color))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text(type, style: const TextStyle(color: AppColors.textMuted, fontSize: 12))])),
          Text(time, style: const TextStyle(color: AppColors.neonCyan, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}