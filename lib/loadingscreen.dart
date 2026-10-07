import 'package:flutter/material.dart';

/// Loading screen SIPS (Super Inteligent Plant System)
///
/// Cara pakai:
///   home: LoadingScreen(nextScreen: const HomePage()),
class LoadingScreen extends StatefulWidget {
  /// Halaman tujuan setelah loading selesai (opsional).
  final Widget? nextScreen;

  /// Lama loading.
  final Duration duration;

  const LoadingScreen({
    super.key,
    this.nextScreen,
    this.duration = const Duration(seconds: 4),
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const Color _darkGreen = Color(0xFF4FA524);
  static const Color _barGreen = Color(0xFF3F9A1F);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.nextScreen != null) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget.nextScreen!,
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final circleSize = size.width * 0.72;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF8CD955), Color(0xFFC8E366)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 5),
              _buildLogoCircle(circleSize),
              const Spacer(flex: 4),
              _buildProgress(size.width * 0.4),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoCircle(double diameter) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: _darkGreen, width: diameter * 0.035),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gambar ilustrasi (tanaman + robot + orang).
          // Simpan di assets/images/sips_logo.png
          SizedBox(
            width: diameter * 0.75,
            height: diameter * 0.38,
            child: Image.asset(
              'assets/images/sips_logo.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.eco,
                size: 64,
                color: _darkGreen,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'SIPS',
            style: TextStyle(
              fontSize: diameter * 0.15,
              fontWeight: FontWeight.w900,
              letterSpacing: diameter * 0.06,
              color: Colors.black,
            ),
          ),
          Text(
            'Super Inteligent Plant System',
            style: TextStyle(
              fontSize: diameter * 0.052,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress(double barWidth) {
    return Column(
      children: [
        Container(
          width: barWidth,
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _barGreen, width: 2.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: _controller.value,
                  heightFactor: 1,
                  child: Container(color: _barGreen),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Wait Please..',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
