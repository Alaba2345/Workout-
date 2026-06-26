import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_service.dart';
import '../theme/app_theme.dart';

class BannerAdWidget extends StatefulWidget {
  /// Set to true to hide ads for premium users
  final bool isPremium;

  const BannerAdWidget({super.key, this.isPremium = false});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _adLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isPremium) {
      _loadAd();
    }
  }

  void _loadAd() {
    final banner = AdService.instance.createBanner();
    banner.load().then((_) {
      if (mounted) {
        setState(() {
          _bannerAd = banner;
          _adLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hide for premium users or if ad not ready
    if (widget.isPremium || !_adLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(color: AppTheme.divider, width: 1),
        ),
      ),
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}