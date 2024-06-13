import 'package:flutter/material.dart';

class ExploreItem {
  final String imageURL;
  final String title;
  final String subtitle;

  ExploreItem({required this.imageURL, required this.title, required this.subtitle});
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<ExploreItem> itemsAI = [
    ExploreItem(imageURL: 'assets/images/droplet.png', title: "Water AI", subtitle: "Chat with AI to learn more about better habits to help keep you hydrated!"),
    ExploreItem(imageURL: 'assets/images/bottles.png', title: 'Test', subtitle: "test 2")
  ];
  final List<ExploreItem>dietItems = [
    ExploreItem(imageURL: 'assets/images/keto.png', title: "Keto", subtitle: "Learn mre about some of the keto diets that can be helpful!"),
    ExploreItem(imageURL: 'assets/images/vegetarian.png', title: 'Test', subtitle: "test 2")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
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
                  width: 250, // Taking the full width of the screen minus the margin
                  child: InkWell(
                    onTap: () {
                      // Handle the tap event
                      print('Card tapped: ${item.title}');
                    },
                    child: Card(
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
                        // Handle the tap event
                        print('Card tapped: ${item.title}');
                      },
                      child: Card(
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
    );
  }
}
