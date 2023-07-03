import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../components/SquareTile.dart';
import 'creatNewPassword.dart';


class CodeVerfication extends StatefulWidget {
  const CodeVerfication({Key? key}) : super(key: key);

  @override
  State<CodeVerfication> createState() => _codeVerficationState();
}

class _codeVerficationState extends State<CodeVerfication> {

  late String? _email;
  late String? _password;



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:ListView(
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


          Container(

            margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80,),
                const Text("Entre the verfivation code send at support 55789... ",textAlign: TextAlign.center,),
                const SizedBox(height: 30,),

                OtpTextField(
                  numberOfFields: 5,
                  borderColor: Color(0xFF512DA8),
                  fillColor: Color(0xFF999CF0).withOpacity(0.1),
                  filled: true,
                  showFieldAsBox: true,

                  //runs when every textfield is filled
                  onSubmit: (String verificationCode){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        }
                    );
                  },
                  // end onSubmit
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(

                  width: double.infinity,
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF999CF0), // Set the background color
                      // Set the text color
                    ),
                    child: const Text("Next"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreatNewPassword()),
                      );

                    },
                  ),
                )
              ],
            ),
          ),
        ],
      )


    );
  }
}
