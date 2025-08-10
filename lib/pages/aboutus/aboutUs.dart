import 'package:flutter/material.dart';
import '../home/main_page.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  // “Neden Biz?” alanında gösterilecek 4’lü kart sayfaları
  final List<List<String>> _pages = [
    [
      'Uzman mühendis ekibimizle güncel teknolojilerde öncüyüz.',
      'İhtiyaca özel geliştirilen, yazılım destekli modern makineler sunuyoruz.',
      'Türkiye geneli servis ağımız ve hızlı yedek parça teminiyle kesintisiz çalışma garantisi.',
      'Yakında',
    ],
    ['Yakında', 'Yakında', 'Yakında', 'Yakında'],
  ];

  int _index = 0;

  void _goPage(int delta) {
    setState(() {
      _index = (_index + delta) % _pages.length;
      if (_index < 0) _index = _pages.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFF111111);
    const Color appBarColor = Color(0xFF1B1B1B);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Hakkımızda', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // ÜST AÇIKLAMA — iki yeşil çizgi arasında
            _greenLine(),
            const SizedBox(height: 10),
            const Text(
              'İZA MAKİNA geri dönüşüm tesislerinde kullanılan makineler '
              've bu makinelere ait yedek parçaların imalatını yapmak '
              'amacı ile kurulmuştur.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 10),
            _greenLine(),

            const SizedBox(height: 20),

            // MİSYON
            const _InfoCard(
              title: 'Misyonumuz',
              text:
                  'Uzman kadromuz, kaliteli üretim standartlarımız, engin bilgimiz '
                  've üç kuşaktan günümüze gelen tecrübemiz ile müşterilerimize en iyi '
                  'ürün ve hizmeti sunmak, sürekli gelişip geliştirmektir.',
            ),

            const SizedBox(height: 20),

            // VİZYON
            const _InfoCard(
              title: 'Vizyonumuz',
              text:
                  'Firmamız seri üretimden ziyade özel üretime endekslemiş '
                  've dünyadaki problemlere, makine yönünden cevap verebilmek için '
                  'AR-GE laboratuvar ve ekipmanlarını daima üst düzeyde tutmaktadır.\n\n'
                  'Müşteri taleplerimiz ve araştırmacı ekibimiz sayesinde üretmiş olduğumuz '
                  'makineler bugün itibariyle 25 ülkeye ihrac edilmektedir.',
            ),

            // Vizyon ile “Neden Biz?” bölümü arasındaki boşluğu büyüttük
            const SizedBox(height: 32),

            // NEDEN BİZ? — üst yeşil çizgi, başlık+oklar, alt yeşil çizgi
            _greenLine(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ArrowBtn(icon: Icons.chevron_left, onTap: () => _goPage(-1)),
                const Text(
                  'Neden Biz?',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                _ArrowBtn(icon: Icons.chevron_right, onTap: () => _goPage(1)),
              ],
            ),
            const SizedBox(height: 12),
            _greenLine(),

            // Başlık ile kartlar arasında küçük boşluk
            const SizedBox(height: 14),

            // 2x2 KARTLAR
            _GridFour(items: _pages[_index]),
          ],
        ),
      ),

      // ALT BAR — ev ikonu ana sayfaya döner
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
              _BottomIcon(icon: Icons.person, onTap: () {}),
              _BottomIcon(icon: Icons.qr_code_2, onTap: () {}),
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
              _BottomIcon(icon: Icons.settings_suggest, onTap: () {}),
              _BottomIcon(icon: Icons.menu, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _greenLine() => Container(height: 2, color: const Color(0xFF62E88D));
}

/* ─────────────────────  BİLEŞENLER  ───────────────────── */

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    const Color cardColor = Color(0xFF1B1B1B);
    const Color green = Color(0xFF62E88D);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: green, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _GridFour extends StatelessWidget {
  const _GridFour({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    // spacing=10 — alt bara yakın konumlandırma
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        const spacing = 10.0;
        final itemW = (w - spacing) / 2;
        const itemH = 100.0;

        return Column(
          children: [
            Row(
              children: [
                _MiniCard(width: itemW, height: itemH, text: items[0]),
                const SizedBox(width: spacing),
                _MiniCard(width: itemW, height: itemH, text: items[1]),
              ],
            ),
            const SizedBox(height: spacing),
            Row(
              children: [
                _MiniCard(width: itemW, height: itemH, text: items[2]),
                const SizedBox(width: spacing),
                _MiniCard(width: itemW, height: itemH, text: items[3]),
              ],
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.width, required this.height, required this.text});

  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    const Color cardColor = Color(0xFF1B1B1B);
    const Color green = Color(0xFF62E88D);
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: green, width: 1.5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white70, fontSize: 12.5, height: 1.25),
      ),
    );
  }
}

class _ArrowBtn extends StatelessWidget {
  const _ArrowBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.35),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
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
    final Color green = const Color(0xFF62E88D);
    final color = selected ? green : Colors.white70;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.35),
          shape: BoxShape.circle,
          border: Border.all(color: selected ? color : Colors.white24),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
