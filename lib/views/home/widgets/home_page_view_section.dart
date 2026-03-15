import 'package:flutter/material.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/image_strings.dart';
import 'package:sss/core/utils/constants/sizes.dart';

/// PageView covering ~60% of viewport; page 1: Emerging Designers, page 2: Trending Brands.
class HomePageViewSection extends StatelessWidget {
  const HomePageViewSection({
    super.key,
    required this.pageHeight,
    required this.currentPage,
    required this.onPageChanged,
  });

  final double pageHeight;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: pageHeight,
      child: PageView(
        onPageChanged: onPageChanged,
        children: [_Page1EmergingDesigners(), _Page2TrendingBrands()],
      ),
    );
  }
}

class _Page1EmergingDesigners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MySizes.md),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFDDCDC),
          borderRadius: BorderRadius.circular(MySizes.cardRadiusLg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(MySizes.cardRadiusLg),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  MyImages.productShirt,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) =>
                          const ColoredBox(color: Color(0xFFFDDCDC)),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(MySizes.md),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.4),
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Emerging Designers',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Explore small businesses and discover unique, one-of-a-kind looks.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.95),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 52,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.white,
                          ),
                          label: const Text('Shop Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
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
        ),
      ),
    );
  }
}

class _Page2TrendingBrands extends StatelessWidget {
  static const List<({String name, String tagline, String imagePath})> _brands =
      [
        (
          name: "Amanda's Boutique",
          tagline: "A modern designer with a youthful spirit...",
          imagePath: MyImages.brandZara,
        ),
        (name: 'Nike', tagline: 'Just Do It', imagePath: MyImages.brandNike),
        (
          name: 'LOST COINS',
          tagline: 'Wear the mood, not the label.',
          imagePath: MyImages.brandApple,
        ),
        (
          name: 'Yousaf',
          tagline: 'Wear the mood',
          imagePath: MyImages.brandNike,
        ),
        (
          name: 'Zara',
          tagline: 'Contemporary style for everyone.',
          imagePath: MyImages.brandZara,
        ),
        (
          name: 'Apple',
          tagline: 'Think different.',
          imagePath: MyImages.brandApple,
        ),
        (
          name: 'Streetwear Co',
          tagline: 'Urban essentials.',
          imagePath: MyImages.brandNike,
        ),
        (
          name: 'Minimalist',
          tagline: 'Less is more.',
          imagePath: MyImages.brandZara,
        ),
      ];

  static const double _tilePadding = 14;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MySizes.md),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Trending Brands',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: MyColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Loved by the community, picked by us — these brands are changing the game from the ground up.',
                      style: TextStyle(
                        fontSize: 12,
                        color: MyColors.textSecondary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < _brands.length; i++) ...[
                          if (i > 0) SizedBox(height: _tilePadding),
                          _BrandTile(
                            name: _brands[i].name,
                            tagline: _brands[i].tagline,
                            imagePath: _brands[i].imagePath,
                            compact: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...['🇰🇷', '🇧🇷', '🇩🇰', '🇿🇦'].map(
                      (flag) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(flag, style: const TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Explore the Global Scene >',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: MyColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BrandTile extends StatelessWidget {
  const _BrandTile({
    required this.name,
    required this.tagline,
    required this.imagePath,
    this.compact = false,
  });

  final String name;
  final String tagline;
  final String imagePath;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final avatarRadius = compact ? 20.0 : 28.0;
    final nameSize = compact ? 14.0 : 16.0;
    final tagSize = compact ? 11.0 : 13.0;
    final padding = compact ? 8.0 : 14.0;
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: MyColors.lightContainer,
            backgroundImage: AssetImage(imagePath),
            onBackgroundImageError: (_, __) {},
          ),
          SizedBox(width: compact ? 10 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: nameSize,
                    fontWeight: FontWeight.bold,
                    color: MyColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  tagline,
                  style: TextStyle(
                    fontSize: tagSize,
                    color: MyColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            'More',
            style: TextStyle(
              fontSize: compact ? 12 : 14,
              fontWeight: FontWeight.w600,
              color: MyColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Page indicator dots for the home PageView.
class HomePageViewIndicator extends StatelessWidget {
  const HomePageViewIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? MyColors.primary : MyColors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
