import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase123/home.dart';
import 'package:firebase123/login.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _SignupState();
}

class _SignupState extends State<signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailText = "Email";
  String passwordText = "Password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign Up Screen')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 250,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: emailText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            emailText = '';
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: passwordText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            passwordText = '';
                          });
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        userSignup();
                      },
                      child: const Text("Sign Up")),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  userSignup() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
