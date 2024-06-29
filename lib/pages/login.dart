import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/signup.dart';

import '../services/widget_model.dart';
import 'forgot.dart';
import 'landing_page.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  String email='',password='';
  final _formkey=GlobalKey<FormState>();
  TextEditingController useremailcontroller=new TextEditingController();
  TextEditingController userpaswordcontroller=new TextEditingController();

  userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage(),));
    }
    on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "User not found",
              style: TextStyle(fontSize: 18.0),
            )));

      }
      else{
        if(e.code=='wrong-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password is wrong",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.4,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF64B5F6), Color(0xFF64B5F6)])),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.width),
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Text(''),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30,left: 20,right: 20),
                  child: Column(
                    children: [
                      Center(child: Image.asset('images/newsimage2.webp',width: MediaQuery.of(context).size.width/2,fit: BoxFit.cover,)),
                      SizedBox(height: 30,),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 5,
                        child: Container(
                            padding: EdgeInsets.only(left: 20,right: 20),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,

                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),

                                  Row(
                                    children: [
                                      SizedBox(width: 115,),
                                      Text('Login',style: AppWidget.semiboldTextFieldStyle(),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  TextFormField(
                                    controller: useremailcontroller,
                                    validator: (value){
                                      if(value==null||value.isEmpty){
                                        return 'please enter email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Email',
                                        hintStyle: AppWidget.semiboldTextFieldStyle(),
                                        prefixIcon: Icon(Icons.email_outlined)
                                    ),
                                  ),
                                  TextFormField(
                                    controller: userpaswordcontroller,
                                    validator: (value){
                                      if(value==null||value.isEmpty){
                                        return 'please enter password';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: AppWidget.semiboldTextFieldStyle(),
                                      prefixIcon: Icon(Icons.password_outlined),
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                                    },
                                    child: Container(
                                        alignment: Alignment.topRight,
                                        child: Text('Forgot Password',style: AppWidget.semiboldTextFieldStyle(),)),
                                  ),
                                  SizedBox(height: 50,),

                                  GestureDetector(
                                    onTap: (){
                                      if(_formkey.currentState!.validate()){
                                        setState(() {
                                          email=useremailcontroller.text;
                                          password=userpaswordcontroller.text;
                                        });
                                      }
                                      userLogin();
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        height: 30,
                                        width: 150,
                                        decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(12)),
                                        child: Center(child: Text('LOGIN',style: TextStyle(fontWeight:FontWeight.bold,fontFamily: 'Poppins',fontSize: 15,color: Colors.white),)),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 60,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>signup(),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Dont't have an account? sign up",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
