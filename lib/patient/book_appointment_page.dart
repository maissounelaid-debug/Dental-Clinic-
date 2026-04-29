// patient/book_appointment_page.dart

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';
import '../widgets/neon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  Future<void> saveAppointment() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      print("USER ID: ${user?.uid}");

      await FirebaseFirestore.instance.collection('appointments').add({
        'userId': user?.uid,
        'doctor': _selectedDoctor,
        'service': _selectedService,
        'date': _selectedDate.toString(),
        'time': _selectedTime,
        'createdAt': Timestamp.now(),
      });

      print("✅ Appointment saved");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Appointment booked!")));
    } catch (e) {
      print("🔥 FIRESTORE ERROR: $e");
    }
  }

  // Step 0 = select service, 1 = select doctor, 2 = select date/time, 3 = confirm
  int _step = 0;

  String? _selectedService;
  String? _selectedDoctor;
  DateTime? _selectedDate;
  String? _selectedTime;

  final List<Map<String, dynamic>> _services = [
    {
      'name': 'General Checkup',
      'icon': Icons.search_rounded,
      'color': const Color(0xFF00897B),
    },
    {
      'name': 'Teeth Cleaning',
      'icon': Icons.clean_hands_rounded,
      'color': const Color(0xFF00ACC1),
    },
    {
      'name': 'X-Ray',
      'icon': Icons.image_rounded,
      'color': const Color(0xFF26A69A),
    },
    {
      'name': 'Surgery',
      'icon': Icons.medical_services_rounded,
      'color': const Color(0xFF00695C),
    },
    {
      'name': 'Orthodontics',
      'icon': Icons.settings_rounded,
      'color': const Color(0xFF00838F),
    },
    {
      'name': 'Whitening',
      'icon': Icons.star_rounded,
      'color': const Color(0xFF4DB6AC),
    },
  ];

  final List<Map<String, dynamic>> _doctors = [
    {
      'name': 'Dr. Ahmed Benali',
      'specialty': 'General Dentist',
      'rating': '4.9',
      'available': true,
    },
    {
      'name': 'Dr. Sara Meziane',
      'specialty': 'Orthodontist',
      'rating': '4.8',
      'available': true,
    },
    {
      'name': 'Dr. Karim Hadj',
      'specialty': 'Oral Surgeon',
      'rating': '4.7',
      'available': false,
    },
  ];

  final List<String> _times = [
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '4:30 PM',
  ];

  DateTime _focusedMonth = DateTime(2026, 4);

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  void _nextStep() {
    if (_step < 3) setState(() => _step++);
  }

  void _prevStep() {
    if (_step > 0) setState(() => _step--);
  }

  bool get _canProceed {
    switch (_step) {
      case 0:
        return _selectedService != null;
      case 1:
        return _selectedDoctor != null;
      case 2:
        return _selectedDate != null && _selectedTime != null;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          _step == 0 ? Navigator.pop(context) : _prevStep(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4EDEA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF00897B),
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Book Appointment',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        Text(
                          _stepLabel(),
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Step indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: List.generate(4, (i) {
                    final active = i == _step;
                    final done = i < _step;
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 4,
                              decoration: BoxDecoration(
                                color: done || active
                                    ? const Color(0xFF00897B)
                                    : const Color(0xFFB2DFDB),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          if (i < 3) const SizedBox(width: 6),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildStepContent(),
                ),
              ),

              // Bottom button
              if (_step < 3)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: NeonButton(
                    label: _step == 2 ? 'Review Booking' : 'Continue',
                    icon: Icons.arrow_forward_rounded,
                    height: 52,
                    onPressed: _canProceed ? _nextStep : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _stepLabel() {
    switch (_step) {
      case 0:
        return 'Step 1 of 4 — Choose a service';
      case 1:
        return 'Step 2 of 4 — Choose a doctor';
      case 2:
        return 'Step 3 of 4 — Pick a date & time';
      case 3:
        return 'Step 4 of 4 — Confirm booking';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return _buildServiceStep();
      case 1:
        return _buildDoctorStep();
      case 2:
        return _buildDateTimeStep();
      case 3:
        return _buildConfirmStep();
      default:
        return const SizedBox();
    }
  }

  // ── Step 1: Service ──────────────────────────────────────────────────────
  Widget _buildServiceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What service do you need?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Select one service to continue',
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: _services.map((s) {
            final selected = _selectedService == s['name'];
            return GestureDetector(
              onTap: () => setState(() => _selectedService = s['name']),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selected
                      ? (s['color'] as Color).withOpacity(0.15)
                      : const Color(0xFFF0FAF7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selected
                        ? s['color'] as Color
                        : const Color(0xFFB2DFDB),
                    width: selected ? 2 : 0.8,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (s['color'] as Color).withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        s['icon'] as IconData,
                        color: s['color'] as Color,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      s['name'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: selected
                            ? s['color'] as Color
                            : const Color(0xFF004D40),
                      ),
                    ),
                    if (selected)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Icon(
                          Icons.check_circle_rounded,
                          color: s['color'] as Color,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Step 2: Doctor ───────────────────────────────────────────────────────
  Widget _buildDoctorStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose your doctor',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'For $_selectedService',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 16),
        ..._doctors.map((d) {
          final selected = _selectedDoctor == d['name'];
          final available = d['available'] as bool;
          return GestureDetector(
            onTap: available
                ? () => setState(() => _selectedDoctor = d['name'])
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF00897B).withOpacity(0.10)
                    : available
                    ? const Color(0xFFF0FAF7)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF00897B)
                      : const Color(0xFFB2DFDB),
                  width: selected ? 2 : 0.8,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: available
                          ? const Color(0xFFD4EDEA)
                          : const Color(0xFFEEEEEE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: available ? const Color(0xFF00897B) : Colors.grey,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d['name'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: available
                                ? const Color(0xFF004D40)
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          d['specialty'] as String,
                          style: TextStyle(
                            color: available
                                ? const Color(0xFF26A69A)
                                : Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: available
                                  ? const Color(0xFFFFA726)
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              d['rating'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: available
                                    ? const Color(0xFF004D40)
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (!available)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Unavailable',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    )
                  else if (selected)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF00897B),
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Step 3: Date & Time ──────────────────────────────────────────────────
  Widget _buildDateTimeStep() {
    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final daysInMonth = DateTime(
      _focusedMonth.year,
      _focusedMonth.month + 1,
      0,
    ).day;
    final startWeekday = firstDay.weekday % 7;
    final today = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pick a date & time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 16),

        // Mini calendar
        NeonPanel(
          padding: EdgeInsets.zero,
          borderRadius: 16,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => setState(
                        () => _focusedMonth = DateTime(
                          _focusedMonth.year,
                          _focusedMonth.month - 1,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4EDEA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          color: Color(0xFF00897B),
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      '${_monthName(_focusedMonth.month)} ${_focusedMonth.year}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.text,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(
                        () => _focusedMonth = DateTime(
                          _focusedMonth.year,
                          _focusedMonth.month + 1,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4EDEA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF00897B),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                      .map(
                        (d) => SizedBox(
                          width: 36,
                          child: Center(
                            child: Text(
                              d,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.6,
                  ),
                  itemCount: startWeekday + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < startWeekday) return const SizedBox();
                    final day = index - startWeekday + 1;
                    final date = DateTime(
                      _focusedMonth.year,
                      _focusedMonth.month,
                      day,
                    );
                    final isPast =
                        date.isBefore(today) && !_isSameDay(date, today);
                    final isSelected =
                        _selectedDate != null &&
                        _isSameDay(date, _selectedDate!);
                    final isToday = _isSameDay(date, today);

                    return GestureDetector(
                      onTap: isPast
                          ? null
                          : () => setState(() => _selectedDate = date),
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF00897B)
                              : isToday
                              ? const Color(0xFF00897B).withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '$day',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected || isToday
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Colors.white
                                  : isPast
                                  ? const Color(0xFFB2DFDB)
                                  : AppColors.text,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),

        const SizedBox(height: 20),

        if (_selectedDate != null) ...[
          Text(
            'Available times — ${_selectedDate!.day} ${_monthName(_selectedDate!.month)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _times.map((t) {
              final selected = _selectedTime == t;
              return GestureDetector(
                onTap: () => setState(() => _selectedTime = t),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF00897B)
                        : const Color(0xFFF0FAF7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF00897B)
                          : const Color(0xFFB2DFDB),
                      width: selected ? 2 : 0.8,
                    ),
                  ),
                  child: Text(
                    t,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : const Color(0xFF004D40),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  // ── Step 4: Confirm ──────────────────────────────────────────────────────
  Widget _buildConfirmStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review & Confirm',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Please check your appointment details',
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 20),

        NeonPanel(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _confirmRow(
                Icons.medical_services_rounded,
                'Service',
                _selectedService ?? '—',
                const Color(0xFF00897B),
              ),
              const Divider(color: Color(0xFFB2DFDB), height: 24),
              _confirmRow(
                Icons.person_rounded,
                'Doctor',
                _selectedDoctor ?? '—',
                const Color(0xFF00ACC1),
              ),
              const Divider(color: Color(0xFFB2DFDB), height: 24),
              _confirmRow(
                Icons.calendar_today_rounded,
                'Date',
                _selectedDate != null
                    ? '${_selectedDate!.day} ${_monthName(_selectedDate!.month)} ${_selectedDate!.year}'
                    : '—',
                const Color(0xFF26A69A),
              ),
              const Divider(color: Color(0xFFB2DFDB), height: 24),
              _confirmRow(
                Icons.access_time_rounded,
                'Time',
                _selectedTime ?? '—',
                const Color(0xFF00695C),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Note
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFCC02), width: 0.8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Color(0xFFF9A825),
                size: 18,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'You will receive a confirmation SMS once the appointment is approved by the clinic.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Confirm button
        SizedBox(
          width: double.infinity,
          child: NeonButton(
            label: 'Confirm Appointment',
            icon: Icons.check_rounded,
            height: 52,
            onPressed: () async {
              await saveAppointment(); // 🔥 يحفظ في Firebase
              _showSuccessDialog(); //Navigator.pop(context); // يغلق dialog
              Navigator.pop(context); // يرجع للخلف 🔥 يطلع message
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFB2DFDB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF00897B), fontSize: 15),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _confirmRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF004D40),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF00897B).withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF00897B),
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Appointment Booked!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your appointment has been submitted. You will receive a confirmation soon.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF26A69A), fontSize: 13),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // close dialog
                    Navigator.pop(context); // go back
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00897B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Done', style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
