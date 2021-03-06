import 'dart:io';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phonenum = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController highschoolcollegename = TextEditingController();
  final TextEditingController highschoolboard = TextEditingController();
  final TextEditingController highschoolpercent = TextEditingController();
  final TextEditingController intermediatecollegename = TextEditingController();
  final TextEditingController intermediateboard = TextEditingController();
  final TextEditingController intermediatepercent = TextEditingController();

  String? _dayvalue = '';
  String? _monvalue = '';
  String? _yearvalue = '';
  File? _photo;
  File? _signature;
  File? _aadhar;
  Future getPhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        this._photo = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  Future getSignature(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        this._signature = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  Future getsop(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        this._aadhar = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  Future<File> saveFilePermanentely(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: 'Basic Information',
        subtitle: 'Please fill some of the basic information to get started',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: 'Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value!)) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if (value.length < 3) {
                    return "Cannot be shorter than 3 Character";
                  }
                  if (value.length > 15) {
                    return "Cannot be larger than 15 Character";
                  } else {
                    return null;
                  }
                },
                controller: _name,
              ),
              _buildTextField(
                labelText: 'Email Address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email address is required';
                  }
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value!)) {
                    return "Invalid Email Id";
                  } else {
                    return null;
                  }
                },
                controller: _email,
              ),
              _buildTextField(
                //keyboardType:TextInputType.phone,
                labelText: 'Phone Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone Number is required';
                  }
                  if (value.length != 10) {
                    return "Please enter valid phone number";
                  }
                  if (!RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                      .hasMatch(value!)) {
                    return "Invalid Phone Number";
                  } else {
                    return null;
                  }
                },
                controller: _phonenum,
              ),
              _buildTextField(
                //keyboardType:TextInputType.phone,
                labelText: 'Address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Address is required';
                  }
                  if (!RegExp(r'[a-zA-Z\-0-9]+$').hasMatch(value!) &&
                      !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                          .hasMatch(value!)) {
                    return "Invalid Address";
                  }
                  if (value.length < 3) {
                    return "Cannot be shorter than 3 Character";
                  }
                  if (value.length > 30) {
                    return "Cannot be larger than 15 Character";
                  } else {
                    return null;
                  }
                },
                controller: _address,
              ),
              _buildTextField(
                //keyboardType:TextInputType.phone,
                labelText: 'Enter Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 3) {
                    return "Too Short";
                  }
                  if (value.length > 15) {
                    return "Too long";
                  } else {
                    return null;
                  }
                },
                //obscureText : true,
                controller: _password,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                color: Colors.white,
                child: const Text(
                  "Date of Birth",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              DropdownDatePicker(
                boxDecoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(5),
                ), // optional
                isDropdownHideUnderline: true, // optional
                isFormValidator: true, // optional
                startYear: 1950, // optional
                endYear: 2020, // optional
                width: 10, // optional
                // onChangedDay: (_dayvalue) => print('onChangedDay: $_dayvalue'),
                //  onChangedMonth: (_monvalue) => print('onChangedMonth: $_monvalue'),
                //  onChangedYear: (_yearvalue) => print('onChangedYear: $_yearvalue'),
                onChangedDay: (value) => {
                  _dayvalue = value,
                  print('onChangedDay: $value'),
                },

                onChangedMonth: (value) => {
                  _monvalue = value,
                  print('onChangedMonth: $value'),
                },

                onChangedYear: (value) => {
                  _yearvalue = value,
                  print('onChangedYear: $value'),
                },
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'Educational Qualification',
        subtitle: 'Enter you education you have been done so far',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                child: const Text(
                  "High School Details",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              _buildTextField(
                labelText: 'School Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'School Name is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value!)) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if (value.length < 5) {
                    return "Cannot be shorter than 5 Character";
                  }
                  if (value.length > 30) {
                    return "Cannot be larger than 30 Character";
                  } else {
                    return null;
                  }
                },
                controller: highschoolcollegename,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: CustomDropdown(
                  // fillColor: Colors.alabaster,
                  borderRadius: BorderRadius.circular(5),
                  hintText: 'Board',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  items: const ['State Board', 'CBSE Board', 'ICSE Board'],
                  controller: highschoolboard,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(
                labelText: 'Percent',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Percent is required';
                  }
                  // if (!RegExp(r'^(\d+|\d*[.]\d+)%?$').hasMatch(value!)) {
                  //   return "Invalid(Special Character are not allowed)";
                  // }
                  if (value.length != 2) {
                    return 'Invalid Percentage';
                  }
                  if (!RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                      .hasMatch(value!)) {
                    return "Percent cannot have Special Character/Alphabet";
                  }
                  else {
                    return null;
                  }
                },
                controller: highschoolpercent,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                child: const Text(
                  "Intermediate Details",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              _buildTextField(
                labelText: 'School Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'School Name is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value!)) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if (value.length < 5) {
                    return "Cannot be shorter than 5 Character";
                  }
                  if (value.length > 30) {
                    return "Cannot be larger than 30 Character";
                  } else {
                    return null;
                  }
                },
                controller: intermediatecollegename,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: CustomDropdown(
                  // fillColor: Colors.alabaster,
                  borderRadius: BorderRadius.circular(5),
                  hintText: 'Board',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  items: const ['State Board', 'CBSE Board', 'ICSE Board'],
                  controller: intermediateboard,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(
                labelText: 'Percent',

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Percent is required';
                  }
                  // if (!RegExp(r'^(\d+|\d*[.]\d+)%?$').hasMatch(value!)) {
                  //   return "Invalid(Special Character are not allowed)";
                  // }
                  if (value.length != 2) {
                    return 'Invalid Percentage';
                  }
                  if (!RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                      .hasMatch(value!)) {
                    return "Percent cannot have Special Character/Alphabet";
                  }
                  else {
                    return null;
                  }
                },
                controller: intermediatepercent,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
          title: 'Document Upload',
          subtitle: 'To verify the identity of yours',
          content: Center(
              child: Column(
            children: [
              CustomButton(
                title: 'Upload Photograph',
                icon: Icons.image_outlined,
                onClick: () => getPhoto(ImageSource.gallery),
              ),
              const SizedBox(
                height: 20,
              ),
              //'assets/images/siksha_logo.svg'
              _photo != null
                  ? Image.file(_photo!,
                      width: 250, height: 250, fit: BoxFit.cover)
                  : Image.asset('images/default-placeholder-image.png'),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                title: 'Upload Signature',
                icon: Icons.image_outlined,
                onClick: () => getSignature(ImageSource.gallery),
              ),
              const SizedBox(
                height: 20,
              ),
              _signature != null
                  ? Image.file(_signature!,
                      width: 250, height: 250, fit: BoxFit.cover)
                  : Image.asset('images/default-placeholder-image.png'),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                title: 'Upload Aadhar',
                icon: Icons.image_outlined,
                onClick: () => getsop(ImageSource.gallery),
              ),
              const SizedBox(
                height: 20,
              ),
              _aadhar != null
                  ? Image.file(_aadhar!,
                      width: 250, height: 250, fit: BoxFit.cover)
                  : Image.asset('images/default-placeholder-image.png'),
            ],
          )),
          validation: () {

          }),
      CoolStep(
          title: 'Confirmation',
          subtitle:
              'Recheck the entries you have made. You can change some of them in future',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: ClipOval(
                child: _photo != null
                    ? Image.file(_photo!,
                        width: 250, height: 250, fit: BoxFit.cover)
                    :Image.asset('images/default-placeholder-image.png'),
              )),
              const SizedBox(
                height: 40,
              ),

              apperance(
                title: 'Name',
                value: _name.text,
                a: 94,
              ),
              Container(
                child: Row(
                  children: [
                    const Text(
                      'Date of Birth',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 51,
                    ),
                    Text(
                      '$_dayvalue/$_monvalue/$_yearvalue',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),

              apperance(
                title: 'Email',
                value: _email.text,
                a: 95,
              ),

              apperance(
                title: 'Phone Number',
                value: _phonenum.text,
                a: 36,
              ),
              apperance(
                title: 'Address',
                value: _address.text,
                // a: 166,
                a: 78,
              ),

              const SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  child:const Text("High School Details",style: TextStyle(
                    color: Colors.grey,
                  ),),
                ),
              ),
              const SizedBox(height: 20,),
              //Text('School Name     ${highschoolcollegename.text}'),
              apperance(
                title: 'School Name',
                value: highschoolcollegename.text,
               // a: 88,
                a:47,
              ),
              //Text('Board    ${highschoolboard.text}'),
              apperance(
                title: 'Board',
                value: highschoolboard.text,
                a: 92,
              ),
              //Text('Percent    : ${highschoolpercent.text}'),
              apperance(
                title: 'Percent',
                value: highschoolpercent.text,
                a: 125-44,
              ),
              const SizedBox(height: 30,),
              Center(
                child: Container(
                  child:const Text("Intermediate Details",style: TextStyle(
                    color: Colors.grey,
                  ),),
                ),
              ),
              //Text('School Name    : ${intermediatecollegename.text}'),
              const SizedBox(height: 20,),
              apperance(
                title: 'School Name',
                value: intermediatecollegename.text,
                a: 47,
              ),
              // Text('Board   : ${intermediateboard.text}'),
              apperance(
                title: 'Board',
                value: intermediateboard.text,
                a: 134-43,
              ),
              //Text('Percent    : ${intermediatepercent.text}'),
              apperance(
                title: 'Percent',
                value: intermediatepercent.text,
                a: 125-43,
              ),
              Center(
                child: _signature != null
                    ? Image.file(_signature!,
                        width: 300, height: 150, fit: BoxFit.cover)
                    : Image.asset('images/default-placeholder-image.png'),
              ),
            ],
          ),
          validation: () {}),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () {
        print('Steps completed!');

      },
      steps: steps,
      config: const CoolStepperConfig(
        backText: 'PREV',
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Student Registration",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(child: stepper),
        ],
      ),
    );
  }

  Widget _buildTextField({
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget CustomButton({
    required String title,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return Container(
      width: 280,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 20,
            ),
            Center(child: Text(title))
          ],
        ),
      ),
    );
  }

  Widget apperance({
    required String title,
    required String value,
    required double a,
  }) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          SizedBox(
            width: a,
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
