import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:nu_parent/child_dashboard.dart';
import 'package:nu_parent/main.dart';
import 'package:nu_parent/registration_screen.dart';
import 'package:nu_parent/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool _obscureText = true;
  bool _isChecked = false;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.asset('assets/TeethFamily.jpg',
                  height: 400, fit: BoxFit.fill),
            ),
            Positioned(
                top: 20,
                left: 90,
                child: ClipOval(
                    child: Image.asset(
                  'assets/nuParent.png',
                  width: 100,
                  height: 100,
                ))),
          ],
        ),
        Expanded(
          child: Form(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Email Address',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 25.0),
                      filled: true,
                      fillColor: const Color.fromARGB(31, 121, 120, 120),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 25.0),
                        child: Icon(Icons.lock),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 25.0),
                    filled: true,
                    fillColor: const Color.fromARGB(31, 121, 120, 120),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordVisibility,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: AppColors.primaryColor,
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          const Text('Keep Me Logged In')
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Forget Password!');
                        },
                        child: const Text(
                          'Forget Password ?',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationScreen()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChildDashboard()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 30, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding:
                              const EdgeInsets.fromLTRB(130.0, 15, 130.0, 15),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.black,
                          thickness: .5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                        child: Text('OR'),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.black,
                          thickness: .5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: SignInButton(
                        Buttons.Google,
                        padding: const EdgeInsets.fromLTRB(40.0, 10, 40.0, 10),
                        text: "Sign in with Google",
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () =>AuthService().signInWithGoogle(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
      ]),
    );
  }
}
