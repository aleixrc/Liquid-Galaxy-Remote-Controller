import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/lg_service.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  // 1. Pyramid KML (Located in Xativa)
  // I defined the coordinates for Xativa so it appears there.
  final String _kmlPyramid = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>Xativa Pyramid</name>
    <Placemark>
      <name>Pyramid</name>
      <Style>
        <PolyStyle>
          <color>ff0000ff</color> <outline>1</outline>
        </PolyStyle>
      </Style>
      <Polygon>
        <extrude>1</extrude> <altitudeMode>relativeToGround</altitudeMode>
        <outerBoundaryIs>
          <LinearRing>
            <coordinates>
              -0.5260,38.9890,0
              -0.5250,38.9890,0
              -0.5255,38.9900,100  -0.5260,38.9890,0
            </coordinates>
          </LinearRing>
        </outerBoundaryIs>
      </Polygon>
    </Placemark>
  </Document>
</kml>
''';

  // 2. FlyTo Command to go to Xativa
  // Coordinates adjusted to focus on the pyramid location.
  final String _flyToXativa = '<LookAt>'
      '<longitude>-0.5255</longitude>'
      '<latitude>38.9890</latitude>'
      '<altitude>0</altitude>'
      '<heading>0</heading>'
      '<tilt>45</tilt>'
      '<range>2000</range>'
      '<altitudeMode>relativeToGround</altitudeMode>'
      '</LookAt>';

  @override
  Widget build(BuildContext context) {
    // Access the Liquid Galaxy Service to handle SSH connections
    final lgService = Provider.of<LgService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GSoC Task 2 - Xativa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Extra Button: Connect (Necessary to start sending commands)
            ElevatedButton(
              onPressed: () {
                lgService.initializeConnection();
              },
              child: const Text('Connect to LG'),
            ),
            
            const SizedBox(height: 20), // Empty space for separation

            // Task 1: Send Logo
            ElevatedButton(
              onPressed: () {
                lgService.sendLogo();
              },
              child: const Text('Send LG Logo'),
            ),

            // Task 2: Send 3D Pyramid
            ElevatedButton(
              onPressed: () {
                // Sends the KML string defined above with the name 'xativa_pyramid'
                lgService.uploadKml(_kmlPyramid, 'xativa_pyramid');
              },
              child: const Text('Send 3D Pyramid'),
            ),

            // Task 3: Fly to Xativa (FlyTo)
            ElevatedButton(
              onPressed: () {
                lgService.flyTo(_flyToXativa);
              },
              child: const Text('Fly to Xativa'),
            ),

            const SizedBox(height: 20), // Empty space to separate cleaning actions

            // Task 4: Clean Logos
            ElevatedButton(
              onPressed: () {
                lgService.cleanLogos();
              },
              child: const Text('Clean Logos'),
            ),

            // Task 5: Clean KMLs (Removes the pyramid)
            ElevatedButton(
              onPressed: () {
                lgService.cleanKML();
              },
              child: const Text('Clean KMLs'),
            ),
          ],
        ),
      ),
    );
  }
}