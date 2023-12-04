import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invotask/Auth/otp.dart';
import 'package:invotask/constant.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});
  static String verifycode = "";
  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String phoneno = "";
  late String logoimg;
  final storage = FirebaseStorage.instance;
  @override
  void initState() {
    super.initState();
    logoimg = "";
    getimgurl();
  }

  Future<void> getimgurl() async {
    // Get the  ref of img
    final ref = storage.ref().child('appimage/logo.jpg');
    final url = await ref.getDownloadURL();
    setState(() {
      logoimg = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Positioned(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: logoimg == ""
                        ? const Center(child: CircularProgressIndicator())
                        : Image(
                            image: NetworkImage(logoimg),
                            fit: BoxFit.cover,
                          )),
              ),
              Positioned(
                  top: 20,
                  right: 20,
                  child: TextButton(
                    onPressed: () => Get.to(OtpScreen(
                      logoimg: logoimg,
                     
                    )),
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.red),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              children: [
                Positioned(
                    left: 100,
                    right: 100,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 1),
                            BoxShadow(color: Colors.white, offset: Offset(0, 0))
                          ]),
                      child: const Icon(Icons.person),
                    )),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40, left: 20, right: 20, bottom: 20),
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 70),
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 220, 220)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              phoneno = value;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: "Enter Mobile Number",
                                suffixIcon: Icon(
                                  Icons.phone_in_talk_outlined,
                                  color: Colors.grey.shade400,
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minWidth: MediaQuery.of(context).size.width,
                            color: Appcolor.maincolor,
                            onPressed: verifyno,
                            child: const Text(
                              "CONTINUE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "By continuing you are agree to our",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: "Terms & Conditions ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 6, 127, 157))),
                            TextSpan(
                                text: "and ",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 6, 127, 157))),
                          ]))
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 100,
                    right: 100,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 1),
                            BoxShadow(color: Colors.white, offset: Offset(0, 0))
                          ]),
                      child: const Icon(Icons.person),
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void verifyno() async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: '+91 $phoneno',
                                verificationCompleted:
                                    (PhoneAuthCredential credential)async {
  //                                      await FirebaseAuth.instance.signInWithCredential(credential).then(
  //     (value) => print('Logged In Successfully'),
  // );
                                    },
                                verificationFailed:
                                    (FirebaseAuthException e) {
                                       print(e.message);
                                    },
                                codeSent: (String verificationId,
                                    int? resendToken) {
                                  PhoneAuthScreen.verifycode = verificationId;
                                  Get.to(() => OtpScreen(logoimg: logoimg, ));
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                                timeout: const Duration(seconds: 120));
                          }
}
