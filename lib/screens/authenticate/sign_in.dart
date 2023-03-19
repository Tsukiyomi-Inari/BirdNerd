/// sign-in.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-02-18
/// version:  1
/// The sign-in screen provides a simple interface for users to sign-in to use
/// our application. This concept was learned from the following series:
/// The Net Ninja. (2019, November 20). Flutter &amp; Firebase app build.
/// YouTube. Retrieved March 10, 2023, from
/// https://www.youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC

import 'package:birdnerd/shared/loading.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';

class SignIn  extends StatefulWidget {

  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth =  AuthService();
  final _formKey = GlobalKey<FormState>();

  // Loading widget
  bool loading = false;

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  // show the password or not
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('Sign in',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),)
          ],),
        actions: <Widget>[
          TextButton.icon(
            onPressed: (){widget.toggleView();},
            style: TextButton.styleFrom(
                foregroundColor: Colors.white
            ),
            icon: const Icon(Icons.person),
            label: const Text('Sign Up'),
          )],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        /*//Anon Sign In
    child: ElevatedButton(
      onPressed: () async {
        dynamic result = await _auth.signInAnon();
        if (result == null) {
          print('error sign in');
        }else{
          print('signed in');
          print(result);
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: todoMint,
        minimumSize: const Size(60, 60),
        elevation: 10
      ),
      child: const Text('Sign In Anon',style: TextStyle(fontSize: 20),),
    ),*/
        child: Form(
          key: _formKey,
          child: Column(
            children:  <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty? 'Enter an email': null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                obscureText: _isObscure,
                validator: (val) => val!.isEmpty? 'Enter a password 6+ chars long': null,
                onChanged: (val) {
                  setState(() => password = val);
                },
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: ()async {
                  if(_formKey.currentState!.validate()){
                    /// Show loading state AFTER validation
                    setState(() => loading = true);
                    dynamic result = await _auth.signIn(email, password);
                    if(result == null){
                      /// Set loading state to false if an error occurs.
                      setState(() {
                        error = 'Error: Could not sign in with the credentials';
                        loading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.teal,
                    minimumSize: const Size(60, 60),
                    elevation: 10),
                child:const Text('Sign In',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
