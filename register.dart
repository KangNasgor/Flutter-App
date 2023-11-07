import 'package:flutter/material.dart';
import 'dart:developer';
import 'api.dart';
import 'login.dart';
void main(){
  runApp(MaterialApp(
    home: Signup(),
  ));
}

class Signup extends StatefulWidget {
  @override
  _MySignUp createState() => _MySignUp();
}

class _MySignUp extends State<Signup>{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String username = '';
  String password = '';
  String email = '';
  String confirmPassword = '';
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }
  bool passwordOn = false;
  bool passwordOn2 = false;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: 360,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff0C1C21),
                Color(0xff152E33),
                Color(0xff1C3B40),
              ]
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
              ),
              SizedBox(height: 51,),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SizedBox(
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter email',
                      labelStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SizedBox(
                  child: TextField(
                    controller: _usernameController,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Create username',
                      labelStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SizedBox(
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !passwordOn,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordOn = !passwordOn;
                            });
                          },
                          icon: passwordOn ?
                          Icon(
                            Icons.visibility,
                            color: Colors.white,
                          )
                              :
                          Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.white,
                          ),
                      ),
                      labelText: 'Create password',
                      labelStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SizedBox(
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: !passwordOn2,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {passwordOn2 = !passwordOn2;});
                        },
                        icon: passwordOn2 ? Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ) : Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'Confirm password',
                      labelStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextButton(
                    onPressed: () async{
                      if(username.isEmpty || password.isEmpty || email.isEmpty || confirmPassword.isEmpty){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content : Text('You must fill all fields before continuing'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  )
                                ],
                              );
                            }
                        );
                      }
                      if(_emailController.text.contains('@gmail.com')) {
                        username = _usernameController.text;
                        password = _passwordController.text;
                        email = _emailController.text;
                        confirmPassword = _confirmPasswordController.text;
                        if (confirmPassword == password) {
                          final response = await register(
                              email, username, password);
                          if (response.statusCode == 201) {
                            log('API Response: ${response.body}');
                            log('Email : $email');
                            log('Username : $username');
                            log('Password : $password');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          }
                          else {
                            log('API Request failed with status code: ${response
                                .body} ${response.statusCode}');
                          }
                        }
                        else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                      'Your confirm password doesn\'t match your real password.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    )
                                  ],
                                );
                              }
                          );
                        }
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text(
                                    'Your email is not correct'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  )
                                ],
                              );
                            }
                        );
                      }
                      },
                    child: Container(
                      width: 1000,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff62CDCB),
                            Color(0xff469ADC),
                          ],
                        ),
                      ),
                    ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  icon: Icon(Icons.clear, color: Colors.white,)
              )
            ],
          ),
        ),
      ),
    );

  }
}


