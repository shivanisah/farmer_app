import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'CollectorMainPage.dart';
import 'FarmerMainPage.dart';
// import 'model.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  _AddUserState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  var options = [
    'collector',
    'Farmer',
  ];
  var _currentItemSelected = "collector";
  var role = "collector";
  bool loading =false;

  @override 
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange[900],
      body: Stack(
        children: [
//           Container(          
//             decoration:BoxDecoration(
              
//               image:DecorationImage(image:AssetImage("images/agri.jpg"),
            
//             fit:BoxFit.fill
//             ),
           
//             )
// ),
// Container(color:Colors.black.withOpacity(0.50)),


          SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // color: Colors.orangeAccent[700],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            "Add User",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                            prefixIcon:Icon(Icons.email),

                              filled: true,
                              // fillColor: Colors.white,
                              hintText: 'Email',
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                // borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(20),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                // borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(20),
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
                            onChanged: (value) {},
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: _isObscure,
                            controller: passwordController,
                            decoration: InputDecoration(
                            prefixIcon:Icon(Icons.password),

                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
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
                                borderRadius: new BorderRadius.circular(20),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(20),
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
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: _isObscure2,
                            controller: confirmpassController,
                            decoration: InputDecoration(
                             prefixIcon:Icon(Icons.password),

                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure2
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure2 = !_isObscure2;
                                    });
                                  }),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Confirm Password',
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(20),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(20),
                              ),
                            ),
                            validator: (value) {
                              if (confirmpassController.text !=
                                  passwordController.text) {
                                return "Password did not match";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Role : ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              DropdownButton<String>(
                                dropdownColor: Colors.blue[900],
                                isDense: true,
                                isExpanded: false,
                                iconEnabledColor: Colors.white,
                                focusColor: Colors.white,
                                items: options.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(
                                      dropDownStringItem,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValueSelected) {
                                  setState(() {
                                    _currentItemSelected = newValueSelected!;
                                    role = newValueSelected;
                                  });
                                },
                                value: _currentItemSelected,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0))),
                                elevation: 5.0,
                                height: 40,
                                onPressed: () {
                                  setState(() {
                                    showProgress = true;
                                  });
                                  signUp(emailController.text,
                                      passwordController.text, role);
                                },
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                          //   ],
                          // ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),]
      ),
    );
  }

 void signUp(String email, String password, String role ) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate())
     {
      
          await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {

               User user = _auth.currentUser!;
               if(role=='collector'){
                 CollectionReference ref = FirebaseFirestore.instance.collection('Collectors');
           ref.doc(user.uid).set({'email': emailController.text, 'role': role,'UserId':user.uid,});
           Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CollectorList()));
               }
               else
              {
                 CollectionReference ref = FirebaseFirestore.instance.collection('Farmers');
           ref.doc(user.uid).set({'email': emailController.text, 'role': role,'UserId':user.uid});
           Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FarmerList()));
  
              }

               }
           
            // postDetailsToFirestore(email, role,UserId)
            )
          .catchError((e) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.message.toString()),backgroundColor:Colors.red));
});


    }
  }

 
}
