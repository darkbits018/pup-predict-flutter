import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

import 'VideoScreen.dart';

// class ClassificationScreen extends StatelessWidget {
//   final String prediction;
//
//
//   ClassificationScreen({required this.prediction});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Classification Result'),
//       ),
//       body: Center(
//         child: Text(prediction),
//       ),
//     );
//   }
// }
//
// TRY 2
// class ClassificationScreen extends StatelessWidget {
//   final String prediction;
//   final Uint8List imageBytes; // Add this field to hold the image data
//   // final Map<String, dynamic> responseData;
//
//   ClassificationScreen({required this.prediction, required this.imageBytes, required Map<String, dynamic> responseData});
//
//
//   @override
//   Widget build(BuildContext context) {
//     // String prediction = responseData['prediction'];
//     // double confidence = responseData['confidence'];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Classification Result'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Image.memory(imageBytes,
//             width: 200, // Set the desired width
//             height: 200, // Set the desired height
//           ), // Display the image
//           SizedBox(height: 16),
//           Text('Prediction: $prediction'),
//         ],
//       ),
//     );
//   }
// }

// FORMATING JSON
// class ClassificationScreen extends StatelessWidget {
//   final String prediction;
//   final double confidence;
//   final String objectDescription;
//   final Uint8List imageBytes;
//
//   ClassificationScreen({
//     required this.prediction,
//     required this.confidence,
//     required this.objectDescription,
//     required this.imageBytes, required Map<String, dynamic> responseData,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Classification Result'),
//         backgroundColor: Color(0xFFA063EF),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/background-classi.jpg'), // Replace with your image file path
//             fit: BoxFit.cover, // Adjust as needed
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.memory(
//               imageBytes,
//               width: 500,
//               height: 500,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Prediction: $prediction',
//               style: TextStyle(
//                 color: Colors.white, // Text color
//                 fontSize: 20, // Font size
//               ),
//             ),
//             Text(
//               'Confidence: $confidence',
//               style: TextStyle(
//                 color: Colors.white, // Text color
//                 fontSize: 20, // Font size
//               ),
//             ),
//             // Text('Object Description: $objectDescription'),
//             // Text('Image Caption: $imageCaption'),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => VideoScreen(searchQuery: prediction)),
//                 );
//               },
//               child: Text("View Videos"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFFA063EF)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//DOG INFO API
class ClassificationScreen extends StatelessWidget {
  final String prediction;
  final double confidence;
  final Map<String, dynamic> classInfo;
  final Uint8List imageBytes;

  ClassificationScreen({
    required this.prediction,
    required this.confidence,
    required this.classInfo,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> propertyWidgets = [];
    int goodWithOtherDogs = classInfo['good_with_other_dogs'] ?? 0;
    int goodWithOtherchild = classInfo['good_with_children'] ?? 0;
    int shedding = classInfo['shedding'] ?? 0;
    int grooming = classInfo['grooming'] ?? 0;
    int drooling = classInfo['drooling'] ?? 0;
    int goodWithStrangers = classInfo['good_with_strangers'] ?? 0;
    int playfulness = classInfo['playfulness'] ?? 0;
    int protectiveness = classInfo['protectiveness'] ?? 0;
    int trainability = classInfo['trainability'] ?? 0;
    int energy = classInfo['energy'] ?? 0;
    int barking = classInfo['barking'] ?? 0;
    double minlife = classInfo['min_life_expectancy'] ?? 0;
    double maxlife = classInfo['max_life_expectancy'] ?? 0;
    double heightm = classInfo['max_height_male'] ?? 0;
    double heightf = classInfo['max_height_female'] ?? 0;
    double weightm = classInfo['max_weight_male'] ?? 0;
    double weightf = classInfo['max_weight_female'] ?? 0;


    // Iterate over the properties in classInfo
    classInfo.entries.forEach((entry) {
      propertyWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.key}:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              entry.value.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Classification Result'),
        backgroundColor: Color(0xFFA063EF),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background-classi.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align texts to the left
            children: <Widget>[
              Image.memory(
                imageBytes,
                width: 500,
                height: 500,
              ),
              SizedBox(height: 14),
              Text(
                'Prediction: $prediction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Confidence: $confidence',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 30),
              // Display all properties separately
              // ...propertyWidgets,
              Text(
                'Good With Children: $goodWithOtherchild',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Good With Other Dogs: $goodWithOtherDogs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Shedding: $shedding',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Grooming: $grooming',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Drooling: $drooling',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Playfulness: $playfulness',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Protectiveness: $protectiveness',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Trainability: $trainability',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Energy: $energy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Barking: $barking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Min life: $minlife',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Max life: $maxlife',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Max Height (M): $heightm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Max Height (F): $heightf',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Max Weight (M): $weightm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Max Weight (F): $weightf',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VideoScreen(searchQuery: prediction),
                    ),
                  );
                },
                child: Text("View Videos"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA063EF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
