import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/mock_data_service.dart';
import '../models/item.dart';
import 'item_details_screen.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(37.4275, -122.1697);
  Set<Marker> _buildMarkers(List<Item> items) {
    return items.map((item) {
      return Marker(
        markerId: MarkerId(item.id),
        position: LatLng(item.latitude, item.longitude),
        infoWindow: InfoWindow(
          title: item.title,
          snippet: item.location,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ItemDetailsScreen(item: item)),
            );
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          item.isFound ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final items = MockDataService.getMockItems();
    return Scaffold(
      appBar: AppBar(title: const Text('Map View')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _center, zoom: 16),
        markers: _buildMarkers(items),
        onMapCreated: (controller) => _mapController = controller,
        myLocationEnabled: false,
        mapType: MapType.normal,
      ),
    );
  }
}
