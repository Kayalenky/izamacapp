import 'package:flutter/material.dart';

// >>> YOLLARI kendi klasör yapına göre ayarla
import '../home/main_page.dart';
import '../machineinfo/machine_info.dart';
import '../aboutus/about_us.dart';
import '../productCatalog/product_cat.dart';
import '../services/services.dart';
import '../settings/settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color _bg = Color(0xFF111111);
  static const Color _green = Color(0xFF62E88D);

  // ── Sağ alttaki menü
  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B1B1B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        Widget item(IconData icon, String title, VoidCallback onTap) {
          return ListTile(
            leading: Icon(icon, color: Colors.white),
            title: Text(title, style: const TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: _green),
            onTap: () {
              Navigator.pop(ctx);
              onTap();
            },
          );
        }

        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                item(Icons.info_outline, 'Hakkımızda', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AboutUsPage()),
                  );
                }),
                item(Icons.view_module_rounded, 'Ürün Kataloğu', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ProductCatalogPage(),
                    ),
                  );
                }),
                item(Icons.handyman_outlined, 'Hizmetlerimiz', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ServicesPage()),
                  );
                }),
                item(Icons.settings_suggest, 'Ayarlar', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                }),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        centerTitle: true,
        // YEŞİL BORDER KALDIRILDI → sade gri kapsül
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(255, 255, 255, 0.08),
          ),
          child: const Text('Profilim', style: TextStyle(color: Colors.white)),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
        children: [
          // Avatar (BÜYÜTÜLDÜ)
          Center(
            child: CircleAvatar(
              radius: 72, // 56 -> 72
              backgroundColor: Colors.white24,
              child: const Icon(
                Icons.person,
                size: 80,
                color: Colors.white70,
              ), // 64 -> 80
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'İsmail Batuhan YILMAZ',
              style: TextStyle(color: Colors.white, fontSize: 14.5),
            ),
          ),
          // “Makine takibi” DAHA AŞAĞIDA DURSUN
          const SizedBox(height: 40),

          // Makine takibi satırı (tap → MachineInfoPage)
          _ProfileActionTile(
            leadingIcon: Icons.settings_applications_rounded,
            title: 'Makine takibi',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MachineInfoPage()),
              );
            },
          ),
        ],
      ),

      // Alt bar
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
              _BottomIcon(icon: Icons.person, onTap: () {}, selected: true),
              _BottomIcon(icon: Icons.qr_code_2, onTap: () {}),
              _BottomIcon(
                icon: Icons.home_filled,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainPage()),
                    (route) => false,
                  );
                },
              ),
              _BottomIcon(icon: Icons.settings_suggest, onTap: () {}),
              _BottomIcon(icon: Icons.menu, onTap: () => _openMenu(context)),
            ],
          ),
        ),
      ),
    );
  }
}

/* ───────────────────── BİLEŞENLER ───────────────────── */

class _ProfileActionTile extends StatelessWidget {
  const _ProfileActionTile({
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  });

  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.25),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ProfilePage._green),
                  ),
                  child: Icon(leadingIcon, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 10),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                const Icon(Icons.chevron_right, color: ProfilePage._green),
              ],
            ),
            const SizedBox(height: 6),
            // yeşil alt çizgi
            Container(height: 2, color: ProfilePage._green),
          ],
        ),
      ),
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
    final color = selected ? ProfilePage._green : Colors.white70;
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
