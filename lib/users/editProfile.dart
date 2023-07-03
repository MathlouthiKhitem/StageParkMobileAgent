import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';




class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String? _username;
  late String? _email;
  late String? _password;
  late String? _birth;
  late String? _address;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        key: _formKey,
        child: ListView(

        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('lib/images/Ellipse.png'),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Handle edit image button press
                    },
                    icon: Icon(
                      IconlyBold.editSquare,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            ),
          ),
            SizedBox(
              height: 30,
            ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF8F7FD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Color(0xFF999CF0)),
                ),
                labelText: "Full Name",
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF8F7FD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Color(0xFF999CF0)),
                ),
                labelText: "Email",
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF8F7FD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Color(0xFF999CF0)),
                ),
                labelText: "NickName",
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF8F7FD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Color(0xFF999CF0)),
                ),
                labelText: "Date of Birth",
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF8F7FD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Color(0xFF999CF0)),
                ),
                labelText: "Phone Number",
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF8F7FD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Color(0xFF999CF0)),
                ),
                labelText: "Gendre",
              ),

            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 30),

              // width: 348,
              // height: 50,
              child: SizedBox(
                width: 348,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF999CF0), // Set the background color
                    // Set the text color
                  ),
                  child: const Text("Edit"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                    }
                  },
                ),
              )
          ),
          ],
        ),
      ),
    );
  }
}

