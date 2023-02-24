import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget{

  final Function toggleView;
  const Register({required this.toggleView});

  @override
  _RegisterState createState() =>  _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth =  AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  // show the password or not
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('Sign up to Easy Task List',
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
            label: const Text('Sign In'),
          )],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children:  <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (value) => value!.isEmpty? 'Enter an email': null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (value) => value!.length < 6 ? 'Enter a password 6+ charts long': null,
                obscureText: _isObscure,
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
                    setState(()=> loading = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registered Successfully')),
                    );
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(()  {
                        error = 'Please provide n valid email';
                        loading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(60, 60),
                    elevation: 10),
                child:const Text('Register',
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