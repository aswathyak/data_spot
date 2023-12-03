import 'package:dataspot_project/feature/registeration/registeration_page.dart';
import 'package:dataspot_project/feature/resource/common/common_text_form_field.dart';
import 'package:dataspot_project/feature/users/users_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // late String _email, _password;
  Future<void> _login() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UsersScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          print('Invalid email or password.');
        }
      } catch (e) {
        print(e);
      }
    }

    //   void _login() async {
    //   if (_formKey.currentState!.validate()) {
    //     _formKey.currentState!.save();
    //     try {
    //       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    //         email: _email,
    //         password: _password,
    //       );

    //       // After successful login, navigate to a new page or perform any action
    //       // For example, navigate to a home page
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => UsersScreen()),
    //       );
    //     } catch (e) {
    //       print('Error logging in: $e');
    //       // Handle login errors here
    //     }
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 16,
              ),
              CommonInputTextFormField(
                labelText: "Username/Email ID",
                controller: emailController,
                hintText: "Enter username or email ID",
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Regular expression for email validation
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onChanged: (value){
                  emailController.text = value;
                },
                
              ),
              const SizedBox(
                height: 16,
              ),
              CommonInputTextFormField.password(
                labelText: "Password",
                controller: passwordController,
                hintText: "Enter password",
                keyboardType: TextInputType.visiblePassword,
                sufixIcon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey.shade400,
                ),
                validator: (value) {
                  if (value == null || value == '' || value.length < 6) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                onChanged: (value){
                  passwordController.text = value;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 82, 91),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                    ),
                    onPressed: () {
                      if (loginFormKey.currentState!.validate() == true) {
                        _login();
                      } else {}
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16),
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not registered yet ? ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterationScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Create an account",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
              // RichText(
              //   text: const TextSpan(
              //     text: "Not registered yet ? ",
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600),
              //     children: [
              //       TextSpan(
              //           text: "Create an account",
              //           style: TextStyle(
              //               color: Colors.blue,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w600)),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
