// lib/patient/profile/medical_history_page.dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_bar_widget.dart';

class MedicalHistoryPage extends StatelessWidget {
  const MedicalHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      {
        'date': '15 Mar 2026', 'doctor': 'Dr. Ahmed Benali',
        'diagnosis': 'Cavity — Upper right molar',
        'treatment': 'Dental filling applied',
        'status': 'Completed',
      },
      {
        'date': '02 Jan 2026', 'doctor': 'Dr. Sara Meziane',
        'diagnosis': 'Mild gingivitis',
        'treatment': 'Deep cleaning + antibiotics prescribed',
        'status': 'Completed',
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(children: [
            const CustomAppBar(title: 'Medical History'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Summary chips
                  Row(children: [
                    _stat('2', 'Records'),
                    const SizedBox(width: 12),
                    _stat('0', 'Pending'),
                    const SizedBox(width: 12),
                    _stat('A+', 'Blood Type'),
                  ]),
                  const SizedBox(height: 20),
                  ...records.map((r) => _recordCard(r)),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: AppColors.cardDecoration,
        child: Column(children: [
          Text(value, style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,
              color: AppColors.neonTeal)),
          Text(label, style: const TextStyle(
              color: AppColors.textMuted, fontSize: 12)),
        ]),
      ),
    );
  }

  Widget _recordCard(Map<String, String> r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: AppColors.cardDecoration,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.medical_services_rounded,
              color: AppColors.neonTeal, size: 16),
          const SizedBox(width: 6),
          Text(r['date']!, style: const TextStyle(
              color: AppColors.neonTeal,
              fontWeight: FontWeight.bold, fontSize: 13)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.neonTeal.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(r['status']!, style: const TextStyle(
                color: AppColors.neonTeal, fontSize: 11,
                fontWeight: FontWeight.bold)),
          ),
        ]),
        const SizedBox(height: 6),
        Text(r['doctor']!, style: const TextStyle(
            color: AppColors.textMuted, fontSize: 12)),
        const Divider(color: Color(0xFF1A2A44), height: 16),
        _rRow('Diagnosis', r['diagnosis']!),
        const SizedBox(height: 4),
        _rRow('Treatment', r['treatment']!),
      ]),
    );
  }

  Widget _rRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$label: ',
              style: const TextStyle(
                  color: AppColors.textMuted, fontSize: 13)),
          TextSpan(text: value,
              style: const TextStyle(
                  color: AppColors.text, fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}