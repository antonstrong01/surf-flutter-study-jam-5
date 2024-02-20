import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/cubit/template_cubit.dart';
import 'package:meme_generator/screen/templates_screen.dart';
import 'package:meme_generator/widgets/button_widget.dart';
import 'package:meme_generator/widgets/meme_body_widget.dart';
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

    return BlocBuilder<TemplateCubit, int>(
      builder: (context, selectedTemplate) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.send),
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
          drawer: const Drawer(
            child: TempatesScreen(),
          ),
          body: MemeBodyWidget(
            globalKey: globalKey,
            decoration: decoration,
            showImageSourceDialog: showImageSourceDialog,
            imageUrl: imageUrl,
            memeText: memeText,
            selectedTemplate: selectedTemplate,
            setText: (text) {
              setState(() {
                memeText = text;
              });
            },
          ),
        );
      },
    );
  }
}
