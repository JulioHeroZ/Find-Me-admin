// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:file_picker/file_picker.dart';
import 'package:find_me_admin/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CategoryScreen extends StatefulWidget {
  static const String id = 'category';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FirebaseService _service = FirebaseService();
  final TextEditingController _catName = TextEditingController();
  dynamic image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    } else {
      print('inserção de imagem cancelada');
    }
  }

  saveImageToDb() async {
    EasyLoading.show();
    var ref = firebase_storage.FirebaseStorage.instance
        .ref('categoryImage/$fileName');
    try {
      await ref.putData(image);
      String downloadUrl = await ref.getDownloadURL().then((value) {
        if (value.isNotEmpty) {
          _service.saveCategory({
            'catName': _catName.text,
            'image': value,
            'active': true
          }).then((value) {
            clear();
            EasyLoading.dismiss();
          });
        }
        return value;
      });
    } on FirebaseException catch (e) {
      clear();
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  clear() {
    setState(() {
      _catName.clear();
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text(
              'Category Screen',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    child: Center(
                      child: image == null
                          ? Text(
                              'Category Image',
                            )
                          : Image.memory(image),
                    )),
                SizedBox(height: 10),
                ElevatedButton(
                    child: Text('Upload Image'), onPressed: pickImage),
              ],
            ),
            SizedBox(width: 20),
            Container(
              width: 200,
              child: TextField(
                controller: _catName,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  side: MaterialStateProperty.all(BorderSide(
                    color: Theme.of(context).primaryColor,
                  )),
                )),
            SizedBox(width: 10),
            TextButton(
              onPressed: saveImageToDb,
              child: Text(
                'Save',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Lista de categorias',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 26,
            ),
          ),
        ),
      ],
    );
  }
}
