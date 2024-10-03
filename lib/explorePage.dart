import 'package:flutter/material.dart';
import 'package:smartflask/chatPage.dart';
import 'package:smartflask/dietPage.dart';

class ExploreItem {
  final String imageURL;
  final String title;
  final String subtitle;
  final String assistantID = "";

  ExploreItem({required this.imageURL, required this.title, required this.subtitle, assistantID});
}
class Diet {
  final String name;
  final List<String> description;
  final Map<String, String> dishTypes;
  final List<String> waterIntake;
  Diet({required this.name, required this.description, required this.dishTypes, required this.waterIntake});
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<ExploreItem> itemsAI = [
    ExploreItem(imageURL: 'assets/images/droplet.png', title: "Water AI", subtitle: "Chat with AI to learn more about better habits to help keep you hydrated!", assistantID: "asst_e2cMEOXkbAcIDCafSUC0sq3e"),
    ExploreItem(imageURL: 'assets/images/bottles.png', title: 'Explore Your Bottle', subtitle: "Learn more about the functionality of your bottle!", assistantID: "asst_cHAauFF2GrCamuSly659MhkK")
  ];
  final List<ExploreItem>dietItems = [
    ExploreItem(imageURL: 'assets/images/keto.png', title: "Keto", subtitle: "Learn mre about some of the keto diets that can be helpful!"),
    ExploreItem(imageURL: 'assets/images/vegetarian.png', title: 'Vegetarian', subtitle: "See how vegetarian plans can be beneficial in your diet")
  ];
  final List<Diet> diets = [
    Diet(name: "Keto",
      description: ["A ketogenic (keto) diet is a low-carb, high-fat eating plan designed to shift the body into a state of ketosis, where it burns fat for fuel instead of carbohydrates. Typically, the diet involves consuming about 70-75% of daily calories from fat, 20-25% from protein, and only 5-10% from carbohydrates. Staying hydrated is crucial on a keto diet because the body loses more water and electrolytes as it shifts away from using carbs."],
      dishTypes: {"Salmon Tomato Salad": "assets/images/Salmon Tomato Salad.png", "Avocado, Ham, and Cheese": "assets/images/AHC.png"},
      waterIntake: [
        "Aim to drink at least 8-10 glasses of water daily to stay hydrated, and consider adding a pinch of salt or an electrolyte supplement to your water to help maintain balance. Proper hydration supports the body’s transition to ketosis and can help minimize common side effects like headaches and fatigue."
      ]
    ),
    Diet(name: "Vegetarian",
        description: [
          "A vegetarian diet primarily consists of plant-based foods, such as vegetables, fruits, grains, nuts, seeds, and legumes. It excludes meat, poultry, and fish but may include animal products like dairy and eggs, depending on the type (lacto-vegetarian, ovo-vegetarian, or lacto-ovo-vegetarian). This diet is often adopted for health, ethical, or environmental reasons. It can provide all necessary nutrients if well-planned, focusing on a variety of foods to meet protein, vitamin, and mineral needs."
        ],
        dishTypes: {"Salmon Tomato Salad": "assets/images/Salmon Tomato Salad.png", "Avocado, Ham, and Cheese": "assets/images/AHC.png"},
        waterIntake: ["As for water intake, the general recommendation is about 8-10 cups (2-2.5 liters) per day for most adults. However, individual needs can vary based on factors like age, activity level, climate, and overall health."]
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const Text("Chat With AI", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30),),
              Container(
              height: 250,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemsAI.length,
                itemBuilder: (BuildContext context, int index) {
                  ExploreItem item = itemsAI[index];
                  return Container(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    // Taking the full width of the screen minus the margin
                    child: InkWell(
                      onTap: () {
                        // Handle the tap event
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage(assistantID: itemsAI[index].assistantID)));
          
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        clipBehavior: Clip.antiAlias, // This ensures that the image is clipped to the card's boundaries
                        child: Stack(
                          children: <Widget>[
                            Image.asset(
                              item.imageURL,
                              fit: BoxFit.cover, // This ensures the image covers the card's background completely
                              width: double.infinity, // The image should stretch to the width of the Card
                              height: double.infinity, // The image should stretch to the height of the Card
                            ),
                            Container( // This container adds a dark overlay to the image to ensure text is legible
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3), // The opacity here adds a dimming effect to the image
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      item.subtitle,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
              const Text("Diets", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30),),
              Container(
                height: 250,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dietItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    ExploreItem item = dietItems[index];
                    return Container(
                      width: 250, // Taking the full width of the screen minus the margin
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DietPage(dietInfo: diets[index],)));
                          // Handle the tap event
                          print('Card tapped: ${item.title}');
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          clipBehavior: Clip.antiAlias, // This ensures that the image is clipped to the card's boundaries
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                item.imageURL,
                                fit: BoxFit.cover, // This ensures the image covers the card's background completely
                                width: double.infinity, // The image should stretch to the width of the Card
                                height: double.infinity, // The image should stretch to the height of the Card
                              ),
                              Container( // This container adds a dark overlay to the image to ensure text is legible
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3), // The opacity here adds a dimming effect to the image
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        item.subtitle,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
