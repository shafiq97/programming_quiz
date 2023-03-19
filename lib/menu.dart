import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your quiz!'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/cpp");
                        },
                        child: const FancyCard(
                          title: 'C++',
                          subtitle: 'Enhance your C++ skills!',
                          color: Colors.pink,
                          animation: 'assets/cpp_lottie.json',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/java");
                        },
                        child: const FancyCard(
                          title: 'JAVA',
                          subtitle: 'Brush up your JAVA problem solving!',
                          color: Colors.purple,
                          animation: 'assets/java_lottie.json',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/html");
                        },
                        child: const FancyCard(
                          title: 'HTML',
                          subtitle: 'Refresh your html knowledge!',
                          color: Colors.blue,
                          animation: 'assets/html_lottie.json',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/mysql");
                        },
                        child: const FancyCard(
                          title: 'MYSQL',
                          subtitle: 'Sharpen your query skills!',
                          color: Colors.teal,
                          animation: 'assets/mysql_lottie.json',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FancyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String animation;

  const FancyCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset(animation),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
