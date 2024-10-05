import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool isLoading = false;
  String error = '';

  void createAccount() async {
    setState(() {
      isLoading = true;
      error = 'loading';
    });
    String phone = phoneController.text.trim();
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      setState(() {
        isLoading = false;
        error = "Please fill all the details!";
      });
    } else if (password != cPassword) {
      setState(() {
        isLoading = false;
        error = "Passwords do not match!";
      });
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        users.doc(userCredential.user?.uid).set({
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'balance': 0,
        }).then((value) {
          setState(() {
            isLoading = false;
          });
        }).catchError((error) {
          log("Failed to add user: $error");
        });
      } on FirebaseException catch (ex) {
        log(ex.code.toString());
        setState(() {
          isLoading = false;
          error = ex.message ?? 'An error occurred';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create an account"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Centered Lottie animation
            Align(
              alignment: Alignment.topCenter,
              child: Lottie.asset(
                'assets/animations/signup.json', // Add your Lottie animation file in the assets folder
                // width: MediaQuery.of(context).size.width/2,
                width: 500,
                // height: MediaQuery.of(context).size.height/2,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      // Glassmorphic effect
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.75,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: "Phone Number",
                                      prefix: const Text("+91 "),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: cPasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  if (isLoading)
                                    const CircularProgressIndicator()
                                  else
                                    CupertinoButton(
                                      onPressed: () {
                                        createAccount();
                                      },
                                      color: Colors.blue,
                                      child: Text("Create Account"),
                                    ),
                                  SizedBox(height: 30),
                                  Text(
                                    error,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
