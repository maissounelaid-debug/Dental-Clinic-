import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class XRayImagesPage extends StatefulWidget {
  const XRayImagesPage({super.key});

  @override
  State<XRayImagesPage> createState() => _XRayImagesPageState();
}

class _XRayImagesPageState extends State<XRayImagesPage> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All', 'Chest', 'Spine', 'Hand', 'Knee'];

  final List<Map<String, dynamic>> _images = [
    {'title': 'Chest X-Ray', 'date': '15 Mar 2025', 'doctor': 'Dr. Amrani', 'type': 'Chest', 'label': 'PA View'},
    {'title': 'Lumbar Spine', 'date': '02 Feb 2025', 'doctor': 'Dr. Benmoussa', 'type': 'Spine', 'label': 'Lateral'},
    {'title': 'Right Hand', 'date': '10 Jan 2025', 'doctor': 'Dr. Hadj Ali', 'type': 'Hand', 'label': 'AP View'},
    {'title': 'Left Knee', 'date': '05 Dec 2024', 'doctor': 'Dr. Amrani', 'type': 'Knee', 'label': 'Lateral'},
    {'title': 'Chest X-Ray', 'date': '20 Nov 2024', 'doctor': 'Dr. Benmoussa', 'type': 'Chest', 'label': 'AP View'},
    {'title': 'Cervical Spine', 'date': '01 Oct 2024', 'doctor': 'Dr. Hadj Ali', 'type': 'Spine', 'label': 'Flexion'},
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_selectedFilter == 0) return _images;
    final type = _filters[_selectedFilter];
    return _images.where((img) => img['type'] == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: 16),
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _filters.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () => setState(() => _selectedFilter = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: _selectedFilter == i ? AppColors.accentGradient : null,
                        color: _selectedFilter == i ? null : AppColors.panel,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _selectedFilter == i ? Colors.transparent : AppColors.stroke,
                        ),
                      ),
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          color: _selectedFilter == i ? Colors.white : AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('${_filtered.length} images',
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                    const Spacer(),
                    const Icon(Icons.grid_view_rounded, color: AppColors.neonCyan, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _filtered.isEmpty
                    ? _emptyState()
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.82,
                        ),
                        itemCount: _filtered.length,
                        itemBuilder: (ctx, i) => _imageCard(_filtered[i]),
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
      padding: const EdgeInsets.fromLTRB(12, 12, 20, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.neonCyan),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 4),
          const Text('X-Ray Images',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.upload_rounded, color: AppColors.neonCyan),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _imageCard(Map<String, dynamic> img) {
    return GestureDetector(
      onTap: () => _showImageDialog(img),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.panel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonCyan.withOpacity(0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.panel2,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Stack(
                  children: [
                    Center(child: _xrayPlaceholder(img['type'] as String)),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.neonCyan.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.neonCyan.withOpacity(0.4)),
                        ),
                        child: Text(img['label'] as String,
                            style: const TextStyle(
                                color: AppColors.neonCyan, fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), shape: BoxShape.circle),
                        child: const Icon(Icons.zoom_in_rounded, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(img['title'] as String,
                      style: const TextStyle(
                          color: AppColors.text, fontWeight: FontWeight.w600, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(img['date'] as String,
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(img['doctor'] as String,
                            style: const TextStyle(color: AppColors.neonTeal, fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const Icon(Icons.download_rounded, size: 16, color: AppColors.neonCyan),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _xrayPlaceholder(String type) {
    final icons = {
      'Chest': Icons.air_rounded,
      'Spine': Icons.linear_scale_rounded,
      'Hand': Icons.back_hand_rounded,
      'Knee': Icons.accessibility_new_rounded,
    };
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icons[type] ?? Icons.image_rounded, size: 48, color: AppColors.neonCyan.withOpacity(0.25)),
        const SizedBox(height: 6),
        Text(type,
            style: TextStyle(
                color: AppColors.neonCyan.withOpacity(0.4), fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  void _showImageDialog(Map<String, dynamic> img) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.panel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(img['title'] as String,
                      style: const TextStyle(
                          color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: AppColors.panel2, borderRadius: BorderRadius.circular(14)),
                child: Center(child: _xrayPlaceholder(img['type'] as String)),
              ),
              const SizedBox(height: 16),
              _infoRow('Doctor', img['doctor'] as String),
              _infoRow('Date', img['date'] as String),
              _infoRow('View', img['label'] as String),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.neonCyan),
                        foregroundColor: AppColors.neonCyan,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.share_rounded, size: 16),
                      label: const Text('Share'),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.download_rounded, size: 16, color: Colors.white),
                        label: const Text('Download', style: TextStyle(color: Colors.white)),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          Text(value,
              style: const TextStyle(
                  color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported_rounded,
              size: 60, color: AppColors.textMuted.withOpacity(0.4)),
          const SizedBox(height: 12),
          const Text('No X-Ray images found', style: TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
