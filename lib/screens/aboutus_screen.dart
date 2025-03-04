import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the system theme colors
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Define colors based on theme
    final primaryColor = theme.primaryColor; // App's primary color
    final textColor = isDarkMode ? Colors.white : Colors.black87; // Adapts to theme
    final secondaryTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[700]; // Subtle text color
    final dividerColor = theme.dividerColor;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Image with Overlay
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/test1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5), // Dark overlay
                  child: Center(
                    child: Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // About Us Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // "Who We Are" Section
                  Text(
                    "Who We Are",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We are a leading company dedicated to providing top-notch solutions "
                        "for our clients. Our mission is to innovate and deliver exceptional products "
                        "that enhance your experience.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryTextColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: dividerColor),
                  const SizedBox(height: 24),

                  // Mission Section
                  Icon(
                    Icons.flag,
                    size: 64,
                    color: textColor, // Use textColor for theme-based adaptation
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Our Mission",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "To empower businesses and individuals with cutting-edge "
                        "technology and make a positive impact on the world.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryTextColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: dividerColor),
                  const SizedBox(height: 24),

                  // Vision Section
                  Icon(
                    Icons.visibility,
                    size: 64,
                    color: textColor, // Use textColor for theme-based adaptation
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Our Vision",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "To be the most trusted and innovative partner for businesses "
                        "worldwide, driving success through collaboration and innovation.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryTextColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: dividerColor),
                  const SizedBox(height: 24),

                  // Contact Section
                  Text(
                    "Get in Touch",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Email: support@company.com\nPhone: +9075135648",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
