// ignore_for_file: sort_child_properties_last

import 'package:country_calling_code_picker/picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:untitled12/Home.dart';
import 'package:untitled12/all.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController(text: "");
  String latestCountryCode = "+91";
  Country? _selectedCountry;
  var phone = "";
  var sms = "";
  String? verify ;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void _showCountryPicker() async {
    final country = await showCountryPickerDialog(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
        latestCountryCode = _selectedCountry!.callingCode.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 60,
                ),
                Image.asset(
                  'assets/new2.png',
                  height: MediaQuery.of(context).size.height - 550,
                  width: MediaQuery.of(context).size.width - 100,
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _showCountryPicker();
                      },
                      child: Text(
                        latestCountryCode,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                    Container(
                      width: 1,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        controller: phoneController,
                        decoration: InputDecoration(
                            label: Text('Phone Number'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                      child: InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:
                            '${latestCountryCode}${phoneController.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          verify = verificationId;
                          print("Login.verify::${verify}");
                          setState(() {});
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text(
                      'Send OTP',
                      style: TextStyle(
                          color: AppColors.Color2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  height: 60,
                  width: MediaQuery.of(context).size.width - 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.Color1),
                ),
                SizedBox(
                  height: 40,
                ),
                verify==null?SizedBox():        OTPTextField(
                  onChanged: (value) {
                    sms = value;
                  },
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 45,
                  keyboardType: TextInputType.number,
                  outlineBorderRadius: 30,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                verify==null?SizedBox():  Container(
                  child: Center(
                      child: InkWell(
                    onTap: () async {
                      print(verify);
                      print("Login.verify::${verify}");
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verify!.toString(), smsCode: sms);

                        await auth.signInWithCredential(credential);
                        LocalDataSaver.setUserLogin(true);
                        LocalDataSaver.setUserId(auth.currentUser!.uid.toString());
                        LocalDataSaver.setUserPhone(
                            auth.currentUser!.phoneNumber.toString());
                        LocalDataSaver.setphoto(auth.currentUser!.photoURL.toString());
                        await getUserDetails();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                      } catch (e) {
                        print('Wrong otp::$e');
                        print('Wrong otp');
                        Fluttertoast.showToast(msg: "Please enter correct OTP");
                      }
                    },
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                          color: AppColors.Color2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  height: 60,
                  width: MediaQuery.of(context).size.width - 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.Color1),
                ),
              ]),
            )));
  }
}
