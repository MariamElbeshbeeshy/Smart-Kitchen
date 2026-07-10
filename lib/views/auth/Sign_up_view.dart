import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_kitchen/views/navigation_view.dart';
import 'Login_veiw.dart';
import 'package:smart_kitchen/widgets/customTextfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    if (passwordController.text.trim() !=
        confirmController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account Created Successfully"),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationView(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;

        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;

        case 'invalid-email':
          message = 'Invalid email address.';
          break;

        default:
          message = e.message ?? 'Registration failed.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<UserCredential?> signUpWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final GoogleSignInAccount? googleUser =
          await googleSignIn.authenticate();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 50),

              Image.asset(
                "assets/images/logo.png",
                height: 103,
                width: 107,
              ),

              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Kitchen",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F6B4E),
                      ),
                    ),
                    TextSpan(
                      text: "ly",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Create An Account!",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w500,
                ),
              ),              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFormFeild(
                  controller: emailController,
                  hintText: "Email Address",
                  isPassword: false,
                  isHidden: false,
                  onToggleVisibility: () {},
                  prefixIcon: SvgPicture.asset(
                    "assets/images/email.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFormFeild(
                  controller: passwordController,
                  hintText: "Password",
                  isPassword: true,
                  isHidden: isPasswordHidden,
                  onToggleVisibility: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  prefixIcon: SvgPicture.asset(
                    "assets/images/password.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFormFeild(
                  controller: confirmController,
                  hintText: "Confirm Password",
                  isPassword: true,
                  isHidden: isConfirmHidden,
                  onToggleVisibility: () {
                    setState(() {
                      isConfirmHidden = !isConfirmHidden;
                    });
                  },
                  prefixIcon: SvgPicture.asset(
                    "assets/images/confirmpassword.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: 325,
                height: 58,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFF605C5C),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR"),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFF605C5C),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 325,
                height: 58,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await signUpWithGoogle();

                      if (user == null) return;

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Google Sign Up Successfully",
                          ),
                        ),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationView(),
                        ),
                      );
                    } catch (e) {
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2,
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google_icon.png",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Sign Up with Google",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account ? ",
                    style: TextStyle(
                      color: Color(0xFF605C5C),
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}