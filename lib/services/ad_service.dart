import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  AdService._();
  static final AdService instance = AdService._();

  // ── Ad Unit IDs ───────────────────────────────────────
  // Swap these for real IDs when publishing to store

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/6300978111' // test
          : 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // your real ID
    } else {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/2934735716' // test
          : 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // your real ID
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/1033173712' // test
          : 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // your real ID
    } else {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/4411468910' // test
          : 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // your real ID
    }
  }

  // ── State ─────────────────────────────────────────────
  bool _initialized = false;
  InterstitialAd? _interstitialAd;
  bool _interstitialReady = false;

  // ── Init ──────────────────────────────────────────────
  Future<void> initialize() async {
    if (_initialized) return;
    await MobileAds.instance.initialize();
    _initialized = true;
    _loadInterstitial();
  }

  // ── Banner ────────────────────────────────────────────
  BannerAd createBanner() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner failed: $error');
          ad.dispose();
        },
      ),
    );
  }

  // ── Interstitial ──────────────────────────────────────
  void _loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialReady = true;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              _interstitialReady = false;
              _loadInterstitial(); // preload next
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
              _interstitialReady = false;
              _loadInterstitial();
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial failed to load: $error');
          _interstitialReady = false;
        },
      ),
    );
  }

  // Show interstitial — call after finishing a workout
  // Returns true if shown, false if not ready
  bool showInterstitial() {
    if (_interstitialReady && _interstitialAd != null) {
      _interstitialAd!.show();
      return true;
    }
    return false;
  }

  bool get isInterstitialReady => _interstitialReady;

  void dispose() {
    _interstitialAd?.dispose();
  }
}