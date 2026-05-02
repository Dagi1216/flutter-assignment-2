import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/country_api_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Country>> _countriesFuture;
  final CountryApiService _service = CountryApiService();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      // IMPORTANT: Assigning a new Future triggers the FutureBuilder to rebuild
      // and enter the 'waiting' or 'error' state correctly.
      _countriesFuture = _service.fetchAllCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: FutureBuilder<List<Country>>(
        future: _countriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(snapshot.error.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: _refreshData,
                      child: const Text('Try Again')
                  )
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            final countries = snapshot.data!;
            return ListView.separated(
              itemCount: countries.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final country = countries[index];
                return ListTile(
                  leading: Image.network(country.flagUrl, width: 45),
                  title: Text(country.name),
                  subtitle: Text(country.capital),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(country: country))
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No countries found.'));
        },
      ),
    );
  }
}