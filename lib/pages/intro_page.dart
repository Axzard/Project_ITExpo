import 'package:flutter/material.dart';
import 'package:jendela_informatika/pages/landing_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset('assets/images/logohmti.png', width: 40, height: 40),
            SizedBox(width: 10),
            Text(
              "Jenfo",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage()),
              );
            },
            child: const Text(
              "Masuk",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                onLastPage = (index == 3);
              });
            },
            children: [
              buildPage(
                imagePath: 'assets/images/intro1.png',
                title: "Eksplor Dunia Informatika",
                desc:
                    "Pelajari konsep dasar teknologi, jaringan, dan pemrograman secara interaktif.",
              ),
              buildPage(
                imagePath: 'assets/images/intro2.png',
                title: "Materi & Tutorial Praktis",
                desc:
                    "Akses materi, modul, dan latihan pemrograman yang lengkap & mudah dipahami.",
              ),
              buildPage(
                imagePath: 'assets/images/intro3.png',
                title: "Kolaborasi & Inspirasi",
                desc:
                    "Terhubung dengan komunitas, dapatkan ide, dan wujudkan inovasi teknologi.",
              ),
              buildPage(
                imagePath: 'assets/images/intro4.png',
                title: "Ayo Jelajahi Dunia Informatika",
                desc:
                    "Pelajari teknologi dan terinspirasi dalam dunia inovasi teknologi.",
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _currentPage == 0
                    ? const SizedBox(width: 60)
                    : GestureDetector(
                        onTap: () {
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          "Kembali",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                Row(
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.blue.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),

                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LandingPage(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: const Text(
                            "Mulai",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          "Lanjut",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String imagePath,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 300, fit: BoxFit.contain),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            desc,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
