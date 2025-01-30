import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:zubi/constants.dart';
import 'package:zubi/views/screens/auth/GoogleSignInScreen.dart';
import 'package:zubi/views/screens/auth/login_screen.dart';
import 'package:zubi/views/screens/videos/customized_homepage.dart';
import 'package:zubi/views/screens/videos/custompage.dart';
import 'package:zubi/views/widgets/text_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              //       child: Image.asset(
              // 'assets/images/ZubiLogo.png', // Logo image
              //   height: 150,
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //     Text(
                  //   "Zubi",
                  //   style: TextStyle(
                  //     fontSize: 35,
                  //     color: buttonColor,
                  //     fontWeight: FontWeight.w900
                  //   ),
                  // ),

                  const SizedBox(height: 25),

                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                        backgroundColor: Colors.black,
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            onPressed: () => {}
                            // authController.pickImage(),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _usernameController,
                      labelText: "Username",
                      hintText: "John Doe",
                      icon: Icons.person,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _emailController,
                      labelText: "Enter Your Email Id",
                      hintText: "johndoe@gmail.com",
                      icon: Icons.email,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _phoneNumberController,
                      labelText: "Enter Your Phone number",
                      hintText: "+255799899566",
                      icon: Icons.phone,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _passwordController,
                      labelText: "Enter Password",
                      hintText: "",
                      isObsecure: true,
                      icon: Icons.lock,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: InkWell(
                        // onTap: () =>
                        //     authController.registerUser(
                        //   _usernameController.text,
                        //   _emailController.text,
                        //   _phoneNumberController.text,
                        //   _passwordController.text,
                        //   authController.ProfilePhoto,
                        // ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        ),
                        // },
                        child: const Text("Register",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already Have an Account? ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const CustomPageScreen()),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20, color: buttonColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Or",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Sign in with Google
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign Up with Google",
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const GoogleSignInScreen()));
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: SignInButton(Buttons.Facebook,
                        text: "Sign up With Facebook", onPressed: () {}),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
