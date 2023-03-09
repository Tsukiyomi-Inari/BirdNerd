import 'package:birdnerd/screens/home/widgets/settings.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        backgroundColor: Colors.teal,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
            );
          },
          icon: const Icon(Icons.arrow_back),),
        title: const Text(
          'About',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white
          ),
        ),
        /*actions: <Widget>[
    IconButton(
    icon: const Icon(
    Icons.settings,
    color: Colors.white,
    ),
    onPressed: () {
    // do something
    },
    )
    ],*/
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: ()async {
                //await _auth.signOut();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.teal,
                  minimumSize: const Size(60, 60),
                  elevation: 10),
              child:const Text('Github',
                style: TextStyle(fontSize: 20),
              ),
            ),
           /* const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.teal,
                  minimumSize: const Size(60, 60),
                  elevation: 10),
              child:const Text('About',
                style: TextStyle(fontSize: 20),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}