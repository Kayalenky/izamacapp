import 'package:flutter/material.dart';
import '../home/main_page.dart';              // Home'a dönüş
import '../aboutus/about_us.dart';             // Hakkımızda
import '../productCatalog/product_cat.dart';  // Ürün Kataloğu
import '../settings/settings.dart';           // Ayarlar

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  // ── MENÜ (bottom sheet)
  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B1B1B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        const green = Color(0xFF62E88D);

        Widget item({
          required IconData icon,
          required String title,
          required VoidCallback onTap,
        }) {
          return ListTile(
            leading: Icon(icon, color: Colors.white),
            title: Text(title, style: const TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: green),
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
                  width: 42, height: 4, margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)),
                ),
                item(
                  icon: Icons.info_outline,
                  title: 'Hakkımızda',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AboutUsPage()),
                  ),
                ),
                item(
                  icon: Icons.view_module_rounded,
                  title: 'Ürün Kataloğu',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProductCatalogPage()),
                  ),
                ),
                item(
                  icon: Icons.handyman_outlined,
                  title: 'Hizmetlerimiz',
                  onTap: () {
                    // Zaten buradayız; istersen snackbar atılabilir.
                  },
                ),
                item(
                  icon: Icons.settings_suggest,
                  title: 'Ayarlar',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  ),
                ),
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
    const bg = Color(0xFF111111);
    const card = Color(0xFF1B1B1B);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Hizmetlerimiz'),
        centerTitle: true,
        backgroundColor: card,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        children: const [
          _ServiceTile(
            title: 'Teknik Destek',
            subtitle: 'Geri dönüşüm makineleri için kurulum, bakım ve onarım.',
            details:
                '• Kurulum ve devreye alma\n'
                '• Periyodik bakım planlaması\n'
                '• Arıza tespiti ve yerinde onarım\n'
                '• Uzaktan erişim ile hızlı destek\n'
                '• Yedek makine/ekipman temini (müsaitlik durumuna göre)',
          ),
          SizedBox(height: 12),
          _ServiceTile(
            title: 'Yedek Parça Temini',
            subtitle: 'Tüm makineler için orijinal parça temini sağlıyoruz.',
            details:
                '• Üretici onaylı orijinal parçalar\n'
                '• Kritik stok takip ve önerileri\n'
                '• Hızlı tedarik/kurye seçenekleri\n'
                '• Parça uyumluluk kontrolü\n'
                '• Montaj desteği',
          ),
          SizedBox(height: 12),
          _ServiceTile(
            title: 'Eğitim Hizmeti',
            subtitle: 'Personelinize kullanım ve güvenlik eğitimi verilir.',
            details:
                '• Operatör başlangıç eğitimi\n'
                '• İleri seviye proses eğitimi\n'
                '• İş sağlığı ve güvenliği modülleri\n'
                '• Periyodik tazeleme eğitimleri\n'
                '• Sertifikasyon (talebe bağlı)',
          ),
          SizedBox(height: 12),
          _ServiceTile(
            title: 'Danışmanlık',
            subtitle: 'Uygun makina seçimi için uzman ekibimizle görüşün.',
            details:
                '• İhtiyaç analizi ve saha keşfi\n'
                '• Kapasite ve maliyet fizibilitesi\n'
                '• Hat konfigürasyonu/yerleşim planı\n'
                '• Enerji ve verimlilik optimizasyonu\n'
                '• Teklif ve yatırım planlama desteği',
          ),
          SizedBox(height: 8),
        ],
      ),

      // ALT ÇUBUK – Home anasayfaya, Menü bottom sheet
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
              _RoundNavIcon(icon: Icons.person, onTap: () {}),
              _RoundNavIcon(icon: Icons.qr_code_2, onTap: () {}),
              _RoundNavIcon(
                icon: Icons.home_filled,
                selected: false, // bu sayfa home değil
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainPage()),
                    (route) => false,
                  );
                },
              ),
              _RoundNavIcon(icon: Icons.settings_suggest, onTap: () {}),
              _RoundNavIcon(
                icon: Icons.menu,
                onTap: () => _openMenu(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== Açılır/Kapanır Kart ===================== */

class _ServiceTile extends StatefulWidget {
  const _ServiceTile({
    required this.title,
    required this.subtitle,
    required this.details,
  });

  final String title;
  final String subtitle;
  final String details;

  @override
  State<_ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<_ServiceTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    const card = Color(0xFF1B1B1B);
    const green = Color(0xFF62E88D);

    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: green, width: 1.6),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık satırı
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 180),
                    child: const Icon(Icons.expand_more, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: const TextStyle(color: Colors.white70),
              ),

              // Açılan detay
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Divider(color: Colors.white24, thickness: 0.6),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                duration: const Duration(milliseconds: 180),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),

              if (_expanded)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.details,
                    style: const TextStyle(height: 1.35),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== Alt Bar (ikon) ===================== */

class _RoundNavIcon extends StatelessWidget {
  const _RoundNavIcon({
    required this.icon,
    this.selected = false,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF62E88D) : Colors.white70;
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
