import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Let´s stop mess up with infinty to-do text list", textAlign: TextAlign.center,style: TextStyle(fontSize: 30, ),),
                // Form: user y pwd
                Container(
                  margin:
                      EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
                  child: new Column(
                    children: <Widget>[
                      TextField(
                          autocorrect: false,
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: "Usuario",
                              icon: Icon(Icons.account_circle))),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Contraseña", icon: Icon(Icons.lock)),
                      )
                    ],
                  ),
                ),
                // Login button
                Container(
                    padding: EdgeInsets.all(30),
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(20.0),
                      splashColor: Colors.blue,
                      onPressed: () {
                        _signInWithEmailAndPassword();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    )),
              ],
            )));
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
    } catch (e) {}

    if (user != null) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } else {
      showAlertDialog(context);
    }
    
  }

  showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { 
      Navigator.of(context).pop(); // dismiss dialog
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error login"),
    content: Text("Comprueba que has introducido bien email y contraseña"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}