import 'package:flutter/material.dart';
import 'package:smartflask/chatPage.dart';
import 'package:smartflask/dietPage.dart';

class ExploreItem {
  final String imageURL;
  final String title;
  final String subtitle;

  ExploreItem({required this.imageURL, required this.title, required this.subtitle});
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
    ExploreItem(imageURL: 'assets/images/droplet.png', title: "Water AI", subtitle: "Chat with AI to learn more about better habits to help keep you hydrated!"),
    ExploreItem(imageURL: 'assets/images/bottles.png', title: 'Explore Your Bottle', subtitle: "Learn more about the functionality of your bottle!")
  ];
  final List<ExploreItem>dietItems = [
    ExploreItem(imageURL: 'assets/images/keto.png', title: "Keto", subtitle: "Learn mre about some of the keto diets that can be helpful!"),
    ExploreItem(imageURL: 'assets/images/vegetarian.png', title: 'Vegetarian', subtitle: "See how vegetarian plans can be beneficial in your diet")
  ];
  final List<Diet> diets = [
    Diet(name: "Keto",
      description: [
      "Lorem ipsum odor amet, consectetuer adipiscing elit. Potenti luctus vel sodales senectus posuere est ultrices augue. Inceptos vitae eleifend maecenas senectus etiam lacinia tortor. Proin ultrices morbi erat interdum pellentesque condimentum. Hac ut ipsum a dolor morbi nibh ultricies velit. Sagittis habitant mattis habitasse mi amet. Montes finibus convallis, faucibus cras morbi phasellus rutrum. Sapien ridiculus elementum massa ante blandit penatibus lacus. Lectus tristique himenaeos class curabitur lectus nibh.",

  "Fringilla felis vehicula quam molestie hac; a dui. Eleifend euismod amet fusce ex cubilia in curabitur bibendum. Viverra senectus placerat efficitur proin donec dolor dictum per interdum. Ullamcorper neque bibendum purus iaculis morbi porttitor conubia placerat. Malesuada interdum tellus metus habitasse tristique magna primis. Ut litora nec, dui felis dolor cursus sit vehicula class. Diam cubilia class; fames gravida adipiscing semper fames imperdiet habitant. Hac non nunc per nostra curae. Senectus iaculis aliquam semper magna nascetur nascetur congue ut.",

"Arcu sit scelerisque ligula vel, finibus felis aenean consequat. Sociosqu arcu gravida dignissim morbi vitae maximus, natoque ridiculus consectetur. Eleifend per magna ipsum molestie vulputate. Leo nascetur primis vitae netus; sed congue pharetra. Habitant curae ac sociosqu ante a massa luctus. Mi cursus non ultrices auctor ac. Cras pharetra nibh diam maximus, imperdiet metus semper hendrerit pretium. Orci dignissim congue ut neque nisi. Turpis ullamcorper auctor, sociosqu scelerisque facilisi ac malesuada aliquam? Cursus vulputate sit facilisi cras tellus nam eget litora.",

 " Hendrerit velit tristique; proin egestas natoque dapibus diam. Natoque sociosqu dapibus morbi accumsan hendrerit pretium morbi. Nec ac tortor diam semper quis parturient velit. Ipsum sed sem fermentum in diam. Cubilia scelerisque molestie dui integer quam vitae natoque sollicitudin. Maecenas cubilia eu hendrerit vestibulum inceptos. Proin dui vitae morbi natoque rutrum hac egestas curae. Efficitur aenean magna vel pellentesque, interdum est ante amet? Aegestas iaculis hac dis tempor leo.",

  "Elementum aptent metus ullamcorper semper nisl felis scelerisque porttitor. Quisque euismod gravida fusce vitae risus auctor risus accumsan ridiculus. Proin malesuada nisl habitant habitasse neque. Aenean inceptos consequat penatibus neque; ex morbi dictumst? Hac mattis iaculis ad aenean sociosqu cras ut tempor felis. Congue sem suspendisse posuere sit pulvinar vehicula."
    ],
      dishTypes: {"Salmon Tomato Salad": "assets/images/Salmon Tomato Salad.png", "Avocado, Ham, and Cheese": "assets/images/AHC.png"},
      waterIntake: [
        "Lorem ipsum odor amet, consectetuer adipiscing elit. Potenti luctus vel sodales senectus posuere est ultrices augue. Inceptos vitae eleifend maecenas senectus etiam lacinia tortor. Proin ultrices morbi erat interdum pellentesque condimentum. Hac ut ipsum a dolor morbi nibh ultricies velit. Sagittis habitant mattis habitasse mi amet. Montes finibus convallis, faucibus cras morbi phasellus rutrum. Sapien ridiculus elementum massa ante blandit penatibus lacus. Lectus tristique himenaeos class curabitur lectus nibh.",

        "Fringilla felis vehicula quam molestie hac; a dui. Eleifend euismod amet fusce ex cubilia in curabitur bibendum. Viverra senectus placerat efficitur proin donec dolor dictum per interdum. Ullamcorper neque bibendum purus iaculis morbi porttitor conubia placerat. Malesuada interdum tellus metus habitasse tristique magna primis. Ut litora nec, dui felis dolor cursus sit vehicula class. Diam cubilia class; fames gravida adipiscing semper fames imperdiet habitant. Hac non nunc per nostra curae. Senectus iaculis aliquam semper magna nascetur nascetur congue ut.",

      ]
    ),
    Diet(name: "Vegetarian",
        description: [
          "Lorem ipsum odor amet, consectetuer adipiscing elit. Potenti luctus vel sodales senectus posuere est ultrices augue. Inceptos vitae eleifend maecenas senectus etiam lacinia tortor. Proin ultrices morbi erat interdum pellentesque condimentum. Hac ut ipsum a dolor morbi nibh ultricies velit. Sagittis habitant mattis habitasse mi amet. Montes finibus convallis, faucibus cras morbi phasellus rutrum. Sapien ridiculus elementum massa ante blandit penatibus lacus. Lectus tristique himenaeos class curabitur lectus nibh.",

          "Fringilla felis vehicula quam molestie hac; a dui. Eleifend euismod amet fusce ex cubilia in curabitur bibendum. Viverra senectus placerat efficitur proin donec dolor dictum per interdum. Ullamcorper neque bibendum purus iaculis morbi porttitor conubia placerat. Malesuada interdum tellus metus habitasse tristique magna primis. Ut litora nec, dui felis dolor cursus sit vehicula class. Diam cubilia class; fames gravida adipiscing semper fames imperdiet habitant. Hac non nunc per nostra curae. Senectus iaculis aliquam semper magna nascetur nascetur congue ut.",

          "Arcu sit scelerisque ligula vel, finibus felis aenean consequat. Sociosqu arcu gravida dignissim morbi vitae maximus, natoque ridiculus consectetur. Eleifend per magna ipsum molestie vulputate. Leo nascetur primis vitae netus; sed congue pharetra. Habitant curae ac sociosqu ante a massa luctus. Mi cursus non ultrices auctor ac. Cras pharetra nibh diam maximus, imperdiet metus semper hendrerit pretium. Orci dignissim congue ut neque nisi. Turpis ullamcorper auctor, sociosqu scelerisque facilisi ac malesuada aliquam? Cursus vulputate sit facilisi cras tellus nam eget litora.",

          " Hendrerit velit tristique; proin egestas natoque dapibus diam. Natoque sociosqu dapibus morbi accumsan hendrerit pretium morbi. Nec ac tortor diam semper quis parturient velit. Ipsum sed sem fermentum in diam. Cubilia scelerisque molestie dui integer quam vitae natoque sollicitudin. Maecenas cubilia eu hendrerit vestibulum inceptos. Proin dui vitae morbi natoque rutrum hac egestas curae. Efficitur aenean magna vel pellentesque, interdum est ante amet? Aegestas iaculis hac dis tempor leo.",

          "Elementum aptent metus ullamcorper semper nisl felis scelerisque porttitor. Quisque euismod gravida fusce vitae risus auctor risus accumsan ridiculus. Proin malesuada nisl habitant habitasse neque. Aenean inceptos consequat penatibus neque; ex morbi dictumst? Hac mattis iaculis ad aenean sociosqu cras ut tempor felis. Congue sem suspendisse posuere sit pulvinar vehicula."
        ],
        dishTypes: {"Salmon Tomato Salad": "assets/images/Salmon Tomato Salad.png", "Avocado, Ham, and Cheese": "assets/images/AHC.png"},
        waterIntake: [
          "Lorem ipsum odor amet, consectetuer adipiscing elit. Potenti luctus vel sodales senectus posuere est ultrices augue. Inceptos vitae eleifend maecenas senectus etiam lacinia tortor. Proin ultrices morbi erat interdum pellentesque condimentum. Hac ut ipsum a dolor morbi nibh ultricies velit. Sagittis habitant mattis habitasse mi amet. Montes finibus convallis, faucibus cras morbi phasellus rutrum. Sapien ridiculus elementum massa ante blandit penatibus lacus. Lectus tristique himenaeos class curabitur lectus nibh.",

          "Fringilla felis vehicula quam molestie hac; a dui. Eleifend euismod amet fusce ex cubilia in curabitur bibendum. Viverra senectus placerat efficitur proin donec dolor dictum per interdum. Ullamcorper neque bibendum purus iaculis morbi porttitor conubia placerat. Malesuada interdum tellus metus habitasse tristique magna primis. Ut litora nec, dui felis dolor cursus sit vehicula class. Diam cubilia class; fames gravida adipiscing semper fames imperdiet habitant. Hac non nunc per nostra curae. Senectus iaculis aliquam semper magna nascetur nascetur congue ut.",

        ]
    )
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
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  // Taking the full width of the screen minus the margin
                  child: InkWell(
                    onTap: () {
                      // Handle the tap event
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage()));

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DietPage(dietInfo: diets[index],)));
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
