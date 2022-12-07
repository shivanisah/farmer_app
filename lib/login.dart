import 'package:agriculture/shared_preferences/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UsersPages/Admin.dart';
import 'UsersPages/Collector.dart';
import 'UsersPages/Farmer.dart';
import 'register.dart';
import 'package:form_field_validator/form_field_validator.dart';





class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  bool loading= false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
          Container(          
            decoration:BoxDecoration(
              
              image:DecorationImage(image:AssetImage("images/agri.jpg"),
            
            fit:BoxFit.fill
            ),
           
            )
),
Container(color:Colors.black.withOpacity(0.50)),


       SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              // color: Colors.orangeAccent[700],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          // autovalidateMode:AutovalidateMode.onUserInteraction,
                          // obscureText:true,


                          decoration: InputDecoration(
                            prefixIcon:Icon(Icons.mail),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          // onSaved: (value) {
                          //   emailController.text = value!;
                          // },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure3,
                          decoration: InputDecoration(
                            prefixIcon:Icon(Icons.password),
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure3
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure3 = !_isObscure3;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          // onSaved: (value) {
                          //   passwordController.text = value!;
                          // },
                          // keyboardType: TextInputType.emailAddress,
                        ),
                       
                        SizedBox(
                          height: 20,
                        ),
                loading?CircularProgressIndicator():MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          color: Colors.white,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                     onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                          child: Text(
                            
                            "Don't have an account? Register",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        // Visibility(
                        //     maintainSize: true,
                        //     maintainAnimation: true,
                        //     maintainState: true,
                        //     visible: visible,
                        //     child: Container(
                        //         child: CircularProgressIndicator(
                        //       color: Colors.white,
                        //     ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ],
      ),
    );
  }
  void signIn(String email,String password) async{
    if(_formkey.currentState!.validate())
    {
                                  setState(() {
                              loading = true;
                            });

      try{
        UserCredential userCredential = await 
        FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
           password: password);
           
       final _pref = updateSharedPrefernces(email); 

           
    route();  
                                  setState(() {
                              loading = false;
                            });

      }on FirebaseAuthException catch (e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.message.toString()),backgroundColor:Colors.red));

      }
    }
  }


void route(){
User? user =  FirebaseAuth.instance.currentUser;

var data=  FirebaseFirestore.instance.collection('Collectors').doc(user!.uid).get().
            then((DocumentSnapshot documentSnapshot){
                          if(documentSnapshot.exists){
                           
                              final _pref = checkSharedPrefernces(true); 
                                    Navigator.pushReplacement(
                                      context,MaterialPageRoute(builder:(context)=>Collector()),
                                    );
                            
                            }});

var data1=  FirebaseFirestore.instance.collection('Farmers').doc(user.uid).get().
            then((DocumentSnapshot documentSnapshot){
                          if(documentSnapshot.exists){
                              final _pref = checkSharedPrefernces(false); 
                                    Navigator.pushReplacement(
                                      context,MaterialPageRoute(builder:(context)=>Farmer()),
                                    );
                            
                            }
                            }   );  
var data2=  FirebaseFirestore.instance.collection('users').doc(user.uid).get().
            then((DocumentSnapshot documentSnapshot){
                          if(documentSnapshot.exists){
                                    Navigator.pushReplacement(
                                      context,MaterialPageRoute(builder:(context)=>Admin()),
                                    );
                            
                            }
                            }   );                         

                            //     else if(documentSnapshot.get("role")=="Farmer"){
                            //   final _pref = checkSharedPrefernces(false); 

                            //         Navigator.pushReplacement(
                            //           context,MaterialPageRoute(builder:(context)=>Farmer()),
                            //         );
                            // }


                            //  else{
                            //             Navigator.pushReplacement(
                            //                     context,MaterialPageRoute(
                            //                     builder: (context) => Admin()));}
                                                
                                                

  }
}
