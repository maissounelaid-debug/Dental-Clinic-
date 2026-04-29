import 'package:flutter/material.dart';

// ── 1. تعريف الألوان لضمان عمل الواجهة ──
class AppColors {
  static const background = Color(0xFF0D2B35);
  static const surface = Color(0xFF1A3A45);
  static const card = Color(0xFF213D4A);
  static const primary = Color(0xFF00D4C8);
  static const primaryDark = Color(0xFF00B4AB);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFC107);
  static const danger = Color(0xFFFF5252);
  static const textPrimary = Color(0xFFE8F4F4);
  static const textMuted = Color(0xFF8AACB8);
  static const border = Color(0xFF2A4A58);
}

// ── 2. الموديلات الضرورية ──
enum AppointmentStatus { pending, accepted, refused }

class Appointment {
  final String patientName;
  final String patientInitials;
  final String date;
  final String time;
  final String type;
  AppointmentStatus status;

  Appointment({
    required this.patientName,
    required this.patientInitials,
    required this.date,
    required this.time,
    required this.type,
    this.status = AppointmentStatus.pending,
  });
}

// بيانات تجريبية (Dummy Data) لكي لا تظهر الشاشة فارغة
List<Appointment> allAppointments = [
  Appointment(
    patientName: "Amira Benali",
    patientInitials: "AB",
    date: "14 Apr",
    time: "10:30 AM",
    type: "Checkup",
  ),
  Appointment(
    patientName: "Youssef Kadri",
    patientInitials: "YK",
    date: "15 Apr",
    time: "02:00 PM",
    type: "Surgery",
  ),
];

// ── 3. شاشة الطلبات (Requests Screen) ──
class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});
  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  // تصفية المواعيد التي حالتها "قيد الانتظار" فقط
  List<Appointment> get _pending => allAppointments
      .where((a) => a.status == AppointmentStatus.pending)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Requests',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${_pending.length} waiting for response',
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _pending.isEmpty
                  ? const Center(
                      child: Text(
                        "No pending requests",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _pending.length,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _RequestCard(
                          appt: _pending[i],
                          onAccept: () => setState(
                            () =>
                                _pending[i].status = AppointmentStatus.accepted,
                          ),
                          onRefuse: () => setState(
                            () =>
                                _pending[i].status = AppointmentStatus.refused,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final Appointment appt;
  final VoidCallback onAccept, onRefuse;
  const _RequestCard({
    required this.appt,
    required this.onAccept,
    required this.onRefuse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.warning.withOpacity(0.2),
                child: Text(
                  appt.patientInitials,
                  style: const TextStyle(color: AppColors.warning),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appt.patientName,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${appt.date} · ${appt.time}',
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onRefuse,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.danger,
                    side: const BorderSide(color: AppColors.danger),
                  ),
                  child: const Text('Refuse'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Accept'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── 4. شاشة الملف الشخصي (Profile Screen) ──
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Avatar Section
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryDark,
                          width: 3,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'DB',
                          style: TextStyle(
                            color: AppColors.background,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.card,
                      child: Icon(
                        Icons.edit,
                        size: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Dr. Benharoune',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Dental Surgeon',
                style: TextStyle(color: AppColors.primary, fontSize: 12),
              ),

              const SizedBox(height: 24),
              // Stats
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '24',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Patients',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '12',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Appts',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              _settingsItem(
                Icons.email_outlined,
                "Email",
                "dr.benharoune@docline.dz",
              ),
              _settingsItem(Icons.phone_outlined, "Phone", "+213 555 123 456"),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout),
                  label: const Text("Log Out"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.danger,
                    side: const BorderSide(color: AppColors.danger),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        label,
        style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
