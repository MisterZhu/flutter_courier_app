import 'package:courier_app/features/account/account_page.dart';
import 'package:courier_app/features/home/home_page.dart';
import 'package:courier_app/features/main/providers/main_provider.dart';
import 'package:courier_app/features/task/task_page.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends StatefulWidget {
  static const homeIndex = 0;
  static const taskIndex = 1;
  static const accountIndex = 2;

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Consumer(
              builder: (context, ref, child) {
                debugPrint('bottomNavigationBar build');

                // 监听登录成功事件
                final _ = ref.watch(mainLoginSuccessProvider);

                ref.listen(mainLoginSuccessProvider, (previous, next) {
                  debugPrint('我监听到了登录成功');
                });

                return child!;
              },
              child: const SizedBox.shrink(),
            ),
          ),
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomePage(),
              TaskPage(),
              AccountPage(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          ref.listen(mainTabIndexProvider, (previous, next) {
            _pageController.jumpToPage(next);
          });

          final currentIndex = ref.watch(mainTabIndexProvider);

          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            iconSize: 25,
            unselectedItemColor: Colours.grey99,
            selectedItemColor: Colours.primaryColor,
            unselectedLabelStyle: TextStyles.smallest,
            selectedLabelStyle: TextStyles.smallestSemiBold,
            onTap: (index) {
              _tabBarOnTap(ref, index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(Res.tab_home),
                label: 'Home',
                activeIcon: Image.asset(Res.tab_home_selected),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(Res.tab_task),
                label: 'Tracking',
                activeIcon: Image.asset(Res.tab_task_selected),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(Res.tab_account),
                label: 'Account',
                activeIcon: Image.asset(Res.tab_account_selected),
              ),
            ],
          );
        },
      ),
    );
  }

  // Tab bar 点击事件
  void _tabBarOnTap(WidgetRef ref, int index) {
    // 变更mainTabIndexProvider状态
    ref.read(mainTabIndexProvider.notifier).state = index;
  }
}
