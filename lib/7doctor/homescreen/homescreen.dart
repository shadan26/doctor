import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/function/function.dart';
import 'package:doctorproject/7doctor/moduels/inclincmodel/inclincscreen.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/loginscreen.dart';
import 'package:doctorproject/7doctor/moduels/messagemodel/messagemodelscreen.dart';
import 'package:doctorproject/7doctor/moduels/onlinemedicalmodel/onlinemedicalscreen.dart';
import 'package:doctorproject/7doctor/moduels/registermodel/registercubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/settingmodel/settingScreen.dart';
import 'package:doctorproject/7doctor/moduels/timemodel/timescreen.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:doctorproject/shared/components/shared/shared.dart';
import 'package:doctorproject/shared/components/shared/shared.dart';
import 'package:doctorproject/shared/components/shared/shared.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:doctorproject/shared/shared_preferense/sharedPreferense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../notfication/notification.dart';

class HomeScreen extends StatelessWidget {
  var ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, doctorState) {},
      builder: (context, doctorState)  {
        DoctorCubit cubit = DoctorCubit.get(context);
        var modell=DoctorCubit.get(context).model;
        var doctormodell=DoctorCubit.get(context).doctorModel;
        if(modell?.status=='user')
        return Scaffold(
              key: ScaffoldKey,
              appBar: AppBar(
                title: Text(
                  '7 Doctors',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    ScaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const NotificationUser(),
                            ));
                      },
                      icon: Icon(
                        Icons.notifications,
                        size: 30,
                      ))
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeCureentIndex(index);
                  if (cubit.currentIndex == 0) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                  }
                  else if (cubit.currentIndex == 1) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeScreen()), (route) => false);
                  }
                  else if(cubit.currentIndex==2){ ////////(1)
                    // if(role=='Doctor')
                    // cubit.getAllUsers();
                    // else
                    //   cubit.getAllDoctors();
                   cubit.getAllUsers();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MessageScreen()), (route) => false);

                  }
                  else
                    {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SettingScreen()), (route) => false);


                    }

                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.home
                      ),
                      label: 'Home'

                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.watch_later_rounded
                      ),
                      label: 'Time'

                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.chat
                      ),
                      label: 'Message'

                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.settings
                      ),
                      label: 'Setting'

                  ),


                ],
              ),
              body: ConditionalBuilder(
                condition: (modell?.name!=null && modell?.image!=null),
                builder: (context)=>SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(20),
                                bottomStart: Radius.circular(20)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              //     CircleAvatar(
                              //       backgroundImage: NetworkImage(
                              //           '${modell!.image}'
                              //       ),
                              //       radius: 30,
                              //     ),
                              //     SizedBox(
                              //       width: 20,
                              //     ),
                              //     Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Text(
                              //             'Hello ${modell?.name}',
                              //             style: Theme
                              //                 .of(context)
                              //                 .textTheme
                              //                 .titleLarge
                              //         ),
                              //         Text(
                              //           'Hope you are doing well',
                              //           style: Theme
                              //               .of(context)
                              //               .textTheme
                              //               .titleSmall,
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 30,
                              //
                              // ),
                              // Container(
                              //   padding: EdgeInsetsDirectional.only(
                              //       start: 10
                              //   ),
                              //   width: double.infinity,
                              //   height: 40,
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadiusDirectional.circular(20)
                              //   ),
                              //   clipBehavior: Clip.antiAliasWithSaveLayer,
                              //   child: Row(
                              //     children: [
                              //       Icon(
                              //           Icons.search
                              //       ),
                              //       SizedBox(
                              //         width: 10,
                              //       ),
                              //       Text(
                              //         'Search',
                              //
                              //       )
                              //     ],
                              //   ),
                              // )
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                  '${modell?.image}',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Hello, ${modell?.name}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Hope You Are doing well',
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                      ),//first design اول اشي
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              'Medical Consultataions',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  color: Colors.blue
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                'All day,Certain time,Elite doctors',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                    color: Colors.black
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cubit.getAllUsers();
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) =>
                                                    OnlineMedical())
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadiusDirectional
                                                  .circular(20),

                                            ),
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            child: Image
                                              (
                                              height: 170,
                                              width: 170,
                                              image: NetworkImage(
                                                  'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg?crop=0.66698xw:1xh;center,top&resize=1200:*'

                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 130,
                                          child: Text(
                                              'Online Medical Consultaion',
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                  color: Colors.black)
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cubit.getAllUsers();
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) => InClinic())
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadiusDirectional
                                                  .circular(20),

                                            ),
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            child: Image
                                              (
                                              height: 170,
                                              width: 170,
                                              image: NetworkImage
                                                (
                                                  'https://www.verywellhealth.com/thmb/XHhQWkEg9aMaEEbXjQLm1jFBGz0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/VWH-GettyImages-1406496671-d559150d3c294b8282f546c5bbf21157.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 130,
                                          child: Text(
                                            'In-Clinic Reservation',
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                color: Colors.black
                                            ),

                                          ),
                                        )
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Home Services',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  color: Colors.blue
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'services are delivered to you ASAP',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 160,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>buildServiseItem(context, cubit.homeServices[index]),
                                  separatorBuilder: (context, index) => SizedBox(
                                    width: 15,
                                  ),
                                  itemCount: cubit.homeServices.length),
                            )

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator()),
              ),
              drawer: Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 10
                ),
                child: Container(
                  width: 200,
                  color: Colors.blue.withOpacity(0.6),
                  child: Center(
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_left,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child: Text(
                                    'Profile',

                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '${modell?.image}'

                              ),
                              radius: 30,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                cubit.getAllUsers();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MessageScreen()));
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.chat,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Text(
                                      'Chat',

                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => TimeScreen()));
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.watch_later_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Text(
                                      'Time',

                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => OnlineMedical()));
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.local_hospital,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Text(
                                      'Online Medical',

                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => InClinic()));
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.local_hospital,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Text(
                                      'Clinic Resrevation',

                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SettingScreen()));
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Text(
                                      'Setting',

                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  )
                                ],
                              ),
                            ),
                           SizedBox(
                             height: 100,
                           ),
                            Container(
                              alignment: AlignmentDirectional.bottomCenter,
                              padding: EdgeInsetsDirectional.only(
                                  bottom: 150
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    SharedHelper.RemoveData(key: 'uid').then((value) {
                                      if(value) {
                                        Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute(builder: (context) =>
                                                LoginScreen()), (route) => false);


                                      }



                                    });



                                  }
                                  , child:Text(
                                'Log Out',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ) ),
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
        else
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
              title: Text(
                '7 Doctors',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  ScaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      size: 30,
                    ))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeCureentIndex(index);
                if (cubit.currentIndex == 0) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                }
                else if (cubit.currentIndex == 1) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeScreen()), (route) => false);
                }
                else if(cubit.currentIndex==2){ ////////(1)
                  // if(role=='Doctor')
                  // cubit.getAllUsers();
                  // else
                  //   cubit.getAllDoctors();
                  cubit.getAllUsers();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MessageScreen()), (route) => false);

                }
                else
                {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SettingScreen()), (route) => false);


                }

              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.home
                    ),
                    label: 'Home'

                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.watch_later_rounded
                    ),
                    label: 'Time'

                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.chat
                    ),
                    label: 'Message'

                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.settings
                    ),
                    label: 'Setting'

                ),


              ],
            ),
            body: ConditionalBuilder(
              condition: (modell?.name!=null && modell?.image!=null),
              builder: (context)=>SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(20),
                              bottomStart: Radius.circular(20)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   children: [
                            //     CircleAvatar(
                            //       backgroundImage: NetworkImage(
                            //           '${modell!.image}'
                            //       ),
                            //       radius: 30,
                            //     ),
                            //     SizedBox(
                            //       width: 20,
                            //     ),
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //             'Hello ${modell?.name}',
                            //             style: Theme
                            //                 .of(context)
                            //                 .textTheme
                            //                 .titleLarge
                            //         ),
                            //         Text(
                            //           'Hope you are doing well',
                            //           style: Theme
                            //               .of(context)
                            //               .textTheme
                            //               .titleSmall,
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 30,
                            //
                            // ),
                            // Container(
                            //   padding: EdgeInsetsDirectional.only(
                            //       start: 10
                            //   ),
                            //   width: double.infinity,
                            //   height: 40,
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadiusDirectional.circular(20)
                            //   ),
                            //   clipBehavior: Clip.antiAliasWithSaveLayer,
                            //   child: Row(
                            //     children: [
                            //       Icon(
                            //           Icons.search
                            //       ),
                            //       SizedBox(
                            //         width: 10,
                            //       ),
                            //       Text(
                            //         'Search',
                            //
                            //       )
                            //     ],
                            //   ),
                            // )
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                '${modell?.image}',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Hello, ${modell?.name}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Hope You Are doing well',
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                        ),
                      ),
                    ),//first design اول اشي
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Container(
                    //   child: Column(
                    //     children: [
                    //       Text(
                    //         'Medical Consultataions',
                    //         style: Theme
                    //             .of(context)
                    //             .textTheme
                    //             .titleLarge!
                    //             .copyWith(
                    //             color: Colors.blue
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       Text(
                    //           'All day,Certain time,Elite doctors',
                    //           style: Theme
                    //               .of(context)
                    //               .textTheme
                    //               .titleMedium!
                    //               .copyWith(
                    //               color: Colors.black
                    //           )
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(20.0),
                    //         child: Row(
                    //           children: [
                    //             Expanded(
                    //               child: Column(
                    //                 children: [
                    //                   InkWell(
                    //                     onTap: () {
                    //                       cubit.getAllDoctors();
                    //                       Navigator.push(context,
                    //                           MaterialPageRoute(builder: (context) =>
                    //                               OnlineMedical())
                    //                       );
                    //                     },
                    //                     child: Container(
                    //                       decoration: BoxDecoration(
                    //                         borderRadius: BorderRadiusDirectional
                    //                             .circular(20),
                    //
                    //                       ),
                    //                       clipBehavior: Clip.antiAliasWithSaveLayer,
                    //                       child: Image
                    //                         (
                    //                         height: 170,
                    //                         width: 170,
                    //                         image: NetworkImage(
                    //                             'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg?crop=0.66698xw:1xh;center,top&resize=1200:*'
                    //
                    //                         ),
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     height: 10,
                    //                   ),
                    //                   Container(
                    //                     width: 130,
                    //                     child: Text(
                    //                         'Online Medical Consultaion',
                    //                         maxLines: 2,
                    //                         textAlign: TextAlign.center,
                    //                         style: Theme
                    //                             .of(context)
                    //                             .textTheme
                    //                             .titleLarge!
                    //                             .copyWith(
                    //                             color: Colors.black)
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 20,
                    //             ),
                    //
                    //             Expanded(
                    //               child: Column(
                    //                 children: [
                    //                   InkWell(
                    //                     onTap: () {
                    //                       cubit.getAllDoctors();
                    //                       Navigator.push(context,
                    //                           MaterialPageRoute(
                    //                               builder: (context) => InClinic())
                    //                       );
                    //                     },
                    //                     child: Container(
                    //                       decoration: BoxDecoration(
                    //                         borderRadius: BorderRadiusDirectional
                    //                             .circular(20),
                    //
                    //                       ),
                    //                       clipBehavior: Clip.antiAliasWithSaveLayer,
                    //                       child: Image
                    //                         (
                    //                         height: 170,
                    //                         width: 170,
                    //                         image: NetworkImage
                    //                           (
                    //                             'https://www.verywellhealth.com/thmb/XHhQWkEg9aMaEEbXjQLm1jFBGz0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/VWH-GettyImages-1406496671-d559150d3c294b8282f546c5bbf21157.jpg'),
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     height: 10,
                    //                   ),
                    //                   Container(
                    //                     width: 130,
                    //                     child: Text(
                    //                       'In-Clinic Reservation',
                    //                       maxLines: 2,
                    //                       textAlign: TextAlign.center,
                    //                       style: Theme
                    //                           .of(context)
                    //                           .textTheme
                    //                           .titleLarge!
                    //                           .copyWith(
                    //                           color: Colors.black
                    //                       ),
                    //
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       Text(
                    //         'Home Services',
                    //         style: Theme
                    //             .of(context)
                    //             .textTheme
                    //             .titleLarge!
                    //             .copyWith(
                    //             color: Colors.blue
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       Text(
                    //         'services are delivered to you ASAP',
                    //         style: Theme
                    //             .of(context)
                    //             .textTheme
                    //             .titleMedium!
                    //             .copyWith(
                    //             color: Colors.black
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       Container(
                    //         height: 160,
                    //         child: ListView.separated(
                    //             shrinkWrap: true,
                    //             scrollDirection: Axis.horizontal,
                    //             physics: BouncingScrollPhysics(),
                    //             itemBuilder: (context, index) =>buildServiseItem(context, cubit.homeServices[index]),
                    //             separatorBuilder: (context, index) => SizedBox(
                    //               width: 15,
                    //             ),
                    //             itemCount: cubit.homeServices.length),
                    //       )
                    //
                    //     ],
                    //   ),
                    // ),

                  ],
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
            drawer: Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 10
              ),
              child: Container(
                width: 200,
                color: Colors.blue.withOpacity(0.6),
                child: Center(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              SizedBox(
                                width: 10,
                              ),

                              Expanded(
                                child: Text(
                                  'Profile',

                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleLarge,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${modell?.image}'

                            ),
                            radius: 30,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              cubit.getAllUsers();
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MessageScreen()));
                            },
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child: Text(
                                    'Chat',

                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => TimeScreen()));
                            },
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.watch_later_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child: Text(
                                    'Time',

                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => OnlineMedical()));
                            },
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.local_hospital,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child: Text(
                                    'Online Medical',

                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => InClinic()));
                            },
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.local_hospital,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child: Text(
                                    'Clinic Resrevation',

                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SettingScreen()));
                            },
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child: Text(
                                    'Setting',

                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            alignment: AlignmentDirectional.bottomCenter,
                            padding: EdgeInsetsDirectional.only(
                                bottom: 150
                            ),
                            child: TextButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  SharedHelper.RemoveData(key: 'uid').then((value) {
                                    if(value) {
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (context) =>
                                              LoginScreen()), (route) => false);


                                    }



                                  });



                                }
                                , child:Text(
                              'Log Out',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ) ),
                          ),



                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
      },
    );
  }
}

