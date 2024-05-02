import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/homescreen/homescreen.dart';
import 'package:doctorproject/7doctor/moduels/editProfile/editScreen.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/loginscreen.dart';
import 'package:doctorproject/7doctor/moduels/messagemodel/messagemodelscreen.dart';
import 'package:doctorproject/7doctor/moduels/profileInfo/profileInfoScreen.dart';
import 'package:doctorproject/7doctor/moduels/timemodel/timescreen.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:doctorproject/shared/shared_preferense/sharedPreferense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorState>(
      listener: (context,DoctorState){

      },
      builder: (context,DoctorState){
        DoctorCubit cubit=DoctorCubit.get(context);
        var modell=DoctorCubit.get(context).model;
        var doctorModel=DoctorCubit.get(context).doctorModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Setting Screen',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex,
            onTap: (index){
              cubit.changeCureentIndex(index);
              if(cubit.currentIndex==0){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
              }
              else if(cubit.currentIndex==1){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TimeScreen()), (route) => false);


              }
              else if(cubit.currentIndex==2)
              {
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
                  icon:Icon(
                      Icons.home
                  ),
                  label: 'Home'

              ),
              BottomNavigationBarItem(
                  icon:Icon(
                      Icons.watch_later_rounded
                  ),
                  label: 'Time'

              ),
              BottomNavigationBarItem(
                  icon:Icon(
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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setting',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 30

                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Account',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileInfo()));

                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${modell!.image}'
                        ),
                        radius: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${modell!.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${modell.uid}',

                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),

                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 40,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 40,
                ),
                /////////////////////////////////////////////////
                Text(
                  'Setting',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
                  },
                  child: Row(
                    children: [
                     CircleAvatar(
                       child: Icon(
                         Icons.edit,
                         color: Colors.white,
                       ),
                       backgroundColor: Colors.blue,
                       radius: 27,
                     ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Edit Profile'
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.help,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue,
                      radius: 27,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                        'Help Center'
                    ),
                    Spacer(),
                    Icon(
                        Icons.chevron_right
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue,
                      radius: 27,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                        'About Us'
                    ),
                    Spacer(),
                    Icon(
                        Icons.chevron_right
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    SharedHelper.RemoveData(key: 'uid').then((value) {
                      if(value) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) =>
                                LoginScreen()), (route) => false);


                      }



                    });
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue,
                        radius: 27,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          'Log Out'
                      ),
                      Spacer(),
                      Icon(
                          Icons.chevron_right
                      )
                    ],
                  ),
                )





              ],
            ),
          ),

        );
      },
    );

  }

}