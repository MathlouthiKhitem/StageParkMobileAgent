import 'package:flutter/material.dart';

import '../components/SquareTile.dart';
import 'creatNewPassword.dart';

class MailVerfication extends StatefulWidget {
  const MailVerfication({Key? key}) : super(key: key);

  @override
  State<MailVerfication> createState() => _MailVerficationState();
}

class _MailVerficationState extends State<MailVerfication> {

  late String? _codeemail;



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [


            Container(
                margin: const EdgeInsets.fromLTRB(30, 69, 40, 15),

                child: Image.asset('lib/images/flech.png',)

            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),

                child: Image.asset('lib/images/Forgot password-rafiki 1.png',
                    width: 460, height: 215)
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                  prefixIcon: Icon(Icons.email, color: Color(0xFF9E9E9E)),
                  labelStyle: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 14,
                    fontFamily: "UrbNIST",
                  ),
                ),
                onSaved: (String? value) {
                  _codeemail = value;
                },

              ),
            ),



            SizedBox(
              height: 20,
            ),


            Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 30),

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
                    child: const Text("Next"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreatNewPassword()),
                        );
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
