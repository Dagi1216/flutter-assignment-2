Mobile Application Development
# Country Explorer - Assignment 2
Name Dagim Melese 
ID ATE/4246/15

          Project Description
This is a Flutter-based mobile application that interacts with the [RestCountries API](https://restcountries.com/). 
The app allows users to explore countries, view specific details about them, and search for specific nations.

        Features & Requirements Met
- Track Selection: Track A (Country Explorer).
- Network Implementation: Uses the http package to fetch JSON data from a REST API.
- Three UI States:
    1. Loading State: Displays a CircularProgressIndicator while fetching data.
    2. Data State: Displays a scrollable list of countries with flags and names.
    3. Error State: Displays a custom error message and "Retry" button when there is no internet or the API fails.
- Navigation: Implements a Master-Detail pattern (clicking a country leads to a Detail Screen).
- Search: A dedicated search screen to filter results.
- Git History: Contains 5+ meaningful commits documenting the development process.

             Project Structure
- lib/
 ├── models/     # Data models (JSON parsing)
 ├── screens/    # UI Screens (Home, Detail, Search)
 ├── services/   # Network logic and Exception handling
 └── main.dart   # App entry point
