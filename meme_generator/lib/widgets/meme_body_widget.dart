import 'package:flutter/material.dart';
import 'package:meme_generator/widgets/meme_template_1_widget.dart';
import 'package:meme_generator/widgets/meme_template_2_widget.dart';

class MemeBodyWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final BoxDecoration decoration;
  final Function showImageSourceDialog;
  final String? imageUrl;
  final String memeText;
  final Function setText;
  final int selectedTemplate;

  const MemeBodyWidget({
    super.key,
    required this.globalKey,
    required this.decoration,
    required this.showImageSourceDialog,
    required this.imageUrl,
    required this.memeText,
    required this.setText,
    required this.selectedTemplate,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
              child: selectedTemplate == 1
                  ? Template1(
                      decoration: decoration,
                      showImageSourceDialog: showImageSourceDialog,
                      imageUrl: imageUrl,
                      memeText: memeText,
                      setText: setText,
                    )
                  : Template2(
                      decoration: decoration,
                      showImageSourceDialog: showImageSourceDialog,
                      imageUrl: imageUrl,
                      memeText: memeText,
                      setText: setText,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
