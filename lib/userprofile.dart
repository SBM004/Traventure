/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'homepage.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UserProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _aadhaarController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isUser = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.of (context).pop();
          }, icon:const Icon( Icons.arrow_back_outlined)),
        title:Text('Create Profile'),
      centerTitle: true,
        backgroundColor: Color(0xFF255A39),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isUser = true;
                          });
                        },
                        child: Text('USER',style: TextStyle(color: Color(0xFFE4D59F),fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isUser ? Color(0xFF4D8C53) : Color(0xFF235537),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 16),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Image picker logic here
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Add Image", style: TextStyle(fontSize: 16, color: Colors.black)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF235537).withOpacity(0.9),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(

                              children: [

                                _buildTextField("NAME", _nameController),
                                _buildTextField("PHONE NO:", _phoneController),
                                _buildTextField("AADHAR NO:", _aadhaarController),
                                _buildTextField("ADDRESS:", _addressController, maxLines: 3),
                                _buildTextField("EMAIL:", _emailController),
                                _buildTextField("PASSWORD:", _passwordController, isPassword: true),


                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('BACK',style:TextStyle(color:Color(
                            0xFF235537),fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: Color(0xFFE4D59F),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Email and password cannot be empty'),
                            ));
                            return;
                          }

                          try {
                            // Firebase Authentication
                            print('Storing guide: ${_nameController.text.trim()}, ${_phoneController.text.trim()}');
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage(selectedSearch:null, userId: userCredential.user?.uid ?? '')
                                ));
                            // Store additional user details in Firestore
                            await FirebaseFirestore.instance.collection('userlogin').doc(userCredential.user?.uid).set({
                              'name': _nameController.text.trim(),
                              'phone': _phoneController.text.trim(),
                              'aadhaar': _aadhaarController.text.trim(),
                              'address': _addressController.text.trim(),
                              'email': email,
                              'isUser': isUser,
                            });
                          } catch (e) {
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error: ${e.toString()}'),
                            ));
                          }
                        },
                        child: Text('SIGN UP', style: TextStyle(color: Color(0xFF235537),fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: Color(0xFFDCD0A1),
                          textStyle: TextStyle(color: Color(0xFF235537)),
                        ),
                      )
                      */
/*ElevatedButton(
                        onPressed: () {
                          // Sign up action here
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text('SIGN UP',style:TextStyle(color:Color(
                            0xFF235537))),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: Color(0xFFDCD0A1),
                          textStyle: TextStyle(color: Color(0xFF235537)),
                        ),
                      ),*//*

                    ],
                  ),

                ],
              ),
            ),


          ),

        ),
      ),

    );


  }

  Widget _buildTextField(String labelText, TextEditingController controller, {bool isPassword = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Color(0xFFF3E5B5).withOpacity(0.8),

          border: OutlineInputBorder(
            borderRadius:  BorderRadius.circular(10)
          ),

        ),
      ),
    );
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main.dart';
import 'homepage.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UserProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _aadhaarController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isUser = true;
  File? _image; // To store the selected image
  final ImagePicker _picker = ImagePicker(); // Image Picker instance
  String? _imageUrl; // To store the image URL from Firebase Storage

  // Method to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Method to upload image to Firebase Storage
  Future<String?> _uploadImage(File image) async {
    try {
      // Create a reference to the location in Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('user_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to the path
      UploadTask uploadTask = storageRef.putFile(image);

      // Get the download URL of the uploaded file
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFFDCD0A1)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title:
        Text(
          'CREATE PROFILE',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 28,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF255A39),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isUser = true;
                          });
                        },
                        child: Text('USER', style: TextStyle(color: Color(0xFFE4D59F), fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isUser ? Color(0xFF255A39) : Color(0xFF255A39),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: _image != null ? FileImage(_image!) : null, // Display selected image
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _pickImage, // Image picker logic
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Add Image", style: TextStyle(fontSize: 16, color: Colors.black)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF235537).withOpacity(0.9),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                _buildTextField("NAME", _nameController),
                                _buildTextField("PHONE NUMBER", _phoneController),
                                _buildTextField("AADHAR NUMBER", _aadhaarController),
                                _buildTextField("ADDRESS", _addressController, maxLines: 3),
                                _buildTextField("EMAIL", _emailController),
                                _buildTextField("PASSWORD", _passwordController, isPassword: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('CANCEL', style: TextStyle(color: Color(0xFF235537), fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: Color(0xFFE4D59F),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          // Email validation (check if it's empty or invalid format)
                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Email and password cannot be empty'),
                            ));
                            return;
                          }
                          // Check if the email is valid by verifying its format
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please enter a valid email address.'),
                            ));
                            return;
                          }
                          // Password validation (minimum 8 characters, contains lowercase, uppercase, special symbol, and number)
                          RegExp passwordRegExp = RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$');
                          if (!passwordRegExp.hasMatch(password)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Password must be at least 8 characters long, include a lowercase letter, an uppercase letter, a number, and a special character.'),
                            ));
                            return;
                          }

                          try {
                            // Check if the email already exists in Firebase Authentication
                            final List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
                            if (signInMethods.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Email already in use. Please use a different email.'),
                              ));
                              return;
                            }

                            // Firebase Authentication
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            // Upload the image to Firebase Storage and get the download URL
                            if (_image != null) {
                              _imageUrl = await _uploadImage(_image!);
                            }

                            // Store additional user details in Firestore
                            await FirebaseFirestore.instance.collection('userlogin').doc(userCredential.user?.uid).set({
                              'name': _nameController.text.trim(),
                              'phone': _phoneController.text.trim(),
                              'aadhaar': _aadhaarController.text.trim(),
                              'address': _addressController.text.trim(),
                              'email': email,
                              'isUser': isUser,
                              'imageUrl': _imageUrl ?? '', // Store image URL
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage(selectedSearch: null, userId: userCredential.user?.uid ?? ''))
                            );
                          } catch (e) {
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error: ${e.toString()}'),
                            ));
                          }
                        },
                        child: Text('SIGN UP', style: TextStyle(color: Color(0xFF235537), fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: Color(0xFFE4D59F),
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, {bool isPassword = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Color(0xFFF3E5B5).withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

