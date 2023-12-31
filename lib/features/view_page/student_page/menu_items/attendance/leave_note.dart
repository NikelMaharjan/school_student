import 'package:dio/dio.dart';
import 'package:eschool/features/providers/leave_note_provider.dart';
import 'package:eschool/features/services/student_leave_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/snackshow.dart';

class AddNote extends ConsumerStatefulWidget {

  final int student_id;

  const AddNote({super.key, required this.student_id });

  @override
  ConsumerState<AddNote> createState() => _AddNoteState(student_id: student_id);
}



class _AddNoteState extends ConsumerState<AddNote> {


  final _formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  // Controllers for the text fields
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Function to show the date picker dialog
  Future<void> _showDatePicker(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.text.isEmpty ? DateTime.now() : DateTime.parse(controller.text),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString().substring(0, 10);
      });
    }
  }

  final int student_id;


  _AddNoteState({required this.student_id});
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {

      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
        _endDateController.clear();
      });
    }
  }




  @override
  Widget build(BuildContext context) {




    final auth = ref.watch(authProvider);

    final leave = ref.watch(leaveNoteProvider);




    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(

          automaticallyImplyLeading: false,


          backgroundColor: primary,
          title: const Text('Add Leave Note', style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Long leave?',
                      style: TextStyle(color: Colors.black),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                          activeColor: primary,
                          value: isSwitched,
                          onChanged: toggleSwitch
                      ),
                    )
                  ],
                ),


                SizedBox(height: 10.h,),

                Row(
                  children: [
                    Expanded(
                      child: Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: shimmerHighlightColor,
                            border: Border.all(color: Colors.black)),
                        child: TextFormField(
                          controller: _startDateController,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _showDatePicker(context, _startDateController);
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Date is  required';
                            }
                            return null;
                          },


                          style:const TextStyle(color:Colors.black) ,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                            hintText: 'Start Date',
                            hintStyle: const TextStyle(color:Colors.black)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    Expanded(
                      child: isSwitched == true?  Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: shimmerHighlightColor,
                            border: Border.all(color: Colors.black)),
                        child: TextFormField(
                          controller: _endDateController,
                          onTap: () {
                            _showDatePicker(context, _endDateController);
                          },
                          style:const TextStyle(color:Colors.black) ,
                          onEditingComplete: () {},
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                            hintText: 'End Date',
                              hintStyle: const TextStyle(color:Colors.black)
                          ),
                        ),
                      ):const SizedBox(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: shimmerHighlightColor,
                      border: Border.all(color: Colors.black)),
                  child: TextFormField(
                    controller: reasonController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Reason',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return SnackShow.showFailure(context, 'Reason cannot be empty');
                      }
                      return null;
                    },
                    onEditingComplete: (){},
                  ),
                ),


                const SizedBox(height: 10,),




                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        fixedSize: Size.fromWidth(320.w),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.black,
                            ))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();


                        if(isSwitched == false) {
                          if(DateTime.parse(_startDateController.text).isBefore(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())))){
                            return SnackShow.showFailure(context, 'Date is before current date');

                          }
                          else {
                            print('2');

                            ref.read(leaveNoteProvider.notifier).addNote(
                                reason: reasonController.text.trim(),
                                student: widget.student_id,
                                longLeave: false,
                                token: auth.user.token,
                                startDate: _startDateController.text,
                                endDate: null
                            ).then((value) => ref.refresh(studentLeaveNoteProvider(student_id))).then((value) => Navigator.pop(context));
                          }
                        }

                        else if(isSwitched == true) {
                          if(DateTime.parse(_startDateController.text).isBefore(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))) || DateTime.parse(_endDateController.text).isBefore(DateTime.now())){
                            print('3');
                            return SnackShow.showFailure(context, 'Date is before current date');

                          }
                          else {

                            print('4');
                            ref.read(leaveNoteProvider.notifier).addNote(
                                reason: reasonController.text.trim(),
                                student: widget.student_id,
                                longLeave: true,
                                token: auth.user.token,
                                startDate: _startDateController.text,
                                endDate: _endDateController.text
                            ).then((value) => ref.refresh(studentLeaveNoteProvider(student_id))).then((value) => Navigator.pop(context));
                          }
                        }


                      }






                    },
                    child: leave.isLoad
                        ? CircleAvatar(
                        radius: 15.sp,
                        child: const CircularProgressIndicator()
                    )
                        :const Text('Submit')
                ),



          ]),
            ),
          ),
        );
  }
}