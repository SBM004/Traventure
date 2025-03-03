import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editprofile.dart'; // Import the EditProfile page

class ProfilePage extends StatefulWidget {
  final String? userId;

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>?> userData;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      userData = fetchUserData(widget.userId!);
    } else {
      userData = Future.value(null);
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('userlogin')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        return null; // No data found
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/AppHS.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Color(0xFF315E3C),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFFDCD0A1)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text(
                      'PROFILE',
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 28,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FutureBuilder<Map<String, dynamic>?>(
                          future: userData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error fetching data');
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return Text('No user data found');
                            } else {
                              var data = snapshot.data!;
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    // Profile Image
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: data['imageUrl'] != null
                                          ? NetworkImage(data['imageUrl']) // Use the fetched image URL
                                          : null,
                                      backgroundColor: Colors.grey[300],
                                      child: data['imageUrl'] == null
                                          ? Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.black,
                                      )
                                          : null,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'USER-ID: ${widget.userId}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Arial',
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Details:',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Arial',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF235537),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    _buildDetailRow(Icons.person, data['name'] ?? 'No name'),
                                    _buildDetailRow(Icons.phone, data['phone'] ?? 'No phone'),
                                    _buildDetailRow(Icons.perm_identity, data['aadhaar'] ?? 'No AID'),
                                    _buildDetailRow(
                                      Icons.location_on,
                                      data['address'] ?? 'No address',
                                    ),
                                    _buildDetailRow(Icons.email, data['email'] ?? 'No email'),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditProfile(userId: widget.userId),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF315F3C),
                                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        'EDIT',
                                        style: TextStyle(
                                          color: Color(0xFFFDEAB2),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 26,
            color: Colors.black,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              detail,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
