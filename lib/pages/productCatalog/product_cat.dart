import 'package:flutter/material.dart';

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  final _search = TextEditingController();
  String _query = '';

  // Demo veri (ileride DB’den gelecek)
  final List<_Prod> _all = const [
    _Prod(
      name: 'PE-PP EKO GERİ DÖNÜŞÜM HATTI',
      img:
          'https://images.unsplash.com/photo-1581091215367-59ab6b321416?q=80&w=1200&auto=format&fit=crop',
      desc:
          'Hem PP hem de PE, birçok açıdan benzer; ancak bazı önemli özellikler açısından farklılık gösteren dövme hidrokarbonlardır. Eko geri dönüşüm hattı ile birlikte PP ve PE esaslı plastik malzemeler…',
    ),
    _Prod(
      name: 'LDPE KIRMA YIKAMA HATTI',
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFMPJ4PYChZ_f8gflI868DXUWkmKeWZxdq9QXyhpkJRb6TvzsAnr8R4ylMwRC13CBSKBo&usqp=CAU',
      desc:
          'LDPE, düşük yoğunluklu polietilen petrodolje meydana gelen bir termoplastiktir. Örnekleri gün geçtikçe artarak devam etmektedir. Başlıca: shrink, taşıma torbaları, tarımsal…',
    ),
    _Prod(
      name: 'LASTİK GERİ DÖNÜŞÜM HATTI',
      img:
          'https://images.unsplash.com/photo-1581092795360-fd1b68f4c2fe?q=80&w=1200&auto=format&fit=crop',
      desc:
          'Lastikler; bileşiminde kauçuk, kord bezli, çelik tel ve birçok kimyasal katkı barındıran kompozit yapıdadır. Yüksek teknoloji gerektiren bir süreç ile üretilir, ancak…',
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
          // Arama + Filtre
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
                    // ileride filtre modalı açılacak
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

          // Bölüm başlığı + oklar
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

          // Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // ekrana göre ayarlamak istersen MediaQuery ile yapabiliriz
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .68, // kart oranı
            ),
            itemBuilder: (_, i) => _ProductCard(product: filtered[i]),
          ),
        ],
      ),

      // ALT ÇUBUK – daha öncekiyle aynı
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
            children: const [
              _RoundNavIcon(icon: Icons.person),
              _RoundNavIcon(icon: Icons.qr_code_2),
              _RoundNavIcon(icon: Icons.home_filled, selected: true),
              _RoundNavIcon(icon: Icons.settings_suggest),
              _RoundNavIcon(icon: Icons.menu),
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== Kart ===================== */

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
        border: Border.all(color: green, width: 1.6), // yeşil çerçeve
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Resim
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
          // Başlık + açıklama + incele
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
                        // ileride detay sayfasına gidecek
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

/* ===================== Küçük yardımcılar ===================== */

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
  const _RoundNavIcon({required this.icon, this.selected = false});
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF62E88D) : Colors.white70;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.35),
        shape: BoxShape.circle,
        border: Border.all(color: selected ? color : Colors.white24),
      ),
      child: Icon(icon, color: color),
    );
  }
}

class _Prod {
  final String name;
  final String? img;
  final String desc;
  const _Prod({required this.name, required this.img, required this.desc});
}
