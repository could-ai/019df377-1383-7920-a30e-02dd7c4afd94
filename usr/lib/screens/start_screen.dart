import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Icon(
                  Icons.build_circle,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'TOOLVAULT PRO',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 36,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'The ultimate tool inventory and management system for professional mechanics and shops.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/dashboard');
                },
                icon: const Icon(Icons.dashboard),
                label: const Text('ENTER VAULT'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/upgrade');
                },
                icon: const Icon(Icons.workspace_premium),
                label: const Text('UNLOCK PRO'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
