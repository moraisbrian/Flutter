import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: getFromCamera,
              child: const Text('Câmera'),
            ),
            TextButton(
              onPressed: getFromGallery,
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.bottomCenter,
        child: CupertinoActionSheet(
          title: const Text('Selecionar foto para o anúncio'),
          message: const Text('Escolha a origem da foto'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: Navigator.of(context).pop,
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: getFromCamera,
              child: const Text('Câmera'),
            ),
            CupertinoActionSheetAction(
              onPressed: getFromGallery,
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> getFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    final image = File(pickedFile!.path);
    imageSelected(image);
  }

  Future<void> getFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    final image = File(pickedFile!.path);
    imageSelected(image);
  }

  void imageSelected(File image) {
    print(image.path);
  }
}
