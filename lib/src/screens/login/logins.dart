import 'package:flutter/material.dart';
import 'package:sdg/src/screens/county/countydetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splash_screen/Splashscreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> loggedAcountNumber(email,password) async {

    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setString('email',email);
    pref.setString('password',password);

  }


  @override
  Widget build(BuildContext context) {
    var Screensize = MediaQuery.of(context).size.height;
    var Screensize1 = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('widget.title'),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Padding(
            //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            padding: Screensize1 >= 800? EdgeInsets.only( left:Screensize1/3 ,right: Screensize1/3):const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height:Screensize/10,),
                Image.network(
                  "https://mspwarehouse.s3.amazonaws.com/bin.gif",
                  height: 125.0,
                  width: 125.0,
                ),
                //SizedBox(height:Screensize/8,),
                const Text(
                  'Marine Litter SDG',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height:Screensize/10,),
                Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (

                          emailController.text == "mokeirakombo@gmail.com" &&passwordController.text == "0700513465"||
                          emailController.text == "mokeirakombo@gmail.com" &&passwordController.text == "0700513465"||
                          emailController.text == "owatagilbert @gmail.com" &&passwordController.text == "0727638620"||
                          emailController.text == "chrispineotieno702@gmail.com" &&passwordController.text == "0702407935"||
                          emailController.text == "kateagneta@gmail.com" &&passwordController.text == "0723517255"||
                          emailController.text == "otienokb@gmail.com" &&passwordController.text == "0710993616"||
                          emailController.text == "puryrop75@gmail.com" &&passwordController.text == "0743291409"||
                          emailController.text == "guest" &&passwordController.text == "guest"||
                          emailController.text == "guest" &&passwordController.text == "guest"||
                          emailController.text == "Ochiengokuku2003@yahoo.com" &&passwordController.text == "0726215339"
                          ) {

                            loggedAcountNumber(emailController.text,passwordController.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CountyDetails(
                                    email: "",
                                  )),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid Credentials')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

