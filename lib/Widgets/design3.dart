import 'package:flutter/material.dart';

import 'designcolor.dart';

class advancedSearch extends StatelessWidget {
  const advancedSearch({
    Key? key,
    required this.size,
    required this.formKey,
    required TextEditingController jobController,
    required TextEditingController cityController,
    required TextEditingController jobTypeController,
  }) : _jobController = jobController, _cityController = cityController, _jobTypeController = jobTypeController, super(key: key);

  final Size size;
  final GlobalKey<FormState> formKey;
  final TextEditingController _jobController;
  final TextEditingController _cityController;
  final TextEditingController _jobTypeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 47,left: 18),
      height: size.height*0.32,
      width: size.width*1,
      
      decoration: BoxDecoration(
          color: Palette.searchColor,
          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(28),
                bottomRight: Radius.circular(28),
                ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Padding(
            padding: const EdgeInsets.only(right: 8,left: 8,bottom: 12),
            child: Text('Find your Job',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: Colors.white,
            ),
            ),
          ),
          SizedBox(height: 12,),

          Form(
              key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _jobController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                          filled: true,
                          fillColor: Palette.fillColor,
                          
                          hintText: 'Enter job title',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.7)
                          ),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                        ),
                ),
                SizedBox(height: 12,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                  controller: _cityController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                          filled: true,
                          fillColor: Palette.fillColor,
                          
                          hintText: 'Enter job title',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.7)
                          ),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                        ),
                ),
                    ),
                    SizedBox(width: 12,),
                     Expanded(
                       child: TextFormField(
                  controller: _jobTypeController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                  
                  decoration: InputDecoration(
                          filled: true,
                          fillColor: Palette.fillColor,
                          
                          hintText: 'Enter job title',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.7)
                          ),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                        ),
                ),
                     ),
                     SizedBox(width: 12,),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(color:Color.fromARGB(224, 255, 255, 255),borderRadius: BorderRadius.circular(35)),
                  child: IconButton(onPressed: (){
                    formKey.currentState!.save();
                    print(formKey.currentState);
                  }, icon: Icon(Icons.arrow_right_alt_rounded)),
                )
                  ],
                ),
               
              ],
            ),
          )
        ],
        
      ),
    );
  }
}