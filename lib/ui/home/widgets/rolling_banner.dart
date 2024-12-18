import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RollingBanner extends StatefulWidget {
  const RollingBanner({Key? key}) : super(key: key);

  @override
  _RollingBannerState createState() => _RollingBannerState();
}

class _RollingBannerState extends State<RollingBanner> {
  final PageController _pageController = PageController(
      initialPage: 1000,
      viewportFraction: 0.9); // PageController에 viewportFraction 추가
  late Timer _timer; // 타이머
  int _currentPage = 1000; // 현재 페이지 인덱스

  // 더미 이미지 및 고유 링크 리스트
  final List<Map<String, String>> _banners = [
    {
      'image': 'https://picsum.photos/350/150?random=1',
      'link': 'https://naver.com',
    },
    {
      'image': 'https://picsum.photos/350/150?random=2',
      'link': 'https://google.com',
    },
    {
      'image': 'https://picsum.photos/350/150?random=3',
      'link': 'https://naver.com',
    },
    {
      'image': 'https://picsum.photos/350/150?random=4',
      'link': 'https://google.com',
    },
    {
      'image': 'https://picsum.photos/350/150?random=5',
      'link': 'https://naver.com',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // 배너 전체 높이
      color: Colors.white, // 배경색 화이트
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          // 실제 보여질 인덱스를 조작
          final actualIndex = index % _banners.length;
          final banner = _banners[actualIndex];
          return GestureDetector(
            onTap: () => _launchURL(banner['link']!),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8), // 각 배너 간 간격
              decoration: BoxDecoration(
                color: Colors.white, // 배경색
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.network(
                banner['image']!,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
