import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vallassignment/events/screens/events_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../repository/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoading) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);
          }

          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successful')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const EventsScreen()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.blue.shade200,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/vall_icon.webp'),
                      ),
                      const SizedBox(height: 24.0),
                      Card(
                        elevation: 3,
                        surfaceTintColor: Colors.blue.shade500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const Text(
                                  'Welcome Back',
                                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20.0),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  obscureText: true,
                                  validator: (value) => value!.length < 6 ? 'Password should be at least 6 characters' : null,
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      backgroundColor: Colors.blue.shade400,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(LoginUserEvent(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text.trim(),
                                        ));
                                      }
                                    },
                                    child: _isLoading
                                        ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    )
                                        : const Text(
                                      'Sign In',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Don't have an account?", style: TextStyle(fontSize: 18.0),),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Sign Up', style: TextStyle(fontSize: 18.0),),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
