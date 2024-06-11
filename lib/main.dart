import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'VideoScreen.dart';
import 'classification_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Dog Breed Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'), // Replace with your image file path
              fit: BoxFit.cover, // Adjust as needed
            ),
          ),
          child: MyHomePage(), // You need to place the child widget inside the Container
        ),
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {
  Uint8List? imageBytes;

  Future<void> _captureImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      File imageFile = File(image.path);
      Uint8List imageBytes = await imageFile.readAsBytes();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('NGROK-URL/process_image'), // Replace with Flask app's endpoint
      );

      request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image sent successfully');
      } else {
        print('Image sending failed with status code ${response.statusCode}');
      }
      _fetchAndDisplayClassification(context, imageBytes);
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);
      Uint8List imageBytes = await imageFile.readAsBytes();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('NGROK-URL/process_image'), // Replace with your Flask app's endpoint
      );

      request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image sent successfully');
      } else {
        print('Image sending failed with status code ${response.statusCode}');
      }
      _fetchAndDisplayClassification(context, imageBytes);
    }
  }

  Future<void> _fetchAndDisplayClassification(BuildContext context, Uint8List imageBytes) async {
    final Uri uri = Uri.parse('NGROK-URL/get_response');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      String classification = responseData['class'] ?? '';
      double confidence = responseData['confidence_score'] ?? 0.0;
      // Fetch class_info from the response
      List<dynamic> classInfoList = responseData['class_info'];
      Map<String, dynamic> classInfo = classInfoList.isNotEmpty ? classInfoList[0] : {};

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClassificationScreen(
            prediction: classification,
            imageBytes: imageBytes,
            // responseData: responseData,
            confidence: confidence,
            // objectDescription: description,
            classInfo: classInfo,
            // Update or remove imageCaption as needed
            // imageCaption: imageCaption,
          ),
        ),
      );
    } else {
      print('Failed to fetch classification');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pup-Predict'),
        backgroundColor: Color(0xFFA063EF),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Replace with your image file path
            fit: BoxFit.cover, // Adjust as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _captureImage(context),
                child: Text('Capture Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA063EF), // Set the button background color
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _pickImage(context),
                child: Text('Pick Image from Gallery'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA063EF), // Set the button background color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
