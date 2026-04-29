import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Appointment Confirmed',
      'body':
          'Your checkup with Dr. Ahmed Benali on Apr 10 at 10:00 AM is confirmed.',
      'time': '2 min ago',
      'icon': Icons.check_circle_rounded,
      'color': const Color(0xFF00897B),
      'read': false,
    },
    {
      'title': 'Reminder — Tomorrow',
      'body':
          'You have Teeth Cleaning with Dr. Sara Meziane tomorrow at 2:00 PM.',
      'time': '1 hour ago',
      'icon': Icons.notifications_active_rounded,
      'color': const Color(0xFF00ACC1),
      'read': false,
    },
    {
      'title': 'Appointment Pending',
      'body':
          'Your X-Ray appointment on Apr 21 is awaiting clinic confirmation.',
      'time': 'Yesterday',
      'icon': Icons.access_time_rounded,
      'color': const Color(0xFF26A69A),
      'read': true,
    },
    {
      'title': 'Medical Record Updated',
      'body':
          'Dr. Ahmed Benali updated your medical file after your last visit.',
      'time': '2 days ago',
      'icon': Icons.folder_rounded,
      'color': const Color(0xFF00695C),
      'read': true,
    },
    {
      'title': 'Special Offer',
      'body':
          'Get 20% off teeth whitening this month. Book now to claim your discount.',
      'time': '3 days ago',
      'icon': Icons.local_offer_rounded,
      'color': const Color(0xFF4DB6AC),
      'read': true,
    },
  ];

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n['read'] = true;
      }
    });
  }

  void _dismiss(int index) {
    setState(() => _notifications.removeAt(index));
  }

  int get _unreadCount => _notifications.where((n) => !n['read']).length;

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
                      onTap: () => Navigator.pop(context),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                          Text(
                            _unreadCount > 0
                                ? '$_unreadCount unread'
                                : 'All caught up',
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_unreadCount > 0)
                      GestureDetector(
                        onTap: _markAllRead,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00897B).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Mark all read',
                            style: TextStyle(
                              color: Color(0xFF00897B),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // List
              Expanded(
                child: _notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_off_rounded,
                              size: 52,
                              color: const Color(0xFF26A69A).withOpacity(0.35),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No notifications',
                              style: TextStyle(
                                color: Color(0xFF26A69A),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          final n = _notifications[index];
                          final read = n['read'] as bool;
                          final color = n['color'] as Color;

                          return Dismissible(
                            key: Key('notif_$index${n['title']}'),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => _dismiss(index),
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () => setState(() => n['read'] = true),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: read
                                      ? const Color(0xFFF0FAF7)
                                      : color.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: read
                                        ? const Color(0xFFB2DFDB)
                                        : color.withOpacity(0.4),
                                    width: read ? 0.8 : 1.5,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        n['icon'] as IconData,
                                        color: color,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  n['title'] as String,
                                                  style: TextStyle(
                                                    fontWeight: read
                                                        ? FontWeight.w500
                                                        : FontWeight.bold,
                                                    fontSize: 14,
                                                    color: const Color(
                                                      0xFF004D40,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (!read)
                                                Container(
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    color: color,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            n['body'] as String,
                                            style: const TextStyle(
                                              color: Color(0xFF26A69A),
                                              fontSize: 12,
                                              height: 1.4,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            n['time'] as String,
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
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
