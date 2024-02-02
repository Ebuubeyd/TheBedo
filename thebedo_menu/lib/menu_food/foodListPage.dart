import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thebedo_menu/client/testDbController.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage>
    with TickerProviderStateMixin {
  final TestDbController testDbController = Get.put(TestDbController());
  late AnimationController _animationController;
  late AnimationController _breathController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animationController.forward();
    _breathController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat the breath animation
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Arka planı şeffaf yap
        elevation: 0, // Gölgeyi kaldır
        title: Text(
          'The BEDO Yemek Menüsü',
          style: TextStyle(color: Colors.grey[200]),
        ),
        flexibleSpace: FlexibleSpaceBar(
          background: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 40, sigmaY: 40), // Hafif bulanıklık uygula
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[200],
          ),
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: ListView.builder(
          itemCount: testDbController.urunlerinAdi.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _animationController,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              if (index % 2 == 0)
                                Transform.translate(
                                  offset: Offset(
                                      -200 + _animationController.value * 200,
                                      0),
                                  child: _buildImageWithBreathEffectFood(
                                      'assets/img/${testDbController.fotoAdres[index]}.png'),
                                ),
                              Expanded(
                                child: Row(
                                  children: [
                                    if (index % 2 == 0)
                                      Transform.translate(
                                        offset: Offset(
                                            220 -
                                                _animationController.value *
                                                    200,
                                            0),
                                        child: Container(
                                          width: size.width / 2.3,
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  '${testDbController.urunlerinAdi[index]}',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${testDbController.urunAciklamasi[index]}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (index % 2 == 1)
                                      Transform.translate(
                                        offset: Offset(
                                            -200 +
                                                _animationController.value *
                                                    210,
                                            0),
                                        child: Container(
                                          width: size.width / 2.3,
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  '${testDbController.urunlerinAdi[index]}',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Text(
                                                '${testDbController.urunAciklamasi[index]}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (index % 2 == 1)
                                Transform.translate(
                                  offset: Offset(
                                      200 - _animationController.value * 200,
                                      0),
                                  child: _buildImageWithBreathEffectFood(
                                      'assets/img/${testDbController.fotoAdres[index]}.png'),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageWithBreathEffectFood(String imagePath) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _breathController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0,
              20 * sin(_breathController.value * 0.15 * pi)), // Breath motion
          child: child,
        );
      },
      child: Container(
        width: size.width * 0.3,
        height: size.height * 0.3,
        child: Image.asset(imagePath),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _breathController.dispose(); // Dispose of the breath controller
    super.dispose();
  }
}
