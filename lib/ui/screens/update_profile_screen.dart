import 'package:flutter/material.dart';
import 'package:task_manager_fully_functional/ui/widgets/screen_background.dart';
import 'package:task_manager_fully_functional/ui/widgets/tm_app_bar.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        fromProfileScreen: true,
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildPhotoPickerWidget(),
                SizedBox(height: 8,),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                      size: 30,
                    )),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton(){}

  Widget _buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text('Photo',style: TextStyle(color: Colors.white),),
                      ),
                      SizedBox(width: 8,),
                      Text('Select your photo.'),
                    ],
                  ),
                ),
    );
  }
  void _onTapPhotoPicker(){

  }
}
