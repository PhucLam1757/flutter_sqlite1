import "package:flutter/material.dart";
import "package:flutter_sqlite1/models/model.dart";
import 'package:flutter_sqlite1/screen/insert_screen.dart';
import 'package:flutter_sqlite1/SqliteController/SqliteController.dart';

class HomePage extends StatefulWidget {
  static const routeName = "home_screen";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  late SQLiteController sqliteController;
  late List<Student> _students = [];
  @override
  void initState() {
    super.initState();
    sqliteController = SQLiteController();
    getListStudentsFirstTime();
  }

  void getListStudentsFirstTime() async {
    await sqliteController.initializeDatabase();
    getListStudents();
  }

  void getListStudents() async {
    _students.clear();
    _students = await sqliteController.students();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Quản lý sinh viên",
              style: Theme.of(context).textTheme.headline1),
          backgroundColor: Colors.amberAccent,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                        context, InsertScreen.routeName);
                    setState(() async {
                      if (result != null) {
                        // items.sort((a, b) => b.name.compareTo(a.name));
                        await sqliteController.insertStudent(result as Student);
                        getListStudents();
                      }
                    });
                  },
                  child: Text("+"),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: OutlinedButton(
                        child: Text("Thêm sinh viên"), onPressed: () {}))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 6000,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _students.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () async {
                          final result = await Navigator.pushNamed(
                              context, InsertScreen.routeName,
                              arguments: _students[index]);
                          setState(() async {
                            if (result != null) {
                              final results = result as Student;
                              final student_cpw = _students[index].copyWith(
                                  name: results.name,
                                  age: results.age,
                                  phone: results.phone);
                              //     (result as Student).name;
                              // _students[index].copyWith().age =
                              //     (result as Student).age;
                              // _students[index].copyWith().phone =
                              //     (result as Student).phone;
                              // items.sort((a, b) => b.name.compareTo(a.name));
                              await sqliteController.updateStudent(student_cpw);
                              getListStudents();
                            }
                          });
                        },
                        child: Card(
                            child: Stack(children: [
                          ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://www.dungplus.com/wp-content/uploads/2019/12/girl-xinh-1-480x600.jpg"),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _students[index].name,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  Text(
                                    "Tuổi: ${_students[index].age.toString()}",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    "Số Điện Thoại: ${_students[index].phone.toString()}",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              )),
                          Positioned(
                              right: 0,
                              top: 4,
                              child: IconButton(
                                onPressed: () async {
                                  setState(() {
                                    sqliteController
                                        .deleteStudent(_students[index].id!);
                                  });
                                  getListStudents();
                                },
                                icon: Icon(Icons.delete),
                              ))
                        ])));
                  }))
        ])));
  }
}
