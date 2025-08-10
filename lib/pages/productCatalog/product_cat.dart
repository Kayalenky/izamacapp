import 'package:flutter/material.dart';
import '../home/main_page.dart';
import '../aboutus/about_us.dart';
import '../services/services.dart';
import '../settings/settings.dart';

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  final _search = TextEditingController();
  String _query = '';

  // Demo veri
  final List<_Prod> _all = const [
    _Prod(
      name: 'PE-PP EKO GERİ DÖNÜŞÜM HATTI',
      img:
          'https://images.unsplash.com/photo-1581091215367-59ab6b321416?q=80&w=1200&auto=format&fit=crop',
      desc:
          'Hem PP hem de PE, birçok açıdan benzer; ancak bazı önemli özellikler açısından farklılık gösteren dövme hidrokarbonlardır...',
    ),
    _Prod(
      name: 'LDPE KIRMA YIKAMA HATTI',
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFMPJ4PYChZ_f8gflI868DXUWkmKeWZxdq9QXyhpkJRb6TvzsAnr8R4ylMwRC13CBSKBo&usqp=CAU',
      desc:
          'LDPE, düşük yoğunluklu polietilen petrodolje meydana gelen bir termoplastiktir...',
    ),
    _Prod(
      name: 'LASTİK GERİ DÖNÜŞÜM HATTI',
      img:
          'https://images.unsplash.com/photo-1581092795360-fd1b68f4c2fe?q=80&w=1200&auto=format&fit=crop',
      desc:
          'Lastikler; bileşiminde kauçuk, kord bezli, çelik tel ve birçok kimyasal katkı barındırır...',
    ),
    _Prod(
      name: 'Yakında…',
      img: null,
      desc: 'Yakında…',
    ),
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  // ── MENÜ ──
  void _openMenu() {
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
                  width: 42,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
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
                  onTap: () {}, // zaten buradayız
                ),
                item(
                  icon: Icons.handyman_outlined,
                  title: 'Hizmetlerimiz',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ServicesPage()),
                  ),
                ),
                item(
                  icon: Icons.settings_suggest,
                  title: 'Ayarlar',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  ),
                ),
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

    final filtered = _all
        .where((p) =>
            _query.isEmpty ||
            p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Ürün Kataloğu ve Tanıtım'),
        centerTitle: true,
        backgroundColor: card,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _search,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: 'Ürün veya kategori ara...',
                    isDense: true,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Filtre gelecek 👀')),
                    );
                  },
                  icon: const Icon(Icons.filter_list_rounded),
                  label: const Text('Filtrele'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white24),
                    backgroundColor: Colors.white10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _ArrowBtn(icon: Icons.chevron_left),
              SizedBox(width: 16),
              Text('Geri dönüşüm hatları',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              SizedBox(width: 16),
              _ArrowBtn(icon: Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .68,
            ),
            itemBuilder: (_, i) => _ProductCard(product: filtered[i]),
          ),
        ],
      ),
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
                selected: false,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainPage()),
                    (route) => false,
                  );
                },
              ),
              _RoundNavIcon(icon: Icons.settings_suggest, onTap: () {}),
              _RoundNavIcon(icon: Icons.menu, onTap: _openMenu),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});
  final _Prod product;

  @override
  Widget build(BuildContext context) {
    const card = Color(0xFF1B1B1B);
    const green = Color(0xFF62E88D);

    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: green, width: 1.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: product.img == null
                  ? Container(
                      color: Colors.white12,
                      alignment: Alignment.center,
                      child: const Text('resim',
                          style: TextStyle(color: Colors.white70)),
                    )
                  : Image.network(product.img!, fit: BoxFit.contain),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12.5)),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      product.desc,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 11.5, color: Colors.white70),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} • İncele')),
                        );
                      },
                      child: const Text(
                        'İncele',
                        style: TextStyle(
                          color: green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowBtn extends StatelessWidget {
  const _ArrowBtn({required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: Colors.white12,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18),
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

class _Prod {
  final String name;
  final String? img;
  final String desc;
  const _Prod({required this.name, required this.img, required this.desc});
}
