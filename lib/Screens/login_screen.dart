import 'package:flutter/material.dart';
import 'package:tour_guide_application/Authentication/auth_controller.dart';
import 'package:tour_guide_application/Components/auth_button.dart';
import 'package:tour_guide_application/Interface/interface.dart';
import 'package:tour_guide_application/Screens/signup_screen.dart';
import 'package:tour_guide_application/Components/custom_text_field.dart';
import '../controllers/input_controllers.dart';
// import '../widgets/custom_text_field.dart';
// import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'Login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationController _authController = AuthenticationController();
  final InputControllers inputController = InputControllers();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await _authController
          .signInWithEmailPassword(
            inputController.emailController.text,
            inputController.passwordController.text,
          )
          .then((_) {
            Navigator.of(
              context,
            ).pushReplacement(_elegantRoute(InterfaceScreen()));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Let's Travel you in.",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Discover the World with Every Sign In"),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: inputController.emailController,
                    hintText: "Email or Phone Number",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email or phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: inputController.passwordController,
                    hintText: "Password",
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Forgot password?"),
                    ),
                  ),
                  SizedBox(height: 10),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       // Perform login action
                  //     }
                  //   },
                  //   child: Text("Sign In"),
                  // ),
                  AuthButton(onPressed: _handleLogin, text: "Log In"),
                  SizedBox(height: height * 0.02),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, _elegantRoute(SignUpScreen()));
                    },
                    child: Text("Don't have an account? Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PageRouteBuilder _elegantRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fadeAnimation = Tween<double>(begin: 0, end: 1).animate(animation);
        var scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutExpo),
        );
        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(scale: scaleAnimation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
