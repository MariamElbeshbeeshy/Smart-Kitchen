import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../helper/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  bool hasRecipe = false;
  final List<String> ingredients = [];
  int savedIngredients = 0;
  String? recipeTitle;
  List<String> recipeIngredients = [];
  List<String> recipeSteps = [];

  Future<void> generateRecipe() async {
    try {
      final ingredientsText = ingredients.join(', ');
      String myApiKey = dotenv.env['API_KEY'] ?? 'No Key Found';
      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Authorization':
              'Bearer $myApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "llama-3.1-8b-instant",
          "messages": [
            {
              "role": "user",
              "content": """
Create a simple recipe using only these ingredients:
$ingredientsText

Rules:
- Return ONLY valid JSON.
- Recipe title must be short.
- Maximum 6 ingredients.
- Maximum 5 short cooking steps.
- Each step should be one short sentence.
- Difficulty should be Easy.
- Cooking time should be about 20 minutes.
- Servings should be 2.

Return exactly this JSON format:

{
  "title": "Recipe Name",
  "ingredients": [
    "Chicken",
    "Rice",
    "Tomato"
  ],
  "steps": [
    "Cook rice.",
    "Fry onion.",
    "Add chicken.",
    "Add tomato.",
    "Serve hot."
  ]
}
""",
            },
          ],
        }),
      );
      print(response.statusCode);
      print(response.body);

      final data = jsonDecode(response.body);

      print(data);
      if (response.statusCode == 200) {
        final result = data['choices'][0]['message']['content'];

        final recipeData = jsonDecode(result);

        setState(() {
          hasRecipe = true;

          recipeTitle = recipeData["title"];

          recipeIngredients = List<String>.from(recipeData["ingredients"]);

          recipeSteps = List<String>.from(recipeData["steps"]);
          savedIngredients += ingredients.length;
        });
      } else {
        print(data);
      }
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("ERROR: $e")));
    }
  }

  void clearRecipe() {
    setState(() {
      hasRecipe = false;

      recipeTitle = null;
      recipeIngredients.clear();
      recipeSteps.clear();

      ingredients.clear();
      controller.clear();
    });
  }

  final Map<String, String> ingredientEmojis = {
    'tomato': '🍅',
    'tomatoes': '🍅',
    'kale': '🥬',
    'spinach': '🥬',
    'lettuce': '🥬',
    'salmon': '🐟',
    'fish': '🐟',
    'tuna': '🐟',
    'chicken': '🍗',
    'beef': '🥩',
    'meat': '🥩',
    'egg': '🥚',
    'eggs': '🥚',
    'onion': '🧅',
    'onions': '🧅',
    'garlic': '🧄',
    'carrot': '🥕',
    'potato': '🥔',
    'potatoes': '🥔',
    'cucumber': '🥒',
    'broccoli': '🥦',
    'mushroom': '🍄',
    'corn': '🌽',
    'apple': '🍎',
    'banana': '🍌',
    'orange': '🍊',
    'lemon': '🍋',
    'strawberry': '🍓',
    'milk': '🥛',
    'cheese': '🧀',
    'bread': '🍞',
    'rice': '🍚',
    'pasta': '🍝',
  };

  String getEmoji(String ingredient) {
    return ingredientEmojis[ingredient.toLowerCase().trim()] ?? '🥘';
  }

  void addIngredient() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      ingredients.add(controller.text.trim());
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// HERO IMAGE
              Column(
                children: [
                  Image.asset("assets/images/logo.jpg", height: 70),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/fridge.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// INGREDIENTS TITLE
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ingredients :",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 83, 45),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// SEARCH BAR
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color.fromARGB(255, 20, 83, 45),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type or add ingredients...",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 20, 83, 45),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 39,
                        height: 39,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 20, 83, 45),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: addIngredient,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),

              /// INGREDIENT CHIPS
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ingredients.map((ingredient) {
                  return Chip(
                    backgroundColor: AppColors.chipColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 20, 83, 45),
                        width: 1,
                      ),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: -2,
                      vertical: -2,
                    ),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        ingredients.remove(ingredient);
                      });
                    },
                    label: Text("${getEmoji(ingredient)} $ingredient"),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 12),

              /// INFO TEXT
              const Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: Color.fromARGB(255, 20, 83, 45),
                    size: 22,
                  ),
                  SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      "Add ingredients you have in your fridge to get recipe ideas.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 83, 45),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// GENERATE RECIPES BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await generateRecipe();
                  },
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  label: const Text(
                    "Generate Recipes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 20, 83, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// AI MESSAGE
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                    ),
                    child: const Icon(
                      Icons.smart_toy,
                      color: Color(0xFF2E7D32),
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi! I'm Kitchenly AI 👋",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Add some ingredients above, and I'll suggest tasty recipes for you.",
                            style: TextStyle(fontSize: 15, height: 1.4),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        color: Color(0xFF2E7D32),
                        size: 22,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Here's what I recommend",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 20, 83, 45),
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: clearRecipe,
                    icon: const Icon(
                      Icons.auto_awesome,
                      color: Color.fromARGB(255, 20, 83, 45),
                      size: 16,
                    ),
                    label: const Text(
                      "New Recipe",
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 83, 45),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5FAF2),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 20, 83, 45),
                      ),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              /// RECIPE BOX
              hasRecipe
                  ? buildRecipeCard()
                  : DottedBorder(
                      color: const Color(0xFFB7D8B1),
                      strokeWidth: 2,
                      dashPattern: [8, 5],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(20),
                      child: Container(
                        width: double.infinity,
                        height: 220,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dinner_dining,
                              size: 70,
                              color: Color(0xFFB7D8B1),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Your recipe suggestions will appear here",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Add ingredients to get started!",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              /// IMPACT CARD
              Container(
                width: double.infinity,
                height: 125,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F9F2),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    /// BAG IMAGE
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/bag.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    /// LEFT SIDE
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Kitchen Impact",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "$savedIngredients",
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  "ingredients saved so far 🌿",
                                  style: TextStyle(fontSize: 11, height: 1.2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 90,
                      color: Colors.grey.shade300,
                    ),

                    const SizedBox(width: 18),

                    /// RIGHT SIDE
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Great job! You're making a difference. 💚",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade800,
                          height: 1.5,
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

  Widget buildRecipeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F9F2),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 35,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  recipeTitle ?? "",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // INFO CHIPS
          Row(
            children: [
              _infoChip(Icons.access_time, "20 min"),
              const SizedBox(width: 10),
              _infoChip(Icons.people_outline, "2 servings"),
              const SizedBox(width: 10),
              _infoChip(Icons.bar_chart, "Easy"),
            ],
          ),

          const SizedBox(height: 25),

          // INGREDIENTS + STEPS
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ingredients Used",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...recipeIngredients.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "${getEmoji(item)} $item",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 250, color: Colors.grey.shade300),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Quick Steps",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...recipeSteps.asMap().entries.map(
                          (step) => Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: const Color(0xFF2E7D32),
                                  child: Text(
                                    "${step.key + 1}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    step.value,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9F2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF2E7D32)),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}
