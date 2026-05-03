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

  // Critical: Resetting the Future is required for the UI to update to an Error state
  void _refreshData() {
    setState(() {
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

          // If snapshots has an error, show the error UI
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(snapshot.error.toString(), style: const TextStyle(color: Colors.red)),
                  ElevatedButton(onPressed: _refreshData, child: const Text('Retry'))
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            final countries = snapshot.data!;
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return ListTile(
                  leading: Image.network(country.flagUrl, width: 40),
                  title: Text(country.name),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(country: country))
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Empty list'));
        },
      ),
    );
  }
}