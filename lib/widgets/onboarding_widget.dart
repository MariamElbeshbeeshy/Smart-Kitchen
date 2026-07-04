import 'package:flutter/material.dart';
import 'package:smart_kitchen/models/onboarding_data_model.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.onboardingInfo,
  });

  final OnboardingDataModel onboardingInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 🖼️ Image
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 306,
          width: 294,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              onboardingInfo.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
    
        const SizedBox(height: 30),
    
        /// 📝 Title
        SizedBox(
          width: 295,
          child: Text(
            onboardingInfo.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32),
          ),
        ),
    
        const SizedBox(height: 20),
    
        /// 📄 Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            onboardingInfo.desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
