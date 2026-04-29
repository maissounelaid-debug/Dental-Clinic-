import 'package:flutter/material.dart';

// --- استدعاء الملفات ---
import 'dashboard_screen.dart';
import 'patient_screen.dart';
import 'appointment_screen.dart';
import 'profile_screen.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  int _currentIndex = 0;

  // القائمة النهائية للشاشات - تأكدي أن الأسماء تطابق الـ Class داخل كل ملف
  final List<Widget> _screens = [
    const DashboardScreen(),
    const PatientListScreen(), // تأكدي أن هذا الاسم موجود في ملف patient_screen.dart
    const AppointmentScreen(), // تأكدي أن هذا الاسم موجود في ملف appointment_screen.dart
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: const Color(0xFF22D3EE),
        unselectedItemColor: Colors.white24,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
