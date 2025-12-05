import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_state_provider.dart';
import '/config.dart';
import './widgets/linktext.dart';
import './widgets/appbardefault.dart';
import 'dart:developer' as developer;

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: AppConfig.appName,
        subtitle: AppConfig.slogan,
        isLogin: true,
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.woman, size: 30),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.woman, size: 30),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 40),

            const Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.grey,
            ),

            const SizedBox(height: 30),

            TextField(
              onChanged: (v) => developer.log(
                'digitou: $v',
                name: 'TextFieldLogger',
              ),
              decoration: InputDecoration(
                labelText: AppConfig.userFieldLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              decoration: InputDecoration(
                labelText: AppConfig.passwordFieldLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: LinkText(
                text: "Esqueceu sua senha?",
                color: AppConfig.secondaryColor,
                onTap: () {},
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(appStateProvider.notifier).setUser("admin");

                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.secondaryColor,
                  foregroundColor: AppConfig.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  AppConfig.loginButtonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConfig.backgroundColor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: RichLinkText(
                normalText: "Não tem uma conta? ",
                highlightedText: "Inscreva-se",
                normalColor: AppConfig.secondaryColor,
                highlightedColor: AppConfig.primaryColor,
                onTap: () {},
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
