import 'dart:io';

void main() {
  final studentTracker = StudentTracker();
  print('Welcome to the Sutdent Management App!');

  bool isLoggedIn = false;
  String currentUserRole = '';

  while (true) {
    if (!isLoggedIn) {
      print('Login as admin or user (type "admin" or "user" to continue):');
      final role = stdin.readLineSync();

      if (role == 'admin') {
        print('Enter admin password:');
        final password = stdin.readLineSync();
        if (password == 'admin123') {
          isLoggedIn = true;
          currentUserRole = 'admin';
        } else {
          print('Incorrect password. Access denied.');
        }
      } else if (role == 'user') {
        isLoggedIn = true;
        currentUserRole = 'user';
      } else {
        print('Invalid role. Try again.');
      }
    } else {
      print('Select an option:');
      print('1. Add Student');
      print('2. View Student');
      print('3. Show Total no. of Student');
      print('4. Logout');

      final choice = int.tryParse(stdin.readLineSync()!) ?? -1;

      switch (choice) {
        case 1:
          if (currentUserRole == 'admin') {
            studentTracker.addStudent();
          } else {
            print('Access denied. Only admins can add student.');
          }
          break;
        case 2:
          studentTracker.viewStudent();
          break;
        case 3:
          studentTracker.showTotalStudent();
          break;
        case 4:
          print('Logging out...');
          isLoggedIn = false;
          currentUserRole = '';
          break;
        default:
          print('Invalid choice. Please try again.');
      }
    }
  }
}

class Student {
  final String name;
  final String Class;
  final String rollno;

  Student({required this.name, required this.Class, required this.rollno});
}

class StudentTracker {
  List<Student> student = [];

  void addStudent() {
    print('Enter student name:');
    final name = stdin.readLineSync()!;

    print('Enter student class:');
    final Class = stdin.readLineSync()!;

    print('Enter student Roll no.:');
    final rollno = stdin.readLineSync()!;

    if (name.isEmpty || rollno == 0) {
      print('Invalid input. Student not added.');
      return;
    }

    student.add(Student(name: name, Class: Class, rollno: rollno));
    print('Student added successfully.');
  }

  void viewStudent() {
    if (student.isEmpty) {
      print('No student added yet.');
      return;
    }

    print('Student List:');
    print('Name     Class     Rollno');
    for (var i = 0; i < student.length; i++) {
      final Student = student[i];
      print('${Student.name}     ${Student.Class}     ${Student.rollno}');
    }
  }

  void showTotalStudent() {
    int count = 0;
    if (student.isEmpty) {
      print('Total Student: 0');
    } else {
      for (var i = 0; i < student.length; i++) {
        count++;
      }
      print('Total Student of : ${count}');
    }
  }
}
