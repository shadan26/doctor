import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/moduels/bookingmodel/entity/userdata.dart';
import 'package:doctorproject/7doctor/moduels/paymentmodel/paymentscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import'package:flutter/material.dart';

import 'firemanger.dart';
class BookScreen extends StatefulWidget{
  var id;
  var name;
  var major;
  var email;
  var phone;
  var dateOfBirt;
  var description;
  var image;
  var uid;

  BookScreen({
    required var id,
    required var name,
    required var major,
    required var email,
    required var phone,
    required var dateOfBirth,
    required var description,
    required var image,
    required var uid,
  }){
    this.id=id;
    this.name=name;
    this.major=major;
    this.email=email;
    this.phone=phone;
    this.dateOfBirt=dateOfBirth;
    this.description=description;
    this.image=image;
    this.uid=uid;
  }

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Color wcolor= Colors.white;

  Color bcolor =Colors.black;

  Color pcolor=Color(0xFF0C84FF);

  DateTime datetime=DateTime.now();

  TimeOfDay timeOfDay=TimeOfDay.now();

  var CalenderController=TextEditingController();

  var TimeController=TextEditingController();

  var FormKey=GlobalKey<FormState>();

  var bookTimeArray = ["9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "1:00 PM"];
  var bookDateArray=["8 DEC","9 DEC", "10 DEC","11 DEC"];

  var selectedTimeIndex = 0;
  var selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       'Booking',
    //       style: Theme.of(context).textTheme.titleLarge,
    //     ),
    //
    //   ),
    //   body: Container(
    //     width: double.infinity,
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Container(
    //             width: double.infinity,
    //             height: 200,
    //             alignment: AlignmentDirectional.center,
    //             decoration: BoxDecoration(
    //               color: Colors.blue,
    //               borderRadius: BorderRadiusDirectional.only(
    //                   bottomEnd: Radius.circular(20),
    //                   bottomStart: Radius.circular(20)
    //               ),
    //             ),
    //             child: Text(
    //               'Book your appointment now',
    //               style: Theme.of(context).textTheme.titleLarge,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Container(
    //             padding: EdgeInsetsDirectional.only(
    //                 start: 20,
    //                 bottom: 20,
    //                 end: 20
    //             ),
    //             child: Row(
    //               children: [
    //                 Container(
    //                   height: 170,
    //                   width: 170,
    //                   child: Image(image:NetworkImage(
    //                       '${image}'
    //                   ) ),
    //                 ),
    //                 SizedBox(
    //                   width: 10,
    //                 ),
    //                 Expanded(
    //                   child: Container(
    //                     height: 170,
    //                     width: double.infinity,
    //                     decoration: BoxDecoration(
    //                         color: Colors.grey[250]
    //                     ),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Email : ${email}',
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: Theme.of(context).textTheme.labelLarge,
    //                         ),
    //                         SizedBox(
    //                           height: 5,
    //                         ),
    //                         Text(
    //                           'phone : ${phone} ',
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: Theme.of(context).textTheme.labelLarge,
    //                         ),
    //                         SizedBox(
    //                           height: 5,
    //                         ),
    //                         Text(
    //                           'Date of Birth: ${dateOfBirt}',
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: Theme.of(context).textTheme.labelLarge,
    //                         ),
    //                         SizedBox(
    //                           height: 5,
    //                         ),
    //                         Text(
    //                           '${description}',
    //                           maxLines: 2,
    //                           overflow: TextOverflow.ellipsis,
    //
    //                           style: Theme.of(context).textTheme.labelLarge,
    //                         ),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 )
    //
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Container(
    //               padding: EdgeInsetsDirectional.only(
    //                   bottom: 20
    //               ),
    //               child: Form(
    //                 key: FormKey,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       'Choose the day of your reservation',
    //                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    //                           color: Colors.black,
    //                           fontSize: 16
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 20,
    //                     ),
    //                     TextFormField(
    //                       decoration: InputDecoration(
    //                           label: Text(
    //                               'Calender'
    //                           ),
    //                           prefixIcon: Icon(
    //                               Icons.calendar_month
    //                           ),
    //                           border: OutlineInputBorder()
    //                       ),
    //                       keyboardType: TextInputType.text,
    //                       onTap: (){
    //                         showDatePicker(
    //                             context: context,
    //                             initialDate: datetime,
    //                             firstDate: datetime,
    //                             lastDate: DateTime.parse('2024-05-03')).then((value){
    //                           CalenderController.text=DateFormat.yMMMd().format(value!);
    //
    //                         });
    //                       },
    //                       controller: CalenderController,
    //                       validator: (String ?value){
    //                         if(value==null || value.isEmpty){
    //                           return 'Date of Event(Please Enter)';
    //                         }
    //                         return null;
    //                       },
    //                     ),
    //                     SizedBox(
    //                       height: 20,
    //                     ),
    //                     Text(
    //                       'Choose the time of your reservation',
    //                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    //                           color: Colors.black,
    //                           fontSize: 16
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 20,
    //                     ),
    //                     TextFormField(
    //                       decoration: InputDecoration(
    //                           label: Text(
    //                               'Time'
    //                           ),
    //                           prefixIcon: Icon(
    //                               Icons.watch_later_rounded
    //                           ),
    //                           border: OutlineInputBorder()
    //                       ),
    //                       controller: TimeController,
    //                       onTap: (){
    //                         showTimePicker(
    //                             context: context,
    //                             initialTime:timeOfDay ).then((value) {
    //                           TimeController.text=value!.format(context);
    //                         });
    //                       },
    //                       validator: (String ?value){
    //                         if(value==null || value.isEmpty){
    //                           return 'Time of Event(Please Enter)';
    //                         }
    //                         return null;
    //                       },
    //                     ),
    //                     SizedBox(
    //                       height: 40,
    //                     ),
    //                     Container(
    //                       decoration: BoxDecoration(
    //                           color: Colors.blue,
    //                           borderRadius: BorderRadiusDirectional.circular(30)
    //                       ),
    //                       width: double.infinity,
    //                       child: MaterialButton(
    //                         onPressed: (){
    //                           if(FormKey.currentState!.validate()){
    //                             Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()));
    //                           }
    //
    //                         },
    //                         child:Text(
    //                           'Next',
    //                           style: Theme.of(context).textTheme.titleLarge,
    //                         ) ,
    //                       )
    //                       ,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           )
    //
    //
    //
    //
    //
    //
    //
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    Color pColor = Colors.blue;
    return Material(
      color: const Color(0xFFD9E4EE),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.1,
              decoration:  BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${widget.image}"),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      pColor.withOpacity(0.9),
                      pColor.withOpacity(0),
                      pColor.withOpacity(0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF2F8FF),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 4,
                                        spreadRadius: 2
                                    )
                                  ]
                              ),
                              child: Center(
                                child: Icon(Icons.arrow_back,color: pColor,size: 28,),
                              ) ,
                            ), // Example icon
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F8FF),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(Icons.favorite_outline, color:pColor,
                                  size:28 ),

                            ),
                          )

                          // Add other widgets here if needed
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Patient",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                //height: 8,
                                child: Text(
                                  "1.8k",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )

                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Experience",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                //height: 8,
                                child: Text(
                                  "10 y",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )

                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Rating",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                //height: 8,
                                child: Text(
                                  "4.9",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )

                            ],
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: pColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.red,
                        size: 28,// Set the color of the icon to red
                      ),
                      const SizedBox(width: 5,),
                      Text("${widget.major}",style: TextStyle(
                        fontSize: 17,
                        color: bcolor.withOpacity(0.6),
                      ),)
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "${widget.description}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6), // Set the text color to black with 60% opacity
                    ),
                    textAlign: TextAlign.justify, // Align text to justify
                  ),
                  SizedBox(height: 15), // Adding vertical space with SizedBox

                  Center(
                    child: Text(
                      "Book Date",
                      style: TextStyle(
                          fontSize: 18,
                          color: bcolor.withOpacity(0.6),
                          fontWeight: FontWeight.w600// Assuming bColor is defined elsewhere
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    height: 70,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: bookDateArray.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedDateIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                            decoration: BoxDecoration(
                              color: selectedDateIndex == index ? pColor : const Color(0xFFF2F8FF), // Check if this button is tapped
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  bookDateArray[index],
                                  style: TextStyle(
                                    color: selectedDateIndex == index ? Colors.white : bcolor.withOpacity(0.6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );


                      },
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          "Book Time",
                          style: TextStyle(
                            fontSize: 18,
                            color: bcolor.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 60,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: bookTimeArray.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  selectedTimeIndex=index;
                                });
                              },
                              child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: selectedTimeIndex==index ? pColor : Color(0xFFF2F8FF),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      bookTimeArray[index],
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: selectedTimeIndex==index ? Colors.white : bcolor.withOpacity(0.6),
                                      ),
                                    ),
                                  )

                              ),
                            );

                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            bottom: 20
                        ),
                        child: Material(
                          color: pcolor,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: (){
                              var date = bookDateArray[selectedDateIndex];
                              var time = bookTimeArray[selectedTimeIndex];
                              var doctorId = widget.uid;
                              var userId = FirebaseAuth.instance.currentUser?.uid;


                              var data = AppointmentData(status: "initial",time: time, date: date, doctoruuid: doctorId, userId: userId);
                              Appointment.instance.bookAppointment(data);
                            } ,
                            child: Container(
                                height: 40,
                                width:  MediaQuery.of(context).size.width,
                                child: Center(
                                    child:Text("Book Appointment",
                                        style: Theme.of(context).textTheme.titleLarge
                                    )
                                )),


                          ),
                        ),
                      )
                    ],
                  ),


                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}



