import 'package:chat_app/pages/login/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int language = 0;
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/images/avatar.jpg",
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Trần Ngọc Tiến",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.black54,
                          ),
                        );
                      }),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Đây là phần mô tả viết đại dùng để test UI, không có gì ở đây hết",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const Divider(
                  color: Colors.black54,
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _showBottomSheet();
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(233, 116, 81, 1),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.translate_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text("Language", style: TextStyle(fontSize: 18)),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        FontAwesomeIcons.solidMoon,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("Dark Mode", style: TextStyle(fontSize: 18)),
                    const Spacer(),
                    FlutterSwitch(
                      height: 30,
                      width: 60,
                      value: darkMode,
                      onToggle: (value) {
                        setState(() => darkMode = value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _showBottomSheet();
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(79, 121, 66, 1),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          FontAwesomeIcons.circleInfo,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text("About", style: TextStyle(fontSize: 18)),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                customButton(onPress: () {}, text: "Log out")
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(left: 20),
          width: double.infinity,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/vietnam.png", width: 70),
                    const Spacer(),
                    const Text(
                      "Tiếng Việt",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Radio(
                      value: 0,
                      groupValue: language,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/english.png", width: 70),
                    const Spacer(),
                    const Text(
                      "English",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Radio(
                      value: 1,
                      groupValue: language,
                      onChanged: (value) {},
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
