
import 'package:flutter/material.dart';
import 'package:sss/core/utils/constants/sizes.dart';
import 'package:sss/views/home/widgets/home_choice_chips.dart';
import 'package:sss/views/home/widgets/home_nav_bar.dart';
import 'package:sss/views/home/widgets/home_page_view_section.dart';
import 'package:sss/views/home/widgets/home_product_grid.dart';
import 'package:sss/views/home/widgets/home_search_bar.dart';
import 'package:sss/views/home/widgets/home_tab_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum ScrollDirectionState { up, down, idle }

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;
  int _chipIndex = 0;
  int _pageViewIndex = 0;
  int _navIndex = 0;

  double _pageViewHeight = 300;

  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  double _lastScrollOffset = 0;

  bool _searchFocused = false;
  bool _showNavbar = true;
  bool _showChips = false;

  ScrollDirectionState _direction = ScrollDirectionState.idle;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _setPageViewHeight());

    _scrollController.addListener(_onScroll);
    _searchFocusNode.addListener(_onSearchFocusChange);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    _searchFocusNode.removeListener(_onSearchFocusChange);
    _searchFocusNode.dispose();

    _searchController.dispose();

    super.dispose();
  }

  void _onSearchFocusChange() {
    if (mounted) {
      setState(() {
        _searchFocused = _searchFocusNode.hasFocus;
      });
    }
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final difference = offset - _lastScrollOffset;

    if (difference.abs() < 10) return;

    if (difference > 0) {
      /// scrolling DOWN the page
      if (_direction != ScrollDirectionState.down) {
        setState(() {
          _direction = ScrollDirectionState.down;
          _showNavbar = false;
          _showChips = false;
        });
      }
    } else {
      /// scrolling UP the page
      if (_direction != ScrollDirectionState.up) {
        setState(() {
          _direction = ScrollDirectionState.up;
          _showNavbar = true;
          _showChips = true;
        });
      }
    }

    _lastScrollOffset = offset;
  }

  void _setPageViewHeight() {
    final h = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;

    const usedByHeader = 120.0;

    final targetHeight = (h - topPadding - usedByHeader) * 0.6;

    if (mounted && targetHeight > 0) {
      setState(() {
        _pageViewHeight = targetHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTabBar = !_searchFocused;
    final showNavBar = !_searchFocused && _showNavbar;
    final showChips = !_searchFocused && _showChips;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            /// TAB BAR
            if (showTabBar)
              Padding(
                padding: const EdgeInsets.all(8),
                child: HomeTabBar(
                  selectedIndex: _tabIndex,
                  onTabChanged: (i) {
                    setState(() {
                      _tabIndex = i;
                    });
                  },
                ),
              ),

            /// SEARCH BAR
            HomeSearchBar(
              controller: _searchController,
              focusNode: _searchFocusNode,
              isSearching: _searchFocused,
            ),

            /// CHOICE CHIPS
            if (showChips)
              HomeChoiceChips(
                expanded: true,
                selectedIndex: _chipIndex,
                onChipSelected: (i) {
                  setState(() {
                    _chipIndex = i;
                  });
                },
              ),

            /// BODY
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

                          /// PAGEVIEW
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: HomePageViewSection(
                              pageHeight: _pageViewHeight,
                              currentPage: _pageViewIndex,
                              onPageChanged: (i) {
                                setState(() {
                                  _pageViewIndex = i;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// INDICATOR
                          HomePageViewIndicator(
                            pageCount: 2,
                            currentPage: _pageViewIndex,
                          ),

                          const SizedBox(height: MySizes.lg),

                          /// PRODUCT GRID
                          const HomeProductGrid(),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// NAVBAR
            if (showNavBar)
              HomeNavBar(
                currentIndex: _navIndex,
                onTap: (i) {
                  setState(() {
                    _navIndex = i;
                  });
                },
                transparent: false,
              ),
          ],
        ),
      ),
    );
  }
}
