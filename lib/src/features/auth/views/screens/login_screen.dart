import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indentsystem/src/features/auth/logic/cubit/auth_cubit.dart';
import 'package:indentsystem/src/features/home/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  static route() => MaterialPageRoute(builder: (_) => const LoginScreen());

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool _loading = false;

  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [theme.primaryColor, theme.primaryColorDark],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height / 20, 0, 0),
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/logo_indent_system.png',
                  width: 200, height: 120)),
          ListView(
            children: <Widget>[
              // create form login
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(
                    32, MediaQuery.of(context).size.height / 3.5 - 72, 32, 0),
                color: Colors.white,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => setState(() {
                            _email = value;
                          }),
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[600]!)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: theme.primaryColorDark),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.grey[700])),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[600]!)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: theme.primaryColorDark),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey[700]),
                            suffixIcon: IconButton(
                                icon: Icon(_iconVisible,
                                    color: Colors.grey[700], size: 20),
                                onPressed: () {
                                  _toggleObscureText();
                                }),
                          ),
                          onChanged: (value) => setState(() {
                            _password = value;
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: 'Click forgot password',
                                  toastLength: Toast.LENGTH_SHORT);
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) =>
                                      theme.primaryColor,
                                ),
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                              ),
                              onPressed: () {
                                _login(context);
                                //Fluttertoast.showToast(msg: 'Click login', toastLength: Toast.LENGTH_SHORT);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _login(BuildContext context) {
    final bloc = context.read<AuthCubit>();

    _loginWith(
      context,
      () => bloc.authenticate(
        _email,
        _password,
      ),
    );
  }

  _loginWith(BuildContext context, Future<void> Function() method) async {
    if (_loading) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await method();

      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (route) => false,
      );
    } finally {
      setState(() {
        _loading = false;
      });

      // _passwordController.text = '';
    }
  }
}
