import 'package:flutter/material.dart';
import '../home/main_page.dart'; // Ev ikonunda anasayfaya gitmek için

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

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
          // Kartlar
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
            subtitle:
                'Tüm makineler için orijinal parça temini sağlıyoruz.',
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
            subtitle:
                'Uygun makina seçimi için uzman ekibimizle görüşün.',
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

      // ALT ÇUBUK – önceki tasarımla aynı; Home anasayfaya döner
      bottomNavigationBar: const _BottomBar(),
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
                    children: [
                      const Divider(color: Colors.white24, thickness: 0.6),
                      const SizedBox(height: 8),
                      Text(
                        widget.details,
                        style: const TextStyle(height: 1.35),
                      ),
                    ],
                  ),
                ),
                duration: const Duration(milliseconds: 180),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== Alt Bar (Home anasayfaya gider) ===================== */

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {

    return Container(
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
            // HOME → anasayfaya yönlendir
            _RoundNavIcon(
              icon: Icons.home_filled,
              selected: true,
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainPage()),
                  (route) => false,
                );
              },
            ),
            _RoundNavIcon(icon: Icons.settings_suggest, onTap: () {}),
            _RoundNavIcon(icon: Icons.menu, onTap: () {}),
          ],
        ),
      ),
    );
  }
}

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
