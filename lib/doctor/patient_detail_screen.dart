import 'package:flutter/material.dart';

// ── 1. تعريف الألوان لضمان عدم وجود أخطاء (Imports) ──
class AppColors {
  static const Color bgDark1 = Color(0xFF0F172A);
  static const Color bgDark2 = Color(0xFF1E293B);
  static const Color panel = Color(0xFF1E293B);
  static const Color neonCyan = Color(0xFF22D3EE);
  static const Color neonTeal = Color(0xFF2DD4BF);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color danger = Color(0xFFF87171);
  
  static const Gradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F172A), Color(0xFF020617)],
  );
}

class PatientDetailScreen extends StatefulWidget {
  // هذه هي "المستقبلات" التي تسمح بنقل البيانات من قائمة المرضى إلى هنا
  final String name;
  final String initials;
  final Color avatarColor;

  const PatientDetailScreen({
    super.key, 
    required this.name, 
    required this.initials, 
    required this.avatarColor
  });

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  bool _isScreenLoading = true;

  @override
  void initState() {
    super.initState();
    // ميزة الـ Loading Indicator (شرط الأستاذ)
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _isScreenLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark1,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: _isScreenLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.neonCyan))
            : SafeArea(
                child: Column(
                  children: [
                    _buildAppBar(context),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildPatientHeader(), // هنا سنستخدم widget.name
                          const SizedBox(height: 25),
                          _buildInfoGrid(),
                          const SizedBox(height: 30),
                          _buildXRaySection(), // ميزة الـ Image Zoom
                          const SizedBox(height: 30),
                          _buildSectionHeader("Medical History"),
                          const SizedBox(height: 15),
                          _buildTimeline(),
                          const SizedBox(height: 30),
                          _buildActionButtons(), // ميزة الـ PDF
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const Text("Patient Profile", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPatientHeader() {
    return Column(
      children: [
        // استخدام Hero Animation للربط السلس
        Hero(
          tag: widget.name, 
          child: CircleAvatar(
            radius: 45,
            backgroundColor: widget.avatarColor.withOpacity(0.2),
            child: Text(widget.initials, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: widget.avatarColor)),
          ),
        ),
        const SizedBox(height: 15),
        // لاحظي استخدام widget.name للوصول للاسم المرسل
        Text(widget.name, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const Text("ID: #GT-2026-08", style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
      ],
    );
  }

  // ميزة الـ Zoom للأشعة (شرط الأستاذ)
  Widget _buildXRaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Digital X-Ray (Interactive Zoom)", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 1.0,
              maxScale: 4.0,
              child: Image.network(
                "https://images.stockfreeimages.com/1520/sfi_m/15206306.jpg",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(child: Text("Image Error", style: TextStyle(color: AppColors.danger))),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ... باقي الواجهات (Timeline, InfoGrid, ActionButtons) كما في الكود السابق
  // مع التأكد من إضافة دوالها تحت هذا السطر
  
  Widget _buildInfoGrid() { /* الكود السابق */ return Container(); }
  Widget _buildTimeline() { /* الكود السابق */ return Container(); }
  Widget _buildSectionHeader(String title) { return Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)); }
  Widget _buildActionButtons() { /* الكود السابق للـ PDF */ return Container(); }
}