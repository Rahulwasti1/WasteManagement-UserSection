import 'package:flutter/material.dart';

class UserNews extends StatelessWidget {
  const UserNews({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample news data
    final List<Map<String, String>> newsItems = [
      {
        "title": "The Ocean’s Plastic Crisis",
        "description": "New Global Efforts to Remove Plastic from Oceans",
        "time": "Today",
        "image": "assets/ocean_plastic_cleanup.jpg"
      },
      {
        "title": "Urban Waste Wars",
        "description": "Cities Compete for Most Efficient Recycling Programs",
        "time": "3 hours ago",
        "image": "assets/urban_waste_management.jpg"
      },
      {
        "title": "E-Waste Epidemic",
        "description": "Rising Concerns Over Improper Disposal of Electronics",
        "time": "Yesterday",
        "image": "assets/e_waste_crisis.jpg"
      },
      {
        "title": "The Food Waste Fix",
        "description": "How Composting is Reducing Landfill Dependence",
        "time": "4 hours ago",
        "image": "assets/food_waste_solution.jpg"
      },
      {
        "title": "Tackling Textile Waste",
        "description": "Fashion Industry Takes Steps Toward Sustainability",
        "time": "5 days ago",
        "image": "assets/textile_waste_management.jpg"
      },
      {
        "title": "Waste to Energy Revolution",
        "description": "Innovative Plants Turning Trash Into Power",
        "time": "2 hours ago",
        "image": "assets/waste_to_energy.jpg"
      },
      {
        "title": "The Landfill Overflow",
        "description": "Stricter Regulations on Household Waste Disposal",
        "time": "Yesterday",
        "image": "assets/landfill_crisis.jpg"
      },
      {
        "title": "Recycling Robots to the Rescue",
        "description": "AI-Powered Machines Transform Waste Sorting",
        "time": "6 hours ago",
        "image": "assets/recycling_robotics.jpg"
      },
      {
        "title": "Rivers Choked With Trash",
        "description": "Clean-Up Projects Bring Hope to Polluted Waterways",
        "time": "Today",
        "image": "assets/river_trash_cleanup.jpg"
      },
      {
        "title": "Waste-Free Villages",
        "description": "Small Communities Leading the Zero-Waste Movement",
        "time": "1 week ago",
        "image": "assets/zero_waste_village.jpg"
      }
      // Add more items as needed
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          final item = newsItems[index];
          return ListTile(
            // leading: Image.asset(
            //   item['image']!,
            //   width: 30,
            //   height: 60,
            //   fit: BoxFit.cover,
            // ),
            title: Text(
              item['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${item['description']}\n${item['time']}'),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}
