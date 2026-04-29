import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';
import '../widgets/neon_button.dart';
import 'checkup_page.dart';
import 'cleaning_page.dart';
import 'profile/xray_images_page.dart';
import 'surgery_page.dart';
import 'book_appointment_page.dart';
import 'find_clinic_page.dart';
import 'notifications_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

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

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Morning!',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textMuted)),
                        Text('Find Your Care',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationsPage()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.panel.withOpacity(0.5),
                          border: Border.all(
                              color: AppColors.neonCyan.withOpacity(0.35)),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_rounded,
                            color: AppColors.neonCyan),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Search
                const NeonPanel(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search services, doctors...',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Banner
                NeonPanel(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your Dental Health',
                                style: TextStyle(
                                    color: AppColors.textMuted, fontSize: 13)),
                            const SizedBox(height: 4),
                            const Text('Book an Appointment\nToday!',
                                style: TextStyle(
                                    color: AppColors.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 160,
                              child: NeonButton(
                                label: 'Book Now',
                                icon: Icons.calendar_today_rounded,
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const BookAppointmentPage()),
                                ),
                                height: 44,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text('🦷', style: TextStyle(fontSize: 56)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text('Our Services',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text)),
                const SizedBox(height: 16),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => const CheckupPage())),
                      child: _buildServiceCard('Checkup',
                          Icons.search_rounded, const Color(0xFF00897B)),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => const CleaningPage())),
                      child: _buildServiceCard('Cleaning',
                          Icons.clean_hands_rounded, const Color(0xFF00ACC1)),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => const XRayImagesPage())),
                      child: _buildServiceCard('X-Ray',
                          Icons.image_rounded, const Color(0xFF26A69A)),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => const SurgeryPage())),
                      child: _buildServiceCard('Surgery',
                          Icons.medical_services_rounded,
                          const Color(0xFF00695C)),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text('Our Doctors',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text)),
                const SizedBox(height: 16),

                _buildDoctorCard(context, 'Dr. Ahmed Benali',
                    'General Dentist', '⭐ 4.9'),
                const SizedBox(height: 12),
                _buildDoctorCard(context, 'Dr. Sara Meziane',
                    'Orthodontist', '⭐ 4.8'),
                const SizedBox(height: 12),
                _buildDoctorCard(context, 'Dr. Karim Hadj',
                    'Oral Surgeon', '⭐ 4.7'),

                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FindClinicPage()),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: AppColors.cardDecoration,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.neonCyan.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.location_on_rounded,
                              color: AppColors.neonCyan),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Find the Clinic',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.text)),
                              Text('Address, hours & directions',
                                  style: TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            size: 14, color: AppColors.neonCyan),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppColors.cardDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.text)),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, String name,
      String specialty, String rating) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppColors.cardDecoration,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.panel2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person_rounded,
                color: AppColors.neonCyan),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.text)),
                Text(specialty,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 13)),
              ],
            ),
          ),
          Column(
            children: [
              Text(rating,
                  style: const TextStyle(color: AppColors.text)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Book',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}