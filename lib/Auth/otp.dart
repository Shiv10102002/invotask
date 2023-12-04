import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invotask/Auth/phone.dart';
import 'package:invotask/Screen/hometabbar.dart';
import 'package:invotask/constant.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String logoimg;

  const OtpScreen({
    super.key,
    required this.logoimg,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    const defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
      ))
          // borderRadius: BorderRadius.circular(20),
          ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(bottom: BorderSide(color: Appcolor.maincolor)),
      // borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    String smscode = "";
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
                    child: Image(
                      image: NetworkImage(widget.logoimg),
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                  top: 20,
                  right: 20,
                  child: TextButton(
                    onPressed: () => Get.to(const Home()),
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
                          const EdgeInsets.only(left: 20, right: 20, top: 60),
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 220, 220)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Pinput(
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              showCursor: true,
                              onChanged: (value) {
                                smscode = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              height: 40,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minWidth: MediaQuery.of(context).size.width,
                              color: Appcolor.maincolor,
                              onPressed: () async {
                                // Create a PhoneAuthCredential with the code

                                try {
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                    verificationId: PhoneAuthScreen.verifycode,
                                    smsCode: smscode,
                                  );
                                  await auth
                                      .signInWithCredential(credential)
                                      .then((value) => Get.to(() => Home()));
                                } catch (e) {
                                  Get.snackbar(
                                      "Authentication failed", e.toString(),
                                      backgroundColor: Appcolor.maincolor);
                                }
                              },
                              child: const Text(
                                "CONTINUE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.lock), Icon(Icons.password)],
                      ),
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
