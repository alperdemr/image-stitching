import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'images_stitch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _imagesStitch = ImagesStitch();
  final ImagePicker _picker = ImagePicker();
  String? _imagePathToShow = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              InkWell(
                child: const Text('Click here'),
                onTap: () async {
                  final imageFiles = await _picker.pickMultiImage();
                  final imagePaths = imageFiles.map((imageFile) {
                    return imageFile.path;
                  }).toList();
                  String dirPath =
                      "${(await getApplicationDocumentsDirectory()).path}/${DateTime.now()}_.jpg";
                  _imagesStitch.stitchImages(
                    imagePaths,
                    dirPath,
                    false,
                    (stitchedImagesPath) {
                      setState(() {
                        _imagePathToShow = dirPath;
                      });
                    },
                  );
                },
              ),
              Image.file(
                File(_imagePathToShow ?? "")
              )
            ],
          ),
        ),
      ),
    );
  }
}
