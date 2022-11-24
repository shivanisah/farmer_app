
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../UsersPages/Admin.dart';
import 'design3.dart';
import 'designcolor.dart';

class Home extends StatefulWidget {

   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final formKey = GlobalKey<FormState>();

    final _jobController = TextEditingController();

    final _cityController = TextEditingController();

    final _jobTypeController = TextEditingController(); 

  @override
  void dispose(){
    _jobController.dispose();
    _cityController.dispose();
    _jobTypeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<StaffProvider>(context,listen: false);
    final Size size  = MediaQuery.of(context).size;
     Color colorWhite = Colors.white;
     Color colorPurple = Palette.lightPurple;
     bool istap =false;
    print('widget build');
    return Scaffold(
                        drawer:
      Drawer(
        // width:250,
        backgroundColor:Color.fromARGB(253, 243, 242, 247),
        child:ListView(
          children: [
            UserAccountsDrawerHeader(
              
              accountName: Text("Hello"), accountEmail: Text("MyEmail"),
            currentAccountPicture:CircleAvatar(backgroundColor:Colors.white,
            backgroundImage:AssetImage('images/agri.jpg'))
            ),
             ListTile(
              title:Text('Home',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.home,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>Admin()
                )
              )
            ),
          ListTile(
              title:Text('Design',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.home,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>Home()
                )
              )
            ),


            // ListTile(
            //   title:Text('Collectors List',style:TextStyle(color:Colors.black,fontSize:16 )),
            //   leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
            //   trailing:Icon(Icons.arrow_forward),
            //   onTap:()=>  Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => CollectorList()
            //     )
            //   )
            // ),
            //  ListTile(
            //   title:Text('Collectors Profile List',style:TextStyle(color:Colors.black,fontSize:16 )),
            //   leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
            //   trailing:Icon(Icons.arrow_forward),
            //   onTap:()=>  Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => Collector_Detail()
            //     )
            //   )
            // ),

            // ListTile(
            //   title:Text('Farmers List',style:TextStyle(color:Colors.black,fontSize:16 )),
            //   leading:Icon(Icons.person_rounded,color:Colors.blue),
            //   trailing:Icon(Icons.arrow_forward),
            //     onTap:()=>  Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) =>FarmerList()
            //     )
            //   )
            // ),

            // ListTile(
            //   title:Text('Farmers Profile Page',style:TextStyle(color:Colors.black,fontSize:16 )),
            //   leading:Icon(Icons.person_rounded,color:Colors.blue),
            //   trailing:Icon(Icons.arrow_forward),
            //     onTap:()=>  Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) =>Farmers_profile_detail()
            //     )
            //   )
            // ),

            // ListTile(
            //   title:Text('Log Out',style:TextStyle(color:Colors.black,fontSize:16 )),
            //   leading:Icon(Icons.logout_rounded,color:Colors.blue),
            //   onTap:()=> logout(context),
            //   trailing:Icon(Icons.arrow_forward),


            // ),


          ],
        ),
      ),


      
      // backgroundColor: Colors.white ,
      // drawer: UserDrawer(),
      appBar:AppBar(
        backgroundColor: Palette.searchColor,
        shadowColor: Color.fromARGB(0, 179, 59, 59),
        surfaceTintColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(foregroundImage: AssetImage('assets/images/splash.jpg'),),
          )
          
        ],
      ) ,
      body: SingleChildScrollView(
      
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            advancedSearch(size: size, formKey: formKey, jobController: _jobController, cityController: _cityController, jobTypeController: _jobTypeController),
            SizedBox(height: 10,),

            Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left:18.0,top:7),
                   child: Text('Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    ),
                 ),
                  SizedBox(height: 14,),
                  // Consumer<StaffProvider>(
                  //   builder: (context, provider, child) {
                  //     final itemss = provider.jobCategory();
                  //     print(provider);
                  //     return Text('data');
                      
                  //   },
                  // ),
                  SingleChildScrollView(
                    
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(left: 22,bottom: 5,top: 5),
                      child: Row(
                        children: [
                          
                          GestureDetector(
                            onTap: (){
                              // print('tapped');
                                
                              // print(istap);
                              // setState(() {
                              //   istap = !istap;
                              // });
                              // print(istap);

                            },
                            child: Container(
                              height: size.height*0.19,
                              width: size.width*0.31,
                              margin: EdgeInsets.only(left: 22),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,7),
                                            blurRadius: 10,
                                            color:Colors.black.withOpacity(0.3),
                            
                                          )
                                        ]
                                
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  Icon(Icons.book,color:colorPurple,),
                                  Text('Job:33',style: TextStyle(color: Colors.black),),
                                  Text('visual Design',style: TextStyle(color:Colors.black))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              // print('tapped');
                                
                              // print(istap);
                              // setState(() {
                              //   istap = !istap;
                              // });
                              // print(istap);

                            },
                            child: Container(
                              height: size.height*0.19,
                              width: size.width*0.31,
                              margin: EdgeInsets.only(left: 22),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,7),
                                            blurRadius: 10,
                                            color:Colors.black.withOpacity(0.3),
                            
                                          )
                                        ]
                                
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  Icon(Icons.book,color:colorPurple,),
                                  Text('Job:33',style: TextStyle(color: Colors.black),),
                                  Text('visual Design',style: TextStyle(color:Colors.black))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              // print('tapped');
                                
                              // print(istap);
                              // setState(() {
                              //   istap = !istap;
                              // });
                              // print(istap);

                            },
                            child: Container(
                              height: size.height*0.19,
                              width: size.width*0.31,
                              margin: EdgeInsets.only(left: 22),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,7),
                                            blurRadius: 10,
                                            color:Colors.black.withOpacity(0.3),
                            
                                          )
                                        ]
                                
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  Icon(Icons.book,color:colorPurple,),
                                  Text('Job:33',style: TextStyle(color: Colors.black),),
                                  Text('visual Design',style: TextStyle(color:Colors.black))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              // print('tapped');
                                
                              // print(istap);
                              // setState(() {
                              //   istap = !istap;
                              // });
                              // print(istap);

                            },
                            child: Container(
                              height: size.height*0.19,
                              width: size.width*0.31,
                              margin: EdgeInsets.only(left: 22),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,7),
                                            blurRadius: 10,
                                            color:Colors.black.withOpacity(0.3),
                            
                                          )
                                        ]
                                
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  Icon(Icons.book,color:colorPurple,),
                                  Text('Job:33',style: TextStyle(color: Colors.black),),
                                  Text('visual Design',style: TextStyle(color:Colors.black))
                                ],
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  )

                
              ],
            ),

            // recent job section............................
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                       padding: const EdgeInsets.only(left:18.0,top:7),
                       child: Text('Recently added jobs',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        ),
                     ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:18.0,top:7,right: 18),
                child: Column(
                  children: [
                    GestureDetector(
                      
                      onTap:(){
                        Navigator.of(context).pushReplacementNamed('/detail_page');
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        height: 62,
                      
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(10),
                          color:Palette.lightBg,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                
                                
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/images/splash.jpg'),)
                                ),
                              )
                              ,Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      Text('Flutter Developer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Palette.lightPurple,
                                        ),
                                      ),
                                      Text('at Nepal Influencer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                      ),
                                  
                                  ],
                                ),
                              ),
                              SizedBox(width: size.width*0.10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                    Text('5 min ago',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                    Text('17 competitior',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                     GestureDetector(
                      onTap:(){print('tapped');},
                      child: Container(
                        height: 62,
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          
                          
                          borderRadius: BorderRadius.circular(10),
                          color:Palette.lightBg,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                
                                
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/images/splash.jpg'),)
                                ),
                              )
                              ,Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      Text('Flutter Developer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Palette.lightPurple,
                                        ),
                                      ),
                                      Text('at Nepal Influencer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                      ),
                                  
                                  ],
                                ),
                              ),
                              SizedBox(width: size.width*0.10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                    Text('5 min ago',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                    Text('17 competitior',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                     GestureDetector(
                      onTap:(){print('tapped');},
                      child: Container(
                        height: 62,
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(10),
                          color:Palette.lightBg,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                
                                
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/images/splash.jpg'),)
                                ),
                              )
                              ,Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      Text('Flutter Developer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Palette.lightPurple,
                                        ),
                                      ),
                                      Text('at Nepal Influencer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                      ),
                                  
                                  ],
                                ),
                              ),
                              SizedBox(width: size.width*0.10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                    Text('5 min ago',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                    Text('17 competitior',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )


            ],
          ),
          ],
          

        )
      ),
      

    );
    
  }
}

