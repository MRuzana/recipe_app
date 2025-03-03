import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipe_app/core/constants/spacing_constants.dart';
import 'package:receipe_app/core/utils/validator.dart';
import 'package:receipe_app/view/widgets/button_widget.dart';
import 'package:receipe_app/view/widgets/cooking_instr.dart';
import 'package:receipe_app/view/widgets/drop_down_widget.dart';
import 'package:receipe_app/view/widgets/ingredients_list.dart';
import 'package:receipe_app/view/widgets/text_form_widget.dart';

class CookIt extends StatefulWidget {
  const CookIt({super.key});

  @override
  State<CookIt> createState() => _CookItState();
}

class _CookItState extends State<CookIt> {
  final _formKey = GlobalKey<FormState>();
  final _receipeNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();

  String selectedValue = '';
  final ImagePicker _imagePicker = ImagePicker();
  File? pickedImage;
  late XFile? pickedFile;
  PlatformFile? _imagefile;
  FilePickerResult? result;
  List<String> _ingredientsList = [];
  List<String> _instructionsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xffC8B6B6),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Receipe',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: kpadding15,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      _showImagePickerOptions();
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipRRect(
                        child: kIsWeb
                            ? _imagefile != null
                                ? Image.memory(
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    Uint8List.fromList(_imagefile!.bytes!))
                                : Icon(Icons.cloud_upload_outlined,
                                    color: Colors.red, size: 100)
                            : pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.cloud_upload_outlined,
                                    color: Colors.red, size: 100),
                      ),
                    ),
                  ),

                  kHeight20,

                  // recipe name
                  textField(
                    controller: _receipeNameController,
                    keyboardType: TextInputType.name,
                    labelText: 'Item name',
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) => Validator.validateUsername(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  kHeight10,

                  // description
                  textField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: null,
                    labelText: 'Description',
                    prefixIcon: const Icon(Icons.description),
                    validator: (value) => Validator.validateUsername(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  kHeight10,

                  //preperation time
                  textField(
                    controller: _timeController,
                    keyboardType: TextInputType.number,
                    labelText: 'Preperation time in min ',
                    prefixIcon: const Icon(Icons.alarm),
                    validator: (value) => Validator.validateTime(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  kHeight10,

                  // //ingredients list
                  IngredientsList(
                    onIngredientsUpdated: (updatedList) {
                      setState(() {
                        _ingredientsList = updatedList;
                      });
                    },
                  ),
                  kHeight10,
                  // instructions list
                  CookingInstructions(
                    onInstructionsUpdated: (updatedList) {
                      setState(() {
                        _instructionsList = updatedList;
                      });
                    },
                  ),
                  kHeight10,
                  DropdownWidget(
                    onItemSelected: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  kHeight20,
                  button(
                      buttonText: 'SUBMIT',
                      color: Colors.red,
                      buttonPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _uploadRecipe();
                        }
                      }),
                ],
              ),
            )),
      )),
    );
  }

  Future<void> _uploadRecipe() async {
    if (pickedImage == null && _imagefile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image.')),
      );
      return;
    }

    try {
      String base64Image = '';

      // Convert image to Base64 based on platform
      if (kIsWeb && _imagefile != null) {
        base64Image = base64Encode(_imagefile!.bytes!);
      } else if (!kIsWeb && pickedImage != null) {
        List<int> imageBytes = await pickedImage!.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      // Upload recipe to Firestore
      await FirebaseFirestore.instance.collection('recipes').add({
        'name': _receipeNameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'preparationTime': _timeController.text.trim(),
        'ingredients': _ingredientsList,
        'instructions': _instructionsList,
        'category': selectedValue.trim(),
        'image': base64Image, // Storing as Base64
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recipe uploaded successfully!')));

      // Clear fields
      _receipeNameController.clear();
      _descriptionController.clear();
      _timeController.clear();
      _ingredientsList.clear();
      _instructionsList.clear();
      selectedValue = '';

      setState(() {
        pickedImage = null;
        _imagefile = null;
        _ingredientsList = [];
        _instructionsList = [];
        selectedValue = '';
      });
    } catch (e) {
      print('Upload error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload: $e')));
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a photo'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from gallery'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
    }
  }
}
