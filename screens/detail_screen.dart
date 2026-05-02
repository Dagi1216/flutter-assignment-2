import 'package:flutter/material.dart';
import '../models/country.dart';

class DetailScreen extends StatelessWidget {
  final Country country;
  const DetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.network(country.flagUrl, height: 120),
            const SizedBox(height: 20),
            Text('Region: ${country.region}', style: const TextStyle(fontSize: 18)),
            Text('Population: ${country.population}'),
          ],
        ),
      ),
    );
  }
}