import 'package:flutter/material.dart';
import 'dart:developer';
import 'api.dart';
import 'mainmenu.dart';
void main(){
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login>{
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  String username = '';
  String password = '';
  String email = '';
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }
  bool passwordOn = false;
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () {},
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
                padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: Text(
                  'Login',
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
                    controller: _usernameController,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter username/email',
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
                      labelText: 'Enter password',
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
                      if(_usernameController.text.contains('@gmail.com')){
                        email = _usernameController.text;
                        password = _passwordController.text;
                      }
                      else {
                        username = _usernameController.text;
                        password = _passwordController.text;
                      }
                      final response = await login(email, username, password);
                      if(response.body.contains("User not found") || response.body.contains("Incorrect password")){
                        log('API Request failed with status code: ${response.body} ${response.statusCode}');
                        log('Username : $username');
                        log('Password : $password');
                        log('Email : $email');
                        _usernameController.clear();
                        _passwordController.clear();
                        username = '';
                        password = '';
                        email = '';
                      }
                      else if (response.statusCode == 201) {
                        log('API Response: ${response.body}');
                        log('Username : $username');
                        log('Password : $password');
                        log('Email : $email');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainMenu()),
                        );
                        _usernameController.clear();
                        _passwordController.clear();
                        username = '';
                        password = '';
                        email = '';
                      }                     },
                    child: Container(
                      width: 1000,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Login',
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
