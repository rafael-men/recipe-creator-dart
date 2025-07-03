import 'package:flutter/material.dart';
import 'package:my_recipe_book/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                color: Colors.white.withOpacity(0.95),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Bem-vindo(a) de volta!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoSlab',
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_error != null)
                        Text(_error!,
                            style: const TextStyle(color: Colors.red, fontSize: 14)),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _passController,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      _loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B0000),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  textStyle: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _loading = true;
                                    _error = null;
                                  });
                                  try {
                                    await auth.signIn(_emailController.text.trim(),
                                        _passController.text.trim());
                                  } catch (e) {
                                    setState(() {
                                      _error = e.toString();
                                    });
                                  } finally {
                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                },
                                child: const Text('Entrar'),
                              ),
                            ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child:  Text('Criar conta',style: const TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
