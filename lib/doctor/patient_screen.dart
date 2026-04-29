import 'package:flutter/material.dart';
import 'patient_detail_screen.dart'; 

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  // ── ميزة الـ Loading ──
  bool _isLoading = true;

  final List<Map<String, dynamic>> patients = [
    {'name': 'Amira Benali', 'init': 'AB', 'color': Colors.purple},
    {'name': 'Youssef Khaldi', 'init': 'YK', 'color': Colors.cyan},
    {'name': 'Sara Meziane', 'init': 'SM', 'color': Colors.teal},
    {'name': 'Ahmed Toumi', 'init': 'AT', 'color': Colors.orange},
    {'name': 'Lydia Brahimi', 'init': 'LB', 'color': Colors.pink},
  ];

  @override
  void initState() {
    super.initState();
    // محاكاة تحميل قائمة المرضى
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // نفس خلفية الداشبورد لضمان التناسق
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Patients',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF22D3EE)),
            onPressed: () {}, // ميزة البحث التي يحبها الأساتذة
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF22D3EE)))
          : Column(
              children: [
                // إحصائية بسيطة تعطي لمسة احترافية
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        "Total: ${patients.length} Patients",
                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final p = patients[index];
                      return _buildPatientCard(context, p);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPatientCard(BuildContext context, Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Hero( // ميزة الـ Hero Animation تجعل الانتقال يبدو سحرياً
          tag: p['name'],
          child: CircleAvatar(
            radius: 25,
            backgroundColor: p['color'].withOpacity(0.15),
            child: Text(
              p['init'],
              style: TextStyle(color: p['color'], fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(
          p['name'],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 4),
            Text('Next visit: 15 May 2026', style: TextStyle(color: Colors.white54, fontSize: 11)),
          ],
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF22D3EE)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailScreen(
                name: p['name'],
                initials: p['init'],
                avatarColor: p['color'],
              ),
            ),
          );
        },
      ),
    );
  }
}