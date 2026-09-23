// Snigdha Addagarla - Student ID: 002801863
// Sai Athota - Student ID: 002858863

import 'package:flutter/material.dart';

// ============================================================================
// 1. MAIN ENTRY POINT
// ============================================================================
void main() {
  runApp(const TactileDeckApp());
}

// ============================================================================
// 2. ROOT APPLICATION WIDGET (Manages Global Theme State)
// ============================================================================
class TactileDeckApp extends StatefulWidget {
  const TactileDeckApp({super.key});

  @override
  State<TactileDeckApp> createState() => _TactileDeckAppState();
}

class _TactileDeckAppState extends State<TactileDeckApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superhero Command Deck',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: ControlDeckScreen(
        isDark: isDarkMode,
        onToggleTheme: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

// ============================================================================
// 3. MAIN DASHBOARD SCREEN (Stateful Controller)
// ============================================================================
class ControlDeckScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ControlDeckScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ControlDeckScreen> createState() => _ControlDeckScreenState();
}

class _ControlDeckScreenState extends State<ControlDeckScreen> {
  // --- Mutable State Variables ---
  int energy = 100;
  int rescues = 0;
  double chargeLevel = 0;
  bool shieldActive = false;
  String heroStatus = "ON PATROL";

  // Laser Blast costs 25 energy
  void _laserBlast() {
    if (energy >= 25) {
      setState(() {
        energy -= 25;
        heroStatus = "LASER BLAST FIRED!";
      });
    } else {
      setState(() {
        heroStatus = "NOT ENOUGH ENERGY!";
      });
    }
  }

  // Forcefield costs 15 energy
  void _forcefield() {
    if (energy >= 15) {
      setState(() {
        energy -= 15;
        shieldActive = !shieldActive;
        heroStatus = shieldActive
            ? "FORCEFIELD ACTIVATED!"
            : "FORCEFIELD DEACTIVATED";
      });
    } else {
      setState(() {
        heroStatus = "NOT ENOUGH ENERGY!";
      });
    }
  }

  // Rescue adds 1 to the rescue count
  void _rescue() {
    setState(() {
      rescues++;
      heroStatus = rescues >= 3 ? "CITY SAVED!" : "CIVILIAN RESCUED!";
    });
  }

  // Recharge restores energy
  void _recharge() {
    setState(() {
      energy = 100;
      heroStatus = "ENERGY FULLY RECHARGED!";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenBg = widget.isDark
        ? const Color(0xFF10131C)
        : const Color(0xFFEAF2FF);

    final cardBg = widget.isDark
        ? const Color(0xFF1D2330)
        : Colors.white;

    final accentColor = rescues >= 3
        ? Colors.greenAccent
        : Colors.blueAccent;

    return Scaffold(
      backgroundColor: screenBg,

      appBar: AppBar(
        title: const Text(
          "🦸 SUPERHERO COMMAND DECK",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 17,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: 'Toggle Theme',
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Column(
          children: [
            // ================================================================
            // STATUS HEADER
            // ================================================================
            const HeroTitle(),

            const SizedBox(height: 18),

            // ================================================================
            // METRICS CARD
            // ================================================================
            MetricsCard(
              energy: energy,
              rescues: rescues,
              cardColor: cardBg,
              accentColor: accentColor,
            ),

            const SizedBox(height: 18),

            // ================================================================
            // CITY SAVED CONDITION
            // ================================================================
            if (rescues >= 3)
              const CitySavedBanner(),

            if (rescues >= 3)
              const SizedBox(height: 18),

            // ================================================================
            // HERO STATUS
            // ================================================================
            StatusCard(
              status: heroStatus,
              shieldActive: shieldActive,
              accentColor: accentColor,
              cardColor: cardBg,
            ),

            const SizedBox(height: 25),

            // ================================================================
            // SUPERHERO ACTION BUTTONS
            // ================================================================
            Wrap(
              spacing: 18,
              runSpacing: 18,
              alignment: WrapAlignment.center,
              children: [
                TactileButton(
                  icon: Icons.flash_on,
                  label: "LASER BLAST",
                  accentColor: Colors.redAccent,
                  isDark: widget.isDark,
                  onPressed: _laserBlast,
                ),

                TactileButton(
                  icon: Icons.shield,
                  label: "FORCEFIELD",
                  accentColor: Colors.blueAccent,
                  isDark: widget.isDark,
                  onPressed: _forcefield,
                ),

                TactileButton(
                  icon: Icons.health_and_safety,
                  label: "RESCUE",
                  accentColor: Colors.greenAccent,
                  isDark: widget.isDark,
                  onPressed: _rescue,
                ),

                TactileButton(
                  icon: Icons.battery_charging_full,
                  label: "RECHARGE",
                  accentColor: Colors.amberAccent,
                  isDark: widget.isDark,
                  onPressed: _recharge,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ================================================================
            // LASER CHARGE SLIDER
            // ================================================================
            const Text(
              "LASER CHARGE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "${chargeLevel.toInt()}%",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),

            Slider(
              value: chargeLevel,
              min: 0,
              max: 100,
              activeColor: accentColor,
              onChanged: (newVal) {
                setState(() {
                  chargeLevel = newVal;
                });
              },
            ),

            const SizedBox(height: 20),

            // ================================================================
            // ENERGY BAR
            // ================================================================
            const Text(
              "ENERGY CORE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: energy / 100,
              minHeight: 12,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey.withOpacity(0.25),
              color: energy <= 25
                  ? Colors.redAccent
                  : Colors.blueAccent,
            ),

            const SizedBox(height: 8),

            Text(
              "$energy / 100 ENERGY",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            const InfoCard(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 4. STATELESS WIDGET #1 - HERO TITLE
// ============================================================================

class HeroTitle extends StatelessWidget {
  const HeroTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          Icons.shield_moon,
          size: 55,
          color: Colors.blueAccent,
        ),
        SizedBox(height: 8),
        Text(
          "CITY EMERGENCY RESPONSE",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 5. STATELESS WIDGET #2 - METRICS CARD
// ============================================================================

class MetricsCard extends StatelessWidget {
  final int energy;
  final int rescues;
  final Color cardColor;
  final Color accentColor;

  const MetricsCard({
    super.key,
    required this.energy,
    required this.rescues,
    required this.cardColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                "ENERGY",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "$energy",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),

          Container(
            width: 1,
            height: 45,
            color: Colors.grey.withOpacity(0.3),
          ),

          Column(
            children: [
              const Text(
                "RESCUES",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "$rescues",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent.shade400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. STATELESS WIDGET #3 - STATUS CARD
// ============================================================================

class StatusCard extends StatelessWidget {
  final String status;
  final bool shieldActive;
  final Color accentColor;
  final Color cardColor;

  const StatusCard({
    super.key,
    required this.status,
    required this.shieldActive,
    required this.accentColor,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: shieldActive
              ? Colors.blueAccent
              : accentColor.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            "HERO STATUS",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
          if (shieldActive) ...[
            const SizedBox(height: 8),
            const Text(
              "🛡️ FORCEFIELD ACTIVE",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================================
// 7. STATELESS WIDGET #4 - CITY SAVED BANNER
// ============================================================================

class CitySavedBanner extends StatelessWidget {
  const CitySavedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.green,
            Colors.teal,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.4),
            blurRadius: 15,
          ),
        ],
      ),
      child: const Column(
        children: [
          Text(
            "🏆 CITY SAVED! 🏆",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Great work, hero!",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. CUSTOM STATEFUL TACTILE BUTTON
// ============================================================================

class TactileButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color accentColor;
  final bool isDark;
  final VoidCallback onPressed;

  const TactileButton({
    super.key,
    required this.icon,
    required this.label,
    required this.accentColor,
    required this.isDark,
    required this.onPressed,
  });

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isDark
        ? const Color(0xFF202532)
        : const Color(0xFFE5ECF5);

    final darkShadow = widget.isDark
        ? Colors.black87
        : const Color(0xFFA3B1C6);

    final lightShadow = widget.isDark
        ? const Color(0xFF343B4D)
        : Colors.white;

    return GestureDetector(
      // User touches button -> depress button
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },

      // User releases button -> restore and trigger action
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });

        widget.onPressed();
      },

      // Cancel safely restores button
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 145,
        height: 125,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(22),

          // Pressed = smaller shadows = sunken
          // Unpressed = larger shadows = raised
          boxShadow: isPressed
              ? [
            BoxShadow(
              color: darkShadow.withOpacity(0.5),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: lightShadow.withOpacity(0.5),
              offset: const Offset(-2, -2),
              blurRadius: 4,
            ),
          ]
              : [
            BoxShadow(
              color: darkShadow.withOpacity(0.7),
              offset: const Offset(8, 8),
              blurRadius: 16,
            ),
            BoxShadow(
              color: lightShadow.withOpacity(0.9),
              offset: const Offset(-8, -8),
              blurRadius: 16,
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: isPressed ? 38 : 46,
              color: isPressed
                  ? widget.accentColor
                  : (widget.isDark
                  ? Colors.white70
                  : Colors.black87),
            ),

            const SizedBox(height: 8),

            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 0.8,
                color: isPressed
                    ? widget.accentColor
                    : (widget.isDark
                    ? Colors.white60
                    : Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 9. STATELESS INFO CARD
// ============================================================================

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "LASER: -25 ENERGY   •   FORCEFIELD: -15 ENERGY   •   RESCUE: +1",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
