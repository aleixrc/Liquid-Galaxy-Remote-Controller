// -------------------------------------------- MAIN ENTRY POINT --------------------------------------------
// File contains the main entry point for the Flutter app, sets up Providers and loads environment variables
// Basically it defines the root widget MyApp, which is used to control themes and the initial screen navigation

// ---------------------- Import packages ----------------------
import 'package:flutter/material.dart'; // Imports the library material.dart (which contains common widgets like buttons, text, etc.) from Flutter's SDK (Software Development Kit)
import 'package:provider/provider.dart'; // Imports the library provider.dart (which contains tools to manage the app state)
import 'providers/theme_provider.dart'; // Imports the file related to managing the light mode and the dark mode of the app
import 'providers/settings_provider.dart'; // Imports the file related to managing the text sizes
import 'screens/splash_screen.dart'; // Imports the first screen that loads when initializing the app, the splash screen in this case
import 'services/lg_service.dart'; // Imports the LG service screen, which handles the logic to connect to the Liquid Galaxy screen

// ---------------------- Main function ----------------------
// The entry point of the app
Future<void> main() async {
  // Defines an asynchronous method that does not return any value (void)
  // 'async' allows to use 'await' inside the function
  // It does not return any value because its function is to trigger a side-effect, not to return data

  WidgetsFlutterBinding.ensureInitialized();
  // Initializes all the Flutter framework and widgets before executing any code
  // WidgetsBinding is the class that manages communication between Dart and other platforms, as well as the widget tree

  // DELETED DOTENV LOAD

  runApp(
    // Starts the Flutter app by creating the widget tree
    // Must be called ONLY once
    // Is always the entry point after any setup

    MultiProvider(
      // Creates a widget that supplies multiple providers (objects holding shared state or logic)
      // All widgets in the subtree (the whole app, in this case) can access these providers

      providers: [
        // List of the available providers

        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Registers a ChangeNotifierProvider for the ThemeProvider class
        // ChangeNotifierProvider allows widgets to listen for changes
        // In this project, theme_provider.dart is the file in charge of managing the light mode and the dark mode
        // This means that, whenever a widget wants to access theme settings/state, it can listen to this provider
        // create: (_) => ThemeProvider() means ThemeProvider is created (instantiated) the FIRST time it is needed

        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        // Registers a ChangeNotifierProvider for the SettingsProvider class
        // ChangeNotifierProvider allows widgets to listen for changes
        // In this project, settings_provider.dart is the file in charge of managing the font sizes
        // This means that, whenever a widget wants to access theme settings/state, it can listen to this provider
        // create: (_) => SettingsProvider() means SettingsProvider is created (instantiated) the FIRST time it is needed

        ChangeNotifierProvider(create: (_) => LgService()),
        // Registers a ChangeNotifierProvider for the LgService class
        // ChangeNotifierProvider allows widgets to listen for changes
        // In this project, lg_service.dart is the file in charge of managing the font sizes
        // This means that, whenever a widget wants to access lg_service state (related to connection), it can listen to this provider
        // create: (_) => LgService() means LgService is created (instantiated) the FIRST time it is needed
      ],
      child: const MyApp(),
      // MyApp is the root widget of the application
      // A shortcut for this could be void main () => runApp();
      // '=>' is Dart's arrow syntax for functions with a single expression
    ),
  );
}

// ---------------------- MyApp widget ----------------------
class MyApp extends StatelessWidget {
  // MainScreen class is the root widget of the app's tree, and all other widgets are built from there
// This means that all the other parts of the app (buttons, text, etc) will be built from this starting point
// It extends StatelessWidget, which is a type of widget that never changes once it appears on the screen
// If we wanted the widget to react to the users actions or update automatically (for example, a counter), we would use StatefulWidget

  const MyApp({super.key});
  // 'super' indicates that, if this widget receives a key, it will be passed to the parent class so Flutter knows about it
  // This helps Flutter identify and track this widget when rebuilding the screen
  // It basically passes an optional key to the parent widget for identification during widget rebuilds

  // ---------------------- Build the screen interface ----------------------
  @override
  // @override is a line that indicates a method from the parent class is going to be replaced
  // In this case, we are replacing the build() method that comes from Flutter's State class
  // @override is not mandatory but it is really useful, as it helps catch mistakes
  // Dart will show an error if you try to override something that does not exist

  Widget build(BuildContext context) {
    // This function defines what the screen looks like, it is basically method used to build the UI of this widget
    // The parameter context gives access to theme, size, etc

    final settings = Provider.of<SettingsProvider>(context);
    // Access the current instance of SettingsProvider (a class from settings_provider.dart)
    // This class has information on the different font sizes for the text
    // Stores this instance in a variable called "settings"
    // final means this variable can only be assigned ONCE and will not change

    final theme = Provider.of<ThemeProvider>(context);
    // Access the current instance of ThemeProvider (a class from theme_provider.dart)
    // This class has information on the light mode and dark mode
    // Stores this instance in a variable called "theme"
    // final means this variable can only be assigned ONCE and will not change

    if (!theme.isInitialized || !settings.isInitialized) {
      // Checks if the app theme provider (theme) or the settings provider (settings) have not finished initializing
      // ! operator negates the value (this means !true = false)
      // If EITHER (|| means OR) theme.isInitialized or settings.isInitialized is false, this block will run
      // This is used to not show the main UI layout until both theme and settings are ready

      return const MaterialApp(
        // MaterialApp is a widget that seys up the whole app
        // It provides settings like navigation or themes
        // In this case, if the providers are not ready, minimal layout is shown

        home: Scaffold(
          // "home" is the first widget the user will see
          // In this case, if the providers are not ready, it shows a Scaffold
          // A Scaffold is a basic page layout that creates an structure for the screen

          body:
          // 'body' refers to the main content area of the screen

          Center(child: CircularProgressIndicator()),
          // "Center" centers all the widgets vertically and horizontally
          // CircularProgressIndicator is a built-in Flutter widget that shows a spinning circular loading animation
          // In this case, it is what is displayed if the providers are not ready
        ),
      );
    }

    return MaterialApp(
      // MaterialApp is a widget that seys up the whole app
      // It provides settings like navigation or themes

      // debugShowCheckedModeBanner: false,
      // This makes that Flutter does NOT show the red "DEBUG" banner that appears when running in debug mode
      // By default this banner is visible during development to remind that the app is running in debug mode
      // This line is optional, as it has no effect in release mode because the banner never appears in release builds

      title: 'LG Master Web App',
      // The name of the app

      themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // themeMode is a variable that stores the mode the app is using
      // For this, it uses a ternary operator, which works with the following structure:
      // condition ? valueIfTrue : valueIfFalse
      // This means that, in this case, if theme.isDarkMode == true, themeMode = ThemeMode.dark
      // And if theme.isDarkMode == false, themeMode = ThemeMode.light

      // For the look of the app (colours, fonts, etc)
      // ---- Light mode ----
      // The default mode
      theme: ThemeData(
        // primarySwatch: Colors.blue, // In this case, sets blue as the main color
        // But you can choose any colour you want

        brightness: Brightness.light,
        // Sets the overall brightness for the theme
        // Affects things like default text color and app UI base color

        primarySwatch: Colors.teal,
        // Sets the main/application color (used for buttons, progress bars, etc.)
        // I chose teal but you can choose any color

        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Visual density controls how compact or spacious UI elements appear
        // This line makes that Flutter uses a compact layout (less space between UI elements) on desktop
        // and the standard layout (default, more spacious) on mobile

        textTheme:
        // Customizes the default text appearance of the whole app

        Theme.of(context).textTheme.apply(
          // Theme.of(context).textTheme gets the current default text styles
          // .apply(...) customizes that theme

          fontSizeFactor: settings.fontSizeValue / 17.0,
          // Scales text size based on user preference (from SettingsProvider)
          // Divides by 17.0 because this is the default size specified in settings_provider.dart
          // This makes the scale factor 1.0
          // If the setting is 22.0 (the size specified in settings_provider.dart for large fonts), it makes fonts bigger
          // If the setting is 14.0 (the size specified in settings_provider.dart for small fonts), it makes fonts smaller
          // Makes the font size customizable, proportional to a default, and returns floating-point

          bodyColor: Colors.black,
          // Sets normal text color to black for legibility in light mode

          displayColor: Colors.black,
          // Sets big texts like headlines to black for legibility in light mode
        ),
      ),

      // ---- Dark mode ----
      darkTheme: ThemeData.dark().copyWith(
        // ThemeData.dark() provides the default Flutter dark colors and styles
        // .copyWith(...) creates a new object
        // This lets you override (customize) any properties you want without modifying the original object

        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Visual density controls how compact or spacious UI elements appear
        // This line makes that Flutter uses a compact layout (less space between UI elements) on desktop
        // and the standard layout (default, more spacious) on mobile

        textTheme:
        // Customizes the default text appearance of the whole app

        Theme.of(context).textTheme.apply(
          // Theme.of(context).textTheme gets the current default text styles
          // .apply(...) customizes that theme

          fontSizeFactor: settings.fontSizeValue / 17.0,
          // Scales text size based on user preference (from SettingsProvider)
          // Divides by 17.0 because this is the default size specified in settings_provider.dart
          // This makes the scale factor 1.0
          // If the setting is 22.0 (the size specified in settings_provider.dart for large fonts), it makes fonts bigger
          // If the setting is 14.0 (the size specified in settings_provider.dart for small fonts), it makes fonts smaller
          // Makes the font size customizable, proportional to a default, and returns floating-point

          bodyColor: Colors.white,
          // Sets normal text color to white for legibility in dark mode

          displayColor: Colors.white,
          // Sets big texts like headlines to white for legibility in dark mode
        ),
      ),

      // I CHANGED THE HOME TO THE NEW PAGE TO SKIP THE SPLASH SCREEN
      // THEREFORE, IT TAKES US DIRECTLY TO THE PAGE WHERE THE BUTTONS CODED BY ME (ALEIX CLIMENT) ARE
      home: const TaskPage(),
    );
  }
}

// TASK PAGE: THE MAIN CONTROL PANEL

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  // METHOD: SHOW SETTINGS DIALOG

  void _showSettingsDialog(BuildContext context) {
    // GET THE CURRENT SAVED VALUES
    // 'LISTEN: FALSE' IS USED BECAUSE WE DON'T NEED TO REBUILD THIS WIDGET WHEN DATA CHANGES HERE
    final lgService = Provider.of<LgService>(context, listen: false);
    final model = lgService.connectionModel;

    // CODE TO TAKE THE USER-INPUTTED "CREDENTIALS" INTO ACCOUNT
    final ipController = TextEditingController(text: model.ip);
    final userController = TextEditingController(text: model.username);
    final passController = TextEditingController(text: model.password);
    final portController = TextEditingController(text: model.port.toString());
    final screensController = TextEditingController(text: model.screens.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connection Settings'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // INPUT FIELDS FOR EACH SETTING
                TextField(controller: ipController, decoration: const InputDecoration(labelText: 'IP Address'), keyboardType: TextInputType.number),
                TextField(controller: userController, decoration: const InputDecoration(labelText: 'Username')),
                TextField(controller: passController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                TextField(controller: portController, decoration: const InputDecoration(labelText: 'Port'), keyboardType: TextInputType.number),
                TextField(controller: screensController, decoration: const InputDecoration(labelText: 'Number of Screens'), keyboardType: TextInputType.number),
              ],
            ),
          ),
          actions: <Widget>[
            // CANCEL BUTTON: CLOSES THE DIALOG WITHOUT SAVING
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // SAVE BUTTON: UPDATES THE SERVICE AND SAVES TO PHONE MEMORY
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                // UPDATE THE SERVICE WITH THE NEW VALUES WRITTEN BY THE USER
                lgService.updateConnectionSettings(
                  ip: ipController.text,
                  username: userController.text,
                  password: passController.text,
                  port: int.tryParse(portController.text) ?? 22,
                  screens: int.tryParse(screensController.text) ?? 3,
                );
                // SAVE THESE VALUES PERMANENTLY TO PREFERENCES
                lgService.connectionModel.saveToPreferences();

                // CLOSE DIALOG AND SHOW SUCCESS MESSAGE
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings Saved!')));
              },
            ),
          ],
        );
      },
    );
  }

  // BUILD METHOD: DEFINES THE UI OF THE PAGE
  @override
  Widget build(BuildContext context) {
    // WE GET THE SHARED INSTANCE OF LGSERVICE FROM THE PROVIDER SO WE USE THE SAME CONNECTION FOR ALL BUTTONS
    final lgService = Provider.of<LgService>(context, listen: false);

    return Scaffold(
      // APP BAR WITH TITLE AND SETTINGS BUTTON
      appBar: AppBar(
        title: const Text(
          "LG GSOC TASK 2: BASIC FLUTTER APP",
          // TEXT WOULDN'T FIT IF ITS SIZE WAS ABOVE 18
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(context),
            tooltip: 'Connection Settings',
          ),
        ],
      ),

      // MAIN BODY: A CENTERED COLUMN WITH ALL THE BUTTONS
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // BUTTON 1: CONNECT TO LG
            // ESTABLISHES THE CONNECTION TO THE SSH CLIENT USING CREDENTIALS INPUTTED BY THE USER
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              onPressed: () async {
                // WE USE THE 'lgService' VARIABLE WE DEFINED ABOVE
                await lgService.initializeConnection();

                // CHECK CONNECTION STATUS TO SHOW FEEDBACK
                if (context.mounted) {
                  bool isConnected = lgService.isConnected;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isConnected ? 'Connection Success!' : 'Connection Failed'),
                      backgroundColor: isConnected ? Colors.green : Colors.red,
                    ),
                  );
                }
              },
              //TEXT INSIDE OF THE BUTTON
              child: const Text('Connect to LG', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 20),

            // BUTTON 2: SHOW LG LOGO

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              // SENDS THE LOGO KML TO THE LEFTMOST SCREEN
              onPressed: () async => await lgService.sendLogo(),

              child: const Text('Show LG Logo', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 20),

            // BUTTON 3: SHOW 3D PYRAMID
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              // SENDS THE PYRAMID KML TO THE CENTER SCREEN
              onPressed: () async => await lgService.sendPyramid(),
              child: const Text('Show 3D Pyramid', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 20),

            // BUTTON 4: FLY TO XÀTIVA
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              // SENDS A 'FLYTO' COMMAND TO MOVE THE CAMERA
              onPressed: () async => await lgService.flyToXativa(),
              child: const Text('Fly to Xàtiva', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 40),

            // BUTTON 5: CLEAN LOGOS
            // SEND A BLANK KML TO THE SLAVE SCREEN TO REMOVE THE LOGO
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              onPressed: () async => await lgService.cleanLogos(),
              child: const Text('Clean Logos', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 20),

            // BUTTON 6: CLEAN KMLS
            // EMPTIES THE KMLS.TXT FILE TO RMEOVE THE PYRAMID
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              onPressed: () async => await lgService.cleanKML(),
              child: const Text('Clean KMLs', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}