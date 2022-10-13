// import 'package:flutter/material.dart';

// class SignUp extends StatefulWidget {
//   const  SignUp({Key? key}) : super(key: key);

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         const Text('SIGN IN'),
//         TextField(
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: 'Phone number',
//           ),
//           controller: _userIdController,
//           keyboardType: TextInputType.phone,
//           // 10 digits phone number constraint
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//             LengthLimitingTextInputFormatter(10),
//             ],
//         ),
//         TextField(
//           decoration:  InputDecoration(
//             border: const OutlineInputBorder(),
//             hintText: 'password',
//             suffixIcon: IconButton(onPressed: (){
//               setState(() {
//                 _passwordVisible = !_passwordVisible;
//               });
//             }, icon: Icon(_passwordVisible ? Icons.visibility :Icons.visibility_off))
//           ),
//           controller: _passwordController,
//           obscureText: _passwordVisible,
//           obscuringCharacter: '•',
//           enableSuggestions: false,
//           autocorrect: false,
//         ),
//         TextButton(onPressed: () {}, child: const Text('Forgot password?')),
//         ElevatedButton(onPressed: () {
//           Auth.getInstance().signInWithPhoneNumber(_userIdController.text);
//         }, child: const Text('Sign In')),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Don\'t have an account?'),
//             TextButton(onPressed: () {}, child: const Text('Sign up')),
//           ],
//         ),
//         const Text('Or'),
//         SizedBox(
//           width: 240,
//           child: ElevatedButton(
//               onPressed: () {},
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   const FaIcon(FontAwesomeIcons.google),
//                   Container(
//                       height: 25,
//                       width: 1,
//                       decoration: const BoxDecoration(
//                         color: Colors.black,
//                       )),
//                   const Text('Login with Google')
//                 ],
//               )),
//         ),
//       ],
//     ));
//   }
// }