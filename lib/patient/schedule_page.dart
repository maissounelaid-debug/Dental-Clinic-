import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';
import '../widgets/neon_button.dart';
import 'book_appointment_page.dart';
import 'appointment_detail_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedMonth = DateTime(2026, 4);
  DateTime? _selectedDate;

  final List<Map<String, dynamic>> _appointments = [
    {
      'date': DateTime(2026, 4, 10),
      'doctor': 'Dr. Ahmed Benali',
      'type': 'General Checkup',
      'time': '10:00 AM',
      'status': 'confirmed',
      'color': const Color(0xFF00897B),
    },
    {
      'date': DateTime(2026, 4, 15),
      'doctor': 'Dr. Sara Meziane',
      'type': 'Teeth Cleaning',
      'time': '2:00 PM',
      'status': 'pending',
      'color': const Color(0xFF00ACC1),
    },
    {
      'date': DateTime(2026, 4, 21),
      'doctor': 'Dr. Karim Hadj',
      'type': 'X-Ray',
      'time': '11:00 AM',
      'status': 'pending',
      'color': const Color(0xFF26A69A),
    },
    {
      'date': DateTime(2026, 4, 28),
      'doctor': 'Dr. Ahmed Benali',
      'type': 'Follow-up',
      'time': '9:00 AM',
      'status': 'confirmed',
      'color': const Color(0xFF00897B),
    },
  ];

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<Map<String, dynamic>> _getAppointmentsForDate(DateTime date) =>
      _appointments
          .where((a) => _isSameDay(a['date'] as DateTime, date))
          .toList();

  List<Map<String, dynamic>> _getAppointmentsForMonth(DateTime month) =>
      _appointments.where((a) {
        final d = a['date'] as DateTime;
        return d.year == month.year && d.month == month.month;
      }).toList();

  void _prevMonth() => setState(() =>
      _focusedMonth =
          DateTime(_focusedMonth.year, _focusedMonth.month - 1));

  void _nextMonth() => setState(() =>
      _focusedMonth =
          DateTime(_focusedMonth.year, _focusedMonth.month + 1));

  String _monthName(int month) {
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final selectedAppointments = _selectedDate != null
        ? _getAppointmentsForDate(_selectedDate!)
        : _getAppointmentsForMonth(_focusedMonth);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                // HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Schedule',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text)),
                          Text('Manage your appointments',
                              style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        child: NeonButton(
                          label: 'Book',
                          icon: Icons.add_rounded,
                          height: 44,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const BookAppointmentPage()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // CALENDAR
                NeonPanel(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.zero,
                  borderRadius: 20,
                  child: Column(
                    children: [

                      // MONTH NAV
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: _prevMonth,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.panel2,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.chevron_left_rounded,
                                    color: AppColors.neonCyan),
                              ),
                            ),
                            Text(
                              '${_monthName(_focusedMonth.month)} ${_focusedMonth.year}',
                              style: const TextStyle(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: _nextMonth,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.panel2,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.chevron_right_rounded,
                                    color: AppColors.neonCyan),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // DAYS HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat']
                            .map((d) => Text(d,
                                style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 11)))
                            .toList(),
                      ),

                      const SizedBox(height: 6),

                      _buildDaysGrid(),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _selectedDate != null
                        ? '${_selectedDate!.day} ${_monthName(_selectedDate!.month)}'
                        : '${_monthName(_focusedMonth.month)} Appointments',
                    style: const TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 8),

                // LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedAppointments.length,
                  itemBuilder: (context, i) =>
                      _buildAppointmentCard(selectedAppointments[i]),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ FIXED GRID (WAS MISSING)
  Widget _buildDaysGrid() {
    final firstDay =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final daysInMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    final startWeekday = firstDay.weekday % 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: startWeekday + daysInMonth,
      itemBuilder: (context, index) {
        if (index < startWeekday) return const SizedBox();
        final day = index - startWeekday + 1;
        final date =
            DateTime(_focusedMonth.year, _focusedMonth.month, day);

        return GestureDetector(
          onTap: () => setState(() => _selectedDate = date),
          child: Center(
            child: Text(
              '$day',
              style: const TextStyle(color: AppColors.text),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> apt) {
    final color = apt['color'] as Color;

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(14),
      decoration: AppColors.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(apt['doctor'],
              style: const TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold)),
          Text(apt['type'],
              style: const TextStyle(color: AppColors.textMuted)),
          Text(apt['time'], style: TextStyle(color: color)),
        ],
      ),
    );
  }
}