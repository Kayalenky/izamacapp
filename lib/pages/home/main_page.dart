import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:izamacapp/pages/aboutus/about_us.dart';
import 'package:izamacapp/pages/login/giris.dart';
import 'package:izamacapp/pages/productCatalog/product_cat.dart';
import 'package:izamacapp/pages/services/services.dart';
import 'package:izamacapp/pages/settings/settings.dart';
import 'package:izamacapp/pages/services/auth_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _prodCtrl = PageController();
  final _promoCtrl = PageController();
  int _prodIndex = 0;
  int _promoIndex = 0;

  String _userName = 'Misafir';
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (mounted && userDoc.exists) {
          setState(() {
            _userName = userDoc.get('adSoyad') ?? 'Kullanıcı';
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _userName = 'Kullanıcı';
          });
        }
      }
    }
  }

  Future<void> _signOut() async {
    await _authService.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  final _productImages = const [
    'https://images.unsplash.com/photo-1581091215367-59ab6b321416?q=80&w=1200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1518779578993-ec3579fee39f?q=80&w=1200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1581090700227-1e37b190418e?q=80&w=1200&auto=format&fit=crop',
  ];

  final _promoImages = const [
    'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?q=80&w=1200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1551836022-d5d88e9218df?q=80&w=1200&auto=format&fit=crop',
  ];

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
          Color? color,
        }) {
          return ListTile(
            leading: Icon(icon, color: color ?? Colors.white),
            title: Text(
              title,
              style: TextStyle(color: color ?? Colors.white, fontSize: 16),
            ),
            trailing: Icon(Icons.chevron_right, color: color ?? green),
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ProductCatalogPage(),
                    ),
                  ),
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
                if (_userName != 'Misafir') ...[
                  const Divider(
                    color: Colors.white24,
                    height: 1,
                    thickness: 0.5,
                  ),
                  item(
                    icon: Icons.logout,
                    title: 'Çıkış Yap',
                    onTap: _signOut,
                    color: Colors.redAccent,
                  ),
                ],
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
    const green = Color(0xFF62E88D);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _Header(green: green, userName: _userName),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Container(
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    _Carousel(
                      height: 240,
                      controller: _prodCtrl,
                      images: _productImages,
                      onChanged: (i) => setState(() => _prodIndex = i),
                      pillTopRight: const _InfoPill(
                        text: 'PCM SERİSİ\nDÜŞÜK ENERJİ &\nYÜKSEK KAPASİTE',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'GERİ DÖNÜŞÜM\nMAKİNELERİNDE ÖNCÜ MARKA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'İZA MAKİNA geri dönüşüm tesislerinde kullanılan makineler ve bu makinelere ait yedek parçaların imalatını yapmak amacı ile kurulmuştur.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    _Dots(count: _productImages.length, index: _prodIndex),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  const Text(
                    'Tanıtım Günleri',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _Carousel(
                    height: 140,
                    controller: _promoCtrl,
                    images: _promoImages,
                    onChanged: (i) => setState(() => _promoIndex = i),
                  ),
                  const SizedBox(height: 4),
                  _Dots(count: _promoImages.length, index: _promoIndex),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Divider(
              color: Colors.white24,
              thickness: 0.6,
              indent: 14,
              endIndent: 14,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Bir projeniz mi var?',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Bizimle iletişime geçin.',
                    style: TextStyle(color: Color(0xFF62E88D), fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  _ContactLine(icon: Icons.phone, text: '+90 364 606 06 22'),
                  _ContactLine(icon: Icons.phone, text: '+90 532 566 69 89'),
                  _ContactLine(icon: Icons.email, text: 'iza@izamakina.com'),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _SocialDot(icon: Icons.facebook),
                _SocialDot(icon: Icons.chat_bubble),
                _SocialDot(icon: Icons.language),
                _SocialDot(icon: Icons.camera_alt),
                _SocialDot(icon: Icons.ondemand_video),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: const BoxDecoration(
          color: Color(0xFF262626),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _RoundNavIcon(icon: Icons.person),
              const _RoundNavIcon(icon: Icons.qr_code_2),
              const _RoundNavIcon(icon: Icons.home_filled, selected: true),
              const _RoundNavIcon(icon: Icons.settings_suggest),
              GestureDetector(
                onTap: _openMenu,
                child: const _RoundNavIcon(icon: Icons.menu),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.green, required this.userName});
  final Color green;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 7,
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
            child: Image.network(
              'https://images.unsplash.com/photo-1517048676732-d65bc937f952?q=80&w=1600&auto=format&fit=crop',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'İZA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  'Hoş geldin, $userName',
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({
    required this.height,
    required this.controller,
    required this.images,
    required this.onChanged,
    this.pillTopRight,
  });

  final double height;
  final PageController controller;
  final List<String> images;
  final void Function(int) onChanged;
  final Widget? pillTopRight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: PageView.builder(
              controller: controller,
              onPageChanged: onChanged,
              itemCount: images.length,
              itemBuilder: (_, i) =>
                  Image.network(images[i], fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ArrowButton(
                icon: Icons.chevron_left,
                onTap: () {
                  controller.previousPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                },
              ),
              _ArrowButton(
                icon: Icons.chevron_right,
                onTap: () {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                },
              ),
            ],
          ),
        ),
        if (pillTopRight != null)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(18, 52, 86, 0.9),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: pillTopRight,
            ),
          ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
        height: 1.25,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == index ? Colors.white : Colors.white24,
          ),
        ),
      ),
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white24, width: .5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialDot extends StatelessWidget {
  const _SocialDot({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      margin: const EdgeInsets.only(right: 8),
      decoration: const BoxDecoration(
        color: Colors.white12,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 16),
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
