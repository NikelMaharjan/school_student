
class Api {



  static const baseUrl = 'http://116.203.219.132:8080/api';
  static const basePicUrl = 'http://116.203.219.132:8080';



  static const notificationUrl = '$baseUrl/notification/all/?notification_token__notification_token=';
  static const updateNotificationUrl = '$baseUrl/notification/';




  static const school_college = '$baseUrl/schoolcollege/all/';
  static const school_info = '$baseUrl/schoolcollege_otherinfo/all/';
  static const school_contact = '$baseUrl/schoolcollegecontactinfo/all/';




  static const batchUrl = '$baseUrl/batch/all/';
  static const semUrl = '$baseUrl/year/all/';

  static const allClassesUrl = '$baseUrl/classlevel/all/';
  static const ongoingClasses = '$baseUrl/class/all/';
  static const allSections = '$baseUrl/section/all/';
  static const classSection = '$baseUrl/class_section/all/';
  static const subjectUrl = '$baseUrl/subject/all/';
  static const classSubjectUrl = '$baseUrl/class_subject/all/';
  static const sectionSubjectUrl = '$baseUrl/class_subject/all/?class_section=';


  //static const clasSubjectUrl = '$baseUrl/subject/all/?class_name=';
  static const clasSubjectUrl = '$baseUrl/class_subject/all/?class_section=';


  // static const sectionSubjectUrl = '$baseUrl/subject/all/?class_name=';

  static const courseUrl = '$baseUrl/course/all/';

  static const teacherSubjectUrl = '$baseUrl/teacher_subject/all/';



  static const assignmentUrl = '$baseUrl/assignment/all/';
  static const assignmentTotalUrl = '$baseUrl/assignment/all/?class_subject=';
  static const editAssignmentUrl = '$baseUrl/assignment/';
  static const studentAssignmentUrl = '$baseUrl/student_assignment/all/';
  static const delStudentAssignmentUrl = '$baseUrl/student_assignment/';
  static const assignmentStatus = '$baseUrl/assignment_status/all/';
  static const editAssignmentStatus = '$baseUrl/assignment_status/';





  static const userLogin = '$baseUrl/login/';
  static const userLogout = '$baseUrl/logout/';
  static const usersAll = '$baseUrl/user/all/';

  static const notices = '$baseUrl/notice/all/';
  static const editNotices = '$baseUrl/notice/';
  static const classNotices = '$baseUrl/class_notice/all/?class_section=';
  static const editClassNotices = '$baseUrl/class_notice/';

  static const delNotices = '$baseUrl/notice/';
  static const subNotices = '$baseUrl/subjectnotice/all/';
  static const editSubNotices = '$baseUrl/subjectnotice/';

  static const eventType = '$baseUrl/eventtype/all/';
  static const subType = '$baseUrl/eventsubtype/1/';
  static const calendarEvent = '$baseUrl/calendarevents/all/';

  static const employeeInfo = '$baseUrl/employeeinfo/all/';


  static const parentInfo = '$baseUrl/parent_info/all/';
  static const parentStudentInfo = '$baseUrl/parent_student_list/all/';


  static const studentInfo = "$baseUrl/studentadmission/all/";
  static const studentClassUrl = "$baseUrl/studentclass/all/";
  static const studentClassListUrl = "$baseUrl/studentclass/all/?student=";





  static const classSecSubUrl = '$baseUrl/teacher_class_subject/';
  static const teacherClass = '$baseUrl/teacher_class/all/';

  static const routineUrl = '$baseUrl/class_routine/all/';

  static const classWiseStudentUrl ='$baseUrl/class_student/all/?class_name=';

  static const subjectPlanUrl ='$baseUrl/subject_plan/all/?class_subject__subject=';
  static const editSubjectPlanUrl ='$baseUrl/subject_plan/';
  static const coursePlanUrl ='$baseUrl/course_plan/all/';
  static const editCoursePlanUrl ='$baseUrl/course_plan/';



  static const teacherCourseClassUrl ='$baseUrl/teacher_course_class/';
  static const teacherCourseUrl ='$baseUrl/class_course/';



  static const classRoutineUrl ='$baseUrl/class_routine/all/?class_subject__class_section=';
  static const teacherRoutine ='$baseUrl/teacher_class_routine/';




  static const attendanceUrl ='$baseUrl/attendance/all/';
  static const studentAttendanceUrl ='$baseUrl/student_attendance/all/';
  static const editStudentAttendanceUrl ='$baseUrl/student_attendance/';
  static const studentAttendanceInfo ='$baseUrl/student_attendance/all/?student=';
  static const teacherAttendanceUrl ='$baseUrl/employee_attendance/all/';
  static const teacherAttendanceInfoUrl ='$baseUrl/employee_attendance_info/all/';



  static const leaveNoteUrl ='$baseUrl/student_leave_note/all/';
  static const delLeaveNoteUrl ='$baseUrl/student_leave_note/';
  static const studentLeaveNoteUrl ='$baseUrl/student_leave_note/all/?student=';



  static const examDetailUrl ='$baseUrl/exam/all/';
  static const examClassDetailUrl ='$baseUrl/exam_class/all/';
  static const examRoutineUrl ='$baseUrl/exam_routine/all/';
  static const classExamRoutineUrl ='$baseUrl/exam_routine/all/?exam__exam_class=';
  static const examClassUrl ='$baseUrl/exam_class/all/?exam_class=';



  static const totalMarksUrl ='$baseUrl/total_exam_marks/all/?exam=';
  static const examMarksUrl ='$baseUrl/exam_marks/all/';
  static const subExamMarksUrl ='$baseUrl/exam_marks/all/?class_subject=';



  static const studentTotalFeeUrl ='$baseUrl/student_total_fee/all/?student=';
  static const studentFeeUrl ='$baseUrl/student_fee/all/?student_total_fee=';
  static const studentFeePaymentUrl ='$baseUrl/student_fee_payment/all/?total_fee=';
  static const studentAllFeePaymentUrl ='$baseUrl/student_fee_payment/all/';



  static const studentBusRouteUrl ='$baseUrl/student_bus_route/all/?student=';
  static const busLocationUrl ='$baseUrl/bus_location/all/?bus=';









}