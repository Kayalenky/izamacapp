import 'package:flutter/material.dart';

/// Makine Takibi sayfası (banner kaldırıldı, kartlar arasında yeşil çizgi var)
class MachineInfoPage extends StatelessWidget {
  const MachineInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF111111);
    const green = Color(0xFF62E88D);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
  title: const Text('Makine Takibi'),
  centerTitle: true, // başlığı ortalar
  backgroundColor: const Color(0xFF1B1B1B),
  elevation: 0,
),
      body: ListView(
      padding: const EdgeInsets.fromLTRB(14, 30, 14, 12), // üst boşluk 30 px
        children: const [
          // Kartlar + ayırıcılar
          _MachineTile(
            title: 'İZA 500',
            imageUrl:
                'https://images.unsplash.com/photo-1581091870622-7f3c1b1e5af1?q=80&w=1200&auto=format&fit=crop',
            warranty: '24 ay',
            serial: 'IZA500-2025-00123',
            manual: 'PDF v1.3',
            support: 'support@iza.com / 0364 606 06 22',
          ),
          _GreenDivider(),

          _MachineTile(
            title: 'Yatay Sıkma',
            imageUrl:
                'https://images.unsplash.com/photo-1581092795360-fd1b68f4c2fe?q=80&w=1200&auto=format&fit=crop',
            warranty: '18 ay',
            serial: 'YSKM-24H-00987',
            manual: 'PDF v2.0',
            support: 'destek@iza.com / 0532 566 69 89',
          ),
          _GreenDivider(),

          _MachineTile(
            title: 'Aglomer makinası',
            imageUrl:
                'https://images.unsplash.com/photo-1587560699334-cc4ff634909a?q=80&w=1200&auto=format&fit=crop',
            warranty: '12 ay',
            serial: 'AGL-700-00045',
            manual: 'PDF v1.1',
            support: 'help@iza.com / 0364 606 06 22',
          ),
        ],
      ),

      // ALT ÇUBUK — önceki sayfayla aynı
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

/* ===================== KART AYIRICI ===================== */

class _GreenDivider extends StatelessWidget {
  const _GreenDivider();

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF62E88D);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          color: green.withOpacity(.7),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

/* ===================== LİSTE ELEMANI (EXPAND/COLLAPSE) ===================== */

class _MachineTile extends StatefulWidget {
  const _MachineTile({
    required this.title,
    required this.imageUrl,
    required this.warranty,
    required this.serial,
    required this.manual,
    required this.support,
  });

  final String title;
  final String imageUrl;

  // Detay alanları
  final String warranty;
  final String serial;
  final String manual;
  final String support;

  @override
  State<_MachineTile> createState() => _MachineTileState();
}

class _MachineTileState extends State<_MachineTile>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    const card = Color(0xFF1B1B1B);

    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            children: [
              // Üst satır (resim + başlık + ok)
              Row(
                children: [
                  _Thumb(imageUrl: widget.imageUrl),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0.0, // aşağı ok dönsün
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more, color: Colors.white60),
                  ),
                ],
              ),

              // Açılan detay bölümü
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      const Divider(color: Colors.white24, height: 18, thickness: 0.6),
                      _DetailRow(
                        label: 'Garanti süresi',
                        value: widget.warranty,
                        icon: Icons.verified_user_outlined,
                      ),
                      _DetailRow(
                        label: 'Makine seri no',
                        value: widget.serial,
                        icon: Icons.confirmation_num_outlined,
                      ),
                      _DetailRow(
                        label: 'Kullanım kılavuzu',
                        value: widget.manual,
                        icon: Icons.menu_book_outlined,
                      ),
                      _DetailRow(
                        label: 'Destek',
                        value: widget.support,
                        icon: Icons.support_agent_outlined,
                      ),
                    ],
                  ),
                ),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 220),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white12,
        border: Border.all(color: Colors.white24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ===================== ALT ÇUBUK (AYNI) ===================== */

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
        color: Colors.black.withOpacity(.35),
        shape: BoxShape.circle,
        border: Border.all(color: selected ? color : Colors.white24),
      ),
      child: Icon(icon, color: color),
    );
  }
}
