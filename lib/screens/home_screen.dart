import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/form_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  void _goToPage(int index) {
    if (index >= 0 && index < availableForms.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentPage = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7f4f24),
              Color(0xFF936639),
              Color(0xFFa68a64),
              Color(0xFFb6ad90),
              Color(0xFFc2c5aa),
              Color(0xFFa4ac86),
              Color(0xFF656d4a),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            itemCount: availableForms.length,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            itemBuilder: (context, index) {
              final form = availableForms[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          form.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 100, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 2),


                    Text(
                      form.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 2),


                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forms/${form.id}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF7f4f24),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        "Fill",
                        style: GoogleFonts.dancingScript(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => _goToPage(currentPage - 1),
                          child: const Text("⟨ last", style: TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () => _goToPage(currentPage + 1),
                          child: const Text("Next ⟩", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(availableForms.length, (dotIndex) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == dotIndex ? 14 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == dotIndex ? Colors.white : Colors.white60,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 4),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
