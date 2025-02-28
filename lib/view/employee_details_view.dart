import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/employeeInfoModel.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final EmployeeInfoModel employee;

  const EmployeeDetailsPage({Key? key, required this.employee}) : super(key: key);

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Employee Details"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: CachedNetworkImageProvider(employee.profileImage),
            ),
            SizedBox(height: 16),

            Text(
              employee.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 4),

            Text(
              employee.email,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),

            Divider(height: 32, thickness: 1),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow(Icons.phone, "Phone", employee.phone),
                    _infoRow(Icons.location_on, "Address", employee.address),
                    _infoRow(Icons.business, "Company", employee.companyName),
                    _infoRow(Icons.info, "Company Details", employee.companyDetails),
                    GestureDetector(
                      onTap: () => _launchURL(employee.website),
                      child: _infoRow(Icons.language, "Website", employee.website, isLink: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orangeAccent, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "$title: ${isLink ? 'Tap to Open' : value}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isLink ? Colors.blue : Colors.black87),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
