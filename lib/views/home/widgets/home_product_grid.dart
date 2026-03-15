import 'package:flutter/material.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/image_strings.dart';
import 'package:sss/core/utils/constants/sizes.dart';

/// "For You" grid: matches reference — 2x2 grid, full-width featured card, then mixed grid.
class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MySizes.md),
          child: Text(
            'For You:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: MyColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MySizes.md),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.72,
                      child: _ProductCard(
                        imagePath: MyImages.productNikeShoes,
                        title: "Men's Sneakers White One",
                        price: 'RM 200.00',
                        brandLogoPath: MyImages.brandNike,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.72,
                      child: _ProductCard(
                        imagePath: MyImages.productShirt,
                        title: "Men's T-shirt Black",
                        price: 'RM 99.00',
                        brandLogoPath: MyImages.brandZara,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.72,
                      child: _ProductCard(
                        imagePath: MyImages.productTshirtYellow,
                        title: 'Outdoor Jacket',
                        price: 'RM 180.00',
                        brandLogoPath: MyImages.brandNike,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.72,
                      child: _ProductCard(
                        imagePath: MyImages.productNikeShoes,
                        title: "Women's Sneakers One",
                        price: 'RM 200.00',
                        brandLogoPath: MyImages.brandApple,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _FeaturedProductCard(
                imagePath: MyImages.productNikeAirPresto,
                title: 'Nike - Off White Air Presto [Virgil Abloh 2018]',
                price: 'RM 999.00',
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.72,
                      child: _ProductCard(
                        imagePath: MyImages.productTshirtBlueBack,
                        title: 'The Essential Crewneck Tee',
                        price: 'RM 120.00',
                        brandLogoPath: MyImages.brandNike,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.72,
                      child: _ProductCard(
                        imagePath: MyImages.productTshirtBlueFront,
                        title: 'The Essential Crewneck Tee',
                        price: 'RM 99.00',
                        brandLogoPath: MyImages.brandZara,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _PromoCard(title: 'Exclusively on Swifty...'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.72,
                      child: _ProductCard(
                        imagePath: MyImages.productShirt,
                        title: "Men's T-shirt",
                        price: 'RM 200.00',
                        brandLogoPath: MyImages.brandNike,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _PromoCard(title: 'Grab the best!')),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.72,
                      child: _ProductCard(
                        imagePath: MyImages.productTshirtGreen,
                        title: 'The Essential Crewneck Tee',
                        price: 'RM 99.00',
                        brandLogoPath: MyImages.brandApple,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Full-width featured product card with image, page dots, title and price.
class _FeaturedProductCard extends StatelessWidget {
  const _FeaturedProductCard({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  final String imagePath;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: MyColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(MySizes.cardRadiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MySizes.cardRadiusMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      color: MyColors.lightContainer,
                      child: const Icon(Icons.image_not_supported, color: MyColors.placeholderInactive),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == 1 ? MyColors.primary : MyColors.grey,
                ),
              )),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: MyColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.brandLogoPath,
  });

  final String imagePath;
  final String title;
  final String price;
  final String brandLogoPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(MySizes.cardRadiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MySizes.cardRadiusMd),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder:
                  (_, __, ___) => Container(
                    color: MyColors.lightContainer,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: MyColors.placeholderInactive,
                    ),
                  ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white.withValues(alpha: 0.3),
                          backgroundImage: AssetImage(brandLogoPath),
                          onBackgroundImageError: (_, __) {},
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: MyColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.primary,
        borderRadius: BorderRadius.circular(MySizes.cardRadiusMd),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(Icons.arrow_outward, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
