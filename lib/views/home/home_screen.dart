import 'package:flutter/material.dart';
import 'package:sss/core/utils/constants/sizes.dart';
import 'package:sss/views/home/widgets/home_choice_chips.dart';
import 'package:sss/views/home/widgets/home_nav_bar.dart';
import 'package:sss/views/home/widgets/home_page_view_section.dart';
import 'package:sss/views/home/widgets/home_product_grid.dart';
import 'package:sss/views/home/widgets/home_search_bar.dart';
import 'package:sss/views/home/widgets/home_tab_bar.dart';

/// Home page: tab bar, search bar, pull-down chips, PageView (60% height), product grid, bottom nav.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;
  int _chipIndex = 0;
  bool _chipsExpanded = false;
  int _pageViewIndex = 0;
  int _navIndex = 0;
  double _pageViewHeight = 300;
  final ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setPageViewHeight());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > _lastScrollOffset && offset > 20) {
      if (!_chipsExpanded && mounted) setState(() => _chipsExpanded = true);
    } else if (offset < _lastScrollOffset) {
      if (_chipsExpanded && mounted) setState(() => _chipsExpanded = false);
    }
    _lastScrollOffset = offset;
  }

  void _setPageViewHeight() {
    final h = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final usedByTabSearchChips = 120.0;
    final targetHeight = (h - topPadding - usedByTabSearchChips) * 0.6;
    if (mounted && targetHeight > 0) {
      setState(() => _pageViewHeight = targetHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HomeTabBar(
                selectedIndex: _tabIndex,
                onTabChanged: (i) => setState(() => _tabIndex = i),
              ),
            ),
            GestureDetector(
              onVerticalDragUpdate: (d) {
                if (d.delta.dy > 8) setState(() => _chipsExpanded = true);
                if (d.delta.dy < -8) setState(() => _chipsExpanded = false);
              },
              child: const HomeSearchBar(),
            ),
            HomeChoiceChips(
              expanded: _chipsExpanded,
              selectedIndex: _chipIndex,
              onChipSelected: (i) => setState(() => _chipIndex = i),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        maxWidth: constraints.maxWidth,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: HomePageViewSection(
                              pageHeight: _pageViewHeight,
                              currentPage: _pageViewIndex,
                              onPageChanged:
                                  (i) => setState(() => _pageViewIndex = i),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const SizedBox(height: 12),
                          HomePageViewIndicator(
                            pageCount: 2,
                            currentPage: _pageViewIndex,
                          ),
                          const SizedBox(height: MySizes.lg),
                          const HomeProductGrid(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            HomeNavBar(
              currentIndex: _navIndex,
              onTap: (i) => setState(() => _navIndex = i),
            ),
          ],
        ),
      ),
    );
  }
}
