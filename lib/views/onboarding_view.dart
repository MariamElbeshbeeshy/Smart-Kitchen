import 'package:flutter/material.dart';
import 'package:smart_kitchen/models/onboarding_data_model.dart';
import 'package:smart_kitchen/views/Sign_up_view.dart';
import 'package:smart_kitchen/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;

  final List<OnboardingDataModel> data = [
    OnboardingDataModel(
  desc: "Don’t let your ingredients go to waste. Tell us what’s in your pantry, and our AI will suggest the perfect recipe for you.",
  image:  "assets/images/HealthyIngredients.png", 
   title: "Cook with what you have"),
    OnboardingDataModel(
    desc:  "Join a community of neighbors buying and selling surplus home-cooked meals or extra groceries at great prices.",
     image: "assets/images/Frame.png", 
   title: "Share more, waste less",
   ),
       OnboardingDataModel(
    desc: "Track your groceries effortlessly. We’ll send you smart alerts before your food expires, so you never have to throw away money again.",
   image:  "assets/images/HeroIllustration.png",
   title:  "Your fridge on autopilot",),

  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void nextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:            RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Kitchen",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF105E22),
                          ),
                        ),
                        TextSpan(
                          text: "ly",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),

        actions: [
          if(currentIndex != data.length - 1)
          TextButton(
            onPressed: () {
              controller.jumpToPage(data.length - 1);
            },
            child: const Text(
              "Skip",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],

      ),
      body: SafeArea(
        child: Column(
          children: [
            /// 📱 Pages
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return OnboardingWidget(onboardingInfo: data[index]);
                },
              ),
            ),

            /// 🔽 Bottom
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  /// 🔵 Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      data.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentIndex == index ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🟢 Button
                  currentIndex == data.length - 1
                      ? Center(
                          child: SizedBox(
                            width: 262,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                          context,
                                      MaterialPageRoute(
                                 builder: (context) => SignUpView(),
                                          ),
                                            );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Get Started",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 55,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.zero, 
                              ),
                              onPressed: nextPage,
                              child: const Center(
                              
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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