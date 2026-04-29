// lib/patient/profile/personal_info_page.dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_bar_widget.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});
  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(children: [
            CustomAppBar(
              title: 'Personal Info',
              action: GestureDetector(
                onTap: () => setState(() => _editing = !_editing),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: _editing
                        ? AppColors.neonTeal
                        : AppColors.neonTeal.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(_editing ? 'Save' : 'Edit',
                      style: TextStyle(
                          color: _editing
                              ? Colors.black
                              : AppColors.neonTeal,
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  // Avatar
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppColors.cardDecoration,
                    child: Column(children: [
                      Stack(children: [
                        Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.neonTeal.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.neonTeal, width: 2),
                          ),
                          child: const Icon(Icons.person_rounded,
                              size: 44, color: AppColors.neonTeal),
                        ),
                        if (_editing)
                          Positioned(bottom: 0, right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: AppColors.neonTeal,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt_rounded,
                                  size: 14, color: Colors.black),
                            ),
                          ),
                      ]),
                      const SizedBox(height: 8),
                      const Text('ADDAL MERIEM',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.text, fontSize: 16)),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  _infoSection('Basic Info', [
                    _field('First Name', 'Meriem',
                        Icons.person_rounded, _editing),
                    _field('Last Name', 'Addal',
                        Icons.person_rounded, _editing),
                    _field('Date of Birth', '01/05/2000',
                        Icons.cake_rounded, _editing),
                    _field('Gender', 'Female',
                        Icons.wc_rounded, false),
                    _field('Blood Type', 'A+',
                        Icons.bloodtype_rounded, false),
                  ]),
                  const SizedBox(height: 16),
                  _infoSection('Contact', [
                    _field('Email', 'patient@docline.dz',
                        Icons.email_rounded, _editing),
                    _field('Phone', '+213 0555 123 456',
                        Icons.phone_rounded, _editing),
                  ]),
                  const SizedBox(height: 16),
                  _infoSection('Address', [
                    _field('Wilaya', '19 - Sétif',
                        Icons.map_rounded, _editing),
                    _field('City', 'Sétif',
                        Icons.location_city_rounded, _editing),
                    _field('Address', '12 Rue des Palmiers',
                        Icons.home_rounded, _editing),
                  ]),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _infoSection(String title, List<Widget> fields) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(title, style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold,
            color: AppColors.neonTeal)),
      ),
      Container(
        decoration: AppColors.cardDecoration,
        child: Column(children: fields),
      ),
    ]);
  }

  Widget _field(String label, String value,
      IconData icon, bool editable) {
    if (editable) {
      return ListTile(
        leading: Icon(icon, color: AppColors.neonTeal, size: 20),
        title: TextFormField(
          initialValue: value,
          style: const TextStyle(color: AppColors.text, fontSize: 15),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
                color: AppColors.textMuted, fontSize: 12),
            border: InputBorder.none,
          ),
        ),
      );
    }
    return ListTile(
      leading: Icon(icon, color: AppColors.neonTeal, size: 20),
      title: Text(label, style: const TextStyle(
          color: AppColors.textMuted, fontSize: 12)),
      subtitle: Text(value, style: const TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w500, fontSize: 15)),
    );
  }
}