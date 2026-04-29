import 'package:flutter/material.dart';
import 'register_page.dart'; // صفحة تسجيل المريض (لديك مسبقاً)
import 'doctor_register_page.dart'; // صفحة تسجيل الدكتور (أنشأناها سابقاً)
import 'doctor/dashboard_screen.dart';
import 'doctor/patient_screen.dart';
class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String _selectedRole = 'patient'; // القيمة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF0F4FF,
      ), // خلفية زرقاء فاتحة كما في الصورة
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // زر الرجوع
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black87,
                ),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),

              // أيقونة السن (dental)
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB).withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.medical_services_rounded,
                    size: 38,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // عنوان
              const Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Center(
                child: Text(
                  'Join us and take care of your smile',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 32),

              // I am a
              const Text(
                'I am a',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 14),

              // بطاقتا اختيار الدور
              Row(
                children: [
                  // بطاقة المريض
                  Expanded(
                    child: _RoleCard(
                      title: 'Patient',
                      description:
                          'Book appointments\nand manage your\ndental care',
                      icon: Icons.person_rounded,
                      isSelected: _selectedRole == 'patient',
                      onTap: () => setState(() => _selectedRole = 'patient'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // بطاقة الدكتور
                  Expanded(
                    child: _RoleCard(
                      title: 'Doctor',
                      description: 'Manage your\npractice and\npatients',
                      icon: Icons.medical_services_rounded,
                      isSelected: _selectedRole == 'doctor',
                      onTap: () => setState(() => _selectedRole = 'doctor'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // حقل الاسم الكامل
              _buildField(
                'Full Name',
                'Enter your full name',
                Icons.person_outline_rounded,
              ),
              const SizedBox(height: 16),

              // حقل البريد الإلكتروني
              _buildField(
                'Email',
                'Enter your email',
                Icons.email_outlined,
                type: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // حقل رقم الهاتف
              _buildField(
                'Phone Number',
                'Enter your phone number',
                Icons.phone_outlined,
                type: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // حقل كلمة المرور
              _buildField(
                'Password',
                'Create a password',
                Icons.lock_outline_rounded,
                isPassword: true,
              ),
              const SizedBox(height: 16),

              // حقل تأكيد كلمة المرور
              _buildField(
                'Confirm Password',
                'Confirm your password',
                Icons.lock_outline_rounded,
                isPassword: true,
              ),
              const SizedBox(height: 32),

              // زر التسجيل
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // رابط تسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // عند الضغط على Sign Up — يوجه حسب الدور المختار
  // عند الضغط على Sign Up — يوجه مباشرة للداشبورد المناسبة للعرض
  void _onSignUp() {
    if (_selectedRole == 'patient') {
      // الانتقال مباشرة لواجهة المريض الملونة (Light Theme)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>const PatientListScreen()), // تأكدي من اسم الكلاس
      );
    } else {
      // الانتقال مباشرة لواجهة الدكتور الاحترافية (Dark Theme)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>const DashboardScreen()), // تأكدي من اسم الكلاس
      );
    }
  }

  // ودجت بناء الحقول (مبسّطة — الحقول الكاملة موجودة في صفحات التسجيل)
  Widget _buildField(
    String label,
    String hint,
    IconData icon, {
    TextInputType type = TextInputType.text,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          keyboardType: type,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
            prefixIcon: Icon(icon, color: Colors.black38, size: 20),
            suffixIcon: isPassword
                ? const Icon(
                    Icons.visibility_outlined,
                    color: Colors.black38,
                    size: 20,
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2563EB),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────
// بطاقة اختيار الدور
// ─────────────────────────────────────────────────────
class _RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2563EB)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صف العنوان والراديو
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: isSelected ? const Color(0xFF2563EB) : Colors.black45,
                ),
                const Spacer(),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : Colors.black26,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black45,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
