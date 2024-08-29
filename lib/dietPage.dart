import 'package:flutter/material.dart';
import 'package:smartflask/components/colorPalette.dart';
import 'package:smartflask/explorePage.dart';

class DietPage extends StatelessWidget {
  final Diet dietInfo;
  const DietPage({super.key, required this.dietInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        elevation: 2,
        title: Text('title')
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${dietInfo.name}',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10,),
                Text('${dietInfo.description}',
                style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10,),
                Text('Recommended Dishes',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dietInfo.dishTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, String> item = dietInfo.dishTypes;
                      return Container(
                        width: 250, // Taking the full width of the screen minus the margin
                        child: InkWell(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => DietPage(dietInfo: diets[index],)));
                            // Handle the tap event
                           // print('Card tapped: ${item.title}');
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias, // This ensures that the image is clipped to the card's boundaries
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  item.values.elementAt(index),
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
                                          item.keys.elementAt(index),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
                Text("Water Intake",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                ),
                Text("${dietInfo.waterIntake}",style: TextStyle(fontSize: 24),)

              ],
          ),
        ),
      )
    );
  }
}
