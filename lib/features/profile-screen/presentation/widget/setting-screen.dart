import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}
class _SettingScreenState extends State<SettingScreen> {
  File _image;
  final picker = ImagePicker();
  String dropDownValue = 'Select';
  Future _imgFromGallery() async {
    print("image picked");
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }
  Future _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        child: _image == null
                            ? Text('No image')
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Container(
                                      child: Wrap(
                                        children: <Widget>[
                                          ListTile(
                                              leading: Icon(Icons.photo_library),
                                              title: Text('Photo Library'),
                                              onTap: () {
                                                _imgFromGallery();
                                                Navigator.of(context).pop();
                                              }),
                                          ListTile(
                                            leading: Icon(Icons.photo_camera),
                                            title: Text('Camera'),
                                            onTap: () {
                                              _imgFromCamera();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text('Change profile photo')),
                    ],
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Your Name'),
                  ),
                  TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(labelText: 'Your Date of Birth'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    dropdownColor: Colors.blue,
                    value: dropDownValue,
                    onChanged: (newValue) {
                      setState(() {
                        dropDownValue = newValue.toString();
                      });
                    },
                    items: <String>['Select', 'First', 'Second', 'Third', 'Fourth']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Focus Area'),
                      TextButton(onPressed: () {}, child: Text('Sleep >'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Path'),
                      TextButton(onPressed: () {}, child: Text('Self Driven >')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('SAVE')),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}