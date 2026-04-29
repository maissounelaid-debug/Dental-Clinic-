
import 'package:flutter/material.dart';

class AppColors {
  static const Color bg0    = Color(0xFF0A0F1E);
  static const Color bg1    = Color(0xFF0E1730);
  static const Color panel  = Color(0xFF0F1A33);
  static const Color panel2 = Color(0xFF0D162D);

  static const Color neonCyan = Color(0xFF2EF3FF);
  static const Color neonTeal = Color(0xFF10D7C8);
  static const Color tealDeep = Color(0xFF0A7E8D);

  static const Color text      = Color(0xFFEAF2FF);
  static const Color textMuted = Color(0xFFA7B4D3);
  static const Color stroke    = Color(0xFF1A2A44);

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [bg0, bg1],
  );

  static  LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [neonTeal, tealDeep],
  );

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: panel.withOpacity(0.85),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: neonCyan.withOpacity(0.18), width: 0.8),
  );


 static const LinearGradient registerBgGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromARGB(255, 27, 38, 69), Color.fromARGB(255, 27, 40, 71)], 
);

}