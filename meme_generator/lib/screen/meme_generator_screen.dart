import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/widgets/button_widget.dart';
import 'package:share_plus/share_plus.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  String memeText = 'Здесь мог бы быть ваш мем';
  String imageUrl =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';

  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );

    void showUrlInputUrlDialog() {
      final controller = TextEditingController();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Please enter image URL:'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  imageUrl = controller.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    Future<void> pickImageFromGallery() async {
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          setState(() {
            imageUrl = pickedFile.path;
          });
        }
      } catch (e) {
        print(e);
      }
    }

    void showImageSourceDialog() {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Pease choose image source:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Button.text(
                text: 'From URL',
                height: 48,
                onTap: () {
                  Navigator.of(context).pop();
                  showUrlInputUrlDialog();
                },
              ),
              Button.text(
                text: 'From Gallery',
                height: 48,
                onTap: () async {
                  Navigator.of(context).pop();
                  await pickImageFromGallery();
                },
              ),
            ],
          ),
        ),
      );
    }

    Future<void> shareImage(Uint8List imageBytes, String imageName) async {
      final xFile =
          XFile.fromData(imageBytes, name: imageName, mimeType: 'image/png');
      await Share.shareXFiles([xFile], text: 'Share meme image');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: () async {
              RenderRepaintBoundary boundary = globalKey.currentContext!
                  .findRenderObject() as RenderRepaintBoundary;
              ui.Image image = await boundary.toImage();
              ByteData byteData = await image.toByteData(
                  format: ui.ImageByteFormat.png) as ByteData;
              Uint8List pngBytes = byteData.buffer.asUint8List();
              await shareImage(pngBytes, 'my_image.png');
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: RepaintBoundary(
          key: globalKey,
          child: ColoredBox(
            color: Colors.black,
            child: DecoratedBox(
              decoration: decoration,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Picture
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: DecoratedBox(
                        decoration: decoration,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: showImageSourceDialog,
                            child: imageUrl != null
                                ? (imageUrl.startsWith('http') ||
                                        imageUrl.startsWith('https'))
                                    ? Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(imageUrl),
                                        fit: BoxFit.cover,
                                      )
                                : Container(),
                          ),
                        ),
                      ),
                    ),

                    // Text
                    GestureDetector(
                      onTap: () {
                        final controller = TextEditingController();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Please enter meme text:'),
                            content: TextField(
                              controller: controller,
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  if (controller.text.trim().isEmpty) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Error: No input provided')));
                                  } else {
                                    setState(() {
                                      memeText = controller.text;
                                    });
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        memeText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Impact',
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
