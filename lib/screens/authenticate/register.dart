/// register.dart
/// author:   Katherine Bellman, Russell Waring
/// date:     2023-02-18
/// version:  1
/// The register screen provides a simple interface for users to sign-up to use
/// our application. This concept was learned from the following series:
/// The Net Ninja. (2019, November 20). Flutter &amp; Firebase app build.
/// YouTube. Retrieved March 10, 2023, from
/// https://www.youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC

import 'package:birdnerd/shared/loading.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget{

  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() =>  _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth =  AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  // Text field state
  String email = '';
  String password = '';
  String password2 ="";
  String error = '';

  // show the password or not
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade800,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('Sign up',
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
         alignment:  const Alignment(0.0, 0.0),
        decoration:  const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/Splash%20background%20color.png?alt=media&token=d56e2f5a-2d56-47fc-9a28-0de2108eb82d"),
              fit: BoxFit.cover,
            ),
        ),
        //padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        child:Card(
          elevation: 10,
          color: const Color.fromRGBO(161, 214, 107, 72),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightGreen.shade800, width: 1),
              borderRadius: BorderRadius.circular(15.0)
          ),
          margin: const EdgeInsets.all(20),
         child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  <Widget>[
                const SizedBox(height: 10),
                const Image( image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/bird-nerd-15f35.appspot.com/o/BirdNerd_mark.png?alt=media&token=35ef1407-031b-427e-bff5-dbd2e246be95"),
                  height: 120,
                  width: 110,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))? 'Enter a valid email': null,
                  onChanged: (val) {
                    setState(() => email = val );
                  },
                  decoration:  InputDecoration(
                    prefixIcon:  Icon( Icons.email, color: Colors.lightGreen.shade800,) ,
                    hintText: 'E-mail',
                    hintStyle: const TextStyle(fontFamily: "Oswald", fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                        color: Colors.lightGreen.shade800,
                      ) ,
                      borderRadius: BorderRadius.circular(8.00)
                          
                    ),
                      errorStyle: const TextStyle(backgroundColor: Colors.white, fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: Colors.white
                  ),
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  controller: _pass,
                  validator: (value) => value!.length < 6 ? 'Enter a password 6+ charts long': null,
                  obscureText: _isObscure,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  decoration: InputDecoration(
                      prefixIcon:  Icon( Icons.lock , color: Colors.lightGreen.shade800,) ,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.lightGreen.shade800,
                          ) ,
                          borderRadius: BorderRadius.circular(8.00)

                      ),
                      errorStyle: const TextStyle(backgroundColor: Colors.white, fontWeight: FontWeight.w500),
                      filled: true,
                      fillColor: Colors.white,
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
                TextFormField(
                  controller: _confirmPass,
                  validator: (value) {
                    String validator = "";
                   if(value!.length < 6) {
                     validator += "Enter a password 6+ charts long";
                   }
                   if(value != _pass.text) {
                     validator += "\nPasswords do not match";
                   }
                   if(validator.isNotEmpty){
                     return validator;
                   }
                   return null;
                    },
                  obscureText: _isObscure2,

                  onChanged: (val) {
                    setState(() => password2 = val);
                  },
                  decoration: InputDecoration(
                      prefixIcon:  Icon( Icons.lock , color: Colors.lightGreen.shade800,) ,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.lightGreen.shade800,
                          ) ,
                          borderRadius: BorderRadius.circular(8.00)

                      ),
                      errorStyle: const TextStyle(backgroundColor: Colors.white, fontWeight: FontWeight.w500),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Confirm Password',

                      suffixIcon: IconButton(
                        icon: Icon(
                            _isObscure2 ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        },
                      )
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: ()async {
                    if(_formKey.currentState!.validate()){
                      /// Set loading state AFTER validation
                      setState(()=> loading = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registered Successfully')),
                      );
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        /// If an error occurs during login, set loading to false
                        setState(()  {
                          error = 'Please provide n valid email';
                          loading = false;
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.shade800,
                      minimumSize: const Size(150, 50),
                      elevation: 10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child:const Text('Register',
                    style: TextStyle(fontSize: 20, fontFamily: "Teko", fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0, ),
                ),

              ],
            ),
          ),
        )
          ,),
      ),
    );
  }
}