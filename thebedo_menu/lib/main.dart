import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thebedo_menu/menu_drinks/drinkListPage.dart';
import 'package:thebedo_menu/menu_food/foodListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'The bedo Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true, scaffoldBackgroundColor: Colors.grey[800]),
      home: const MainPageCollector(),

      opaqueRoute: true,
      defaultTransition: Transition.fadeIn, // Varsayılan geçiş animasyonu
      defaultGlobalState: true, // Global durumu kullan
    );
  }
}

class MainPageCollector extends StatefulWidget {
  const MainPageCollector({super.key});

  @override
  State<MainPageCollector> createState() => _MainPageCollectorState();
}

class _MainPageCollectorState extends State<MainPageCollector>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    loginAnim();
  }

  void loginAnim() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    // Animasyonun tamamlandığını dinlemek için listener ekleyin
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.to(() => VisibleButtons());
      }
    });

    // 3 saniye bekleyip animasyonu başlat
    Future.delayed(Duration(milliseconds: 1800), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset('assets/img/bedologo.png'),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class VisibleButtons extends StatefulWidget {
  const VisibleButtons({super.key});

  @override
  State<VisibleButtons> createState() => _VisibleButtonsState();
}

class _VisibleButtonsState extends State<VisibleButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    revealItem();
  }

  void revealItem() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500), // Animasyon süresini ayarlayın
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Animasyonun tamamlandığını dinlemek için listener ekleyin
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animasyon tamamlandığında yapılacak işlemler
      }
    });

    // Animasyonu başlat
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width / 1.6,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () {
                              Get.to(
                                () => FoodListPage(),
                                transition: Transition.fadeIn,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Yiyecekler',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                SvgPicture.asset(
                                  'assets/img/burger-solid.svg',
                                  width: size.width * 0.05,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width / 1.6,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () {
                              Get.to(
                                () => DrinkListPage(),
                                transition: Transition.fadeIn,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'İçecekler',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                SvgPicture.asset(
                                  'assets/img/glass-water-solid.svg',
                                  width: size.width * 0.04,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
