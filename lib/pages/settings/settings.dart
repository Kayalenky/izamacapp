import 'package:flutter/material.dart';
import '../home/main_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF111111);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg, // bar tam gri değil; sayfayla aynı renk
        elevation: 0,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white12,          // sadece yazı kadar gri kapsül
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Ayarlar',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),

      body: Stack(
        children: [
          // Silik dişli/watermark
          Positioned(
            top: 8,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.05,
              child: Icon(
                Icons.settings_applications_rounded,
                size: 220,
                color: Colors.white,
              ),
            ),
          ),

          // İçerik: watermark’ın altından başlat
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 180, 20, 24),
            child: Column(
              children: const [
                _SettingsItemRow(icon: Icons.person,          title: 'Hesap'),
                _GreenLine(),
                _SettingsItemRow(icon: Icons.notifications_active_rounded, title: 'Bildirimler'),
                _GreenLine(),
                _SettingsItemRow(icon: Icons.lock_rounded,    title: 'Gizlilik'),
                _GreenLine(),
                _SettingsItemRow(icon: Icons.help_outline_rounded, title: 'Yardım'),
                _GreenLine(),
              ],
            ),
          ),
        ],
      ),

      // ALT BAR — ortadaki ev ana sayfaya
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: const BoxDecoration(
          color: Color(0xFF262626),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BottomIcon(icon: Icons.person, onTap: _noop),
              _BottomIcon(icon: Icons.qr_code_2, onTap: _noop),
              _BottomIcon(
                icon: Icons.home_filled,
                selected: true,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainPage()),
                    (route) => false,
                  );
                },
              ),
              _BottomIcon(icon: Icons.settings_suggest, onTap: _noop),
              _BottomIcon(icon: Icons.menu, onTap: _noop),
            ],
          ),
        ),
      ),
    );
  }

  static void _noop() {}
}

/* ───────────────────── BİLEŞENLER ───────────────────── */

class _SettingsItemRow extends StatelessWidget {
  const _SettingsItemRow({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Sol yuvarlak ikon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white54),
              color: const Color.fromRGBO(0, 0, 0, 0.25),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          // Başlık
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Sağ yeşil ok
          const Icon(Icons.chevron_right, color: Color(0xFF62E88D)),
        ],
      ),
    );
  }
}

class _GreenLine extends StatelessWidget {
  const _GreenLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color: const Color(0xFF62E88D),
      margin: const EdgeInsets.only(left: 46), // ikon hizasından başlasın
    );
  }
}

class _BottomIcon extends StatelessWidget {
  const _BottomIcon({
    required this.icon,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Color green = const Color(0xFF62E88D);
    final color = selected ? green : Colors.white70;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.35),
        shape: BoxShape.circle,
        border: Border.all(color: selected ? color : Colors.white24),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
