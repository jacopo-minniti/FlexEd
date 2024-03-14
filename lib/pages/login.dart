import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/authentication__service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _NewAccountState();
}

class _NewAccountState extends State<Login> {
  var is_sign_up = false;
  final email_controller = TextEditingController();
  final password1_controller = TextEditingController();
  final password2_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationService.instance();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 500,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/purple_background.png'),
                          fit: BoxFit.fill)),
                ),
                const Positioned(
                    top: 110,
                    left: 35,
                    width: 370,
                    child: Image(
                      image: AssetImage('assets/logo_transparent.png'),
                    )),
                const Positioned(
                    height: 320,
                    width: 300,
                    left: 70,
                    top: 240,
                    child: Image(
                      image: AssetImage('assets/girl_computer.png'),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromRGBO(143, 148, 251, 1)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color:
                                          Color.fromRGBO(143, 148, 251, 1)))),
                          child: TextField(
                            controller: email_controller,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFF8085ef),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: password1_controller,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Color(0xFF8085ef),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        is_sign_up
                            ? Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: password2_controller,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(
                                        color: Color(0xFF8085ef),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : const SizedBox(
                                height: 1,
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ])),
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                          if (email_controller.text.isEmpty ||
                              password1_controller.text.isEmpty) {
                            return;
                          }
                          if (is_sign_up &&
                              password1_controller.text !=
                                  password2_controller.text) {
                            return;
                          }
                          if (is_sign_up) {
                            await auth.signUp(email_controller.text,
                                password1_controller.text);
                            // await Provider.of<AuthenticationService>(context,
                            //         listen: false)
                            //     .reauthenticate();
                          } else {
                            await auth.signIn(email_controller.text,
                                password1_controller.text);
                            // await Provider.of<AuthenticationService>(context,
                            //         listen: false)
                            //     .reauthenticate();
                          }
                        },
                        child: Text(
                          is_sign_up ? "Sign Up" : "Login",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  is_sign_up
                      ? const SizedBox(
                          height: 1,
                        )
                      : const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                  SizedBox(
                    height: is_sign_up ? 30 : 85,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        is_sign_up = !is_sign_up;
                      });
                    },
                    child: Text(
                      is_sign_up
                          ? "Already Have an Account? Login!"
                          : "New to FlexEd? Create a New Account!",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromRGBO(143, 148, 251, 1)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
