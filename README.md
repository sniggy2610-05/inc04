Flutter Widget Wars - Superhero Deck
Team Members
Snigdha Addagarla - Student ID: 002801863
Sai Athota - Student ID: 002858863
Build Challenge
Theme: Superhero Deck 🦸
We transformed the starter Flutter app into a superhero command deck where users can manage energy, activate powers, and rescue civilians.

State Variables
int energy = 100;
int rescues = 0;
double chargeLevel = 0;
bool shieldActive = false;
String heroStatus = "ON PATROL";

Actions
Laser Blast: Costs 25 energy.
Forcefield: Costs 15 energy and activates/deactivates the shield.
Rescue: Adds 1 to the rescue counter.
Recharge: Restores energy to 100.
Laser Charge Slider: Updates the charge percentage using setState().
Special Condition
When the rescue counter reaches 3, the app displays:
🏆 CITY SAVED! 🏆

The interface also changes its accent color to green when the city is saved.
6 Mandatory Architectural Checkpoints
1. Minimum 2 StatelessWidgets
   The app includes multiple StatelessWidgets, including:
   HeroTitle
   MetricsCard
   StatusCard
   CitySavedBanner
   InfoCard
2. Minimum 1 Custom StatefulWidget
   TactileButton is a custom StatefulWidget that manages its own isPressed state.
3. Interactive Buttons
   The app includes four functional buttons:
   Laser Blast
   Forcefield
   Rescue
   Recharge
   Each button performs a different action.
4. Dynamic Counter / Meter
   The energy, rescue counter, and laser charge update in real time using setState().
5. Theme Color Switcher
   The app has a light/dark mode toggle that changes the overall theme.
6. GestureDetector Interaction
   The TactileButton uses GestureDetector with onTapDown, onTapUp, and onTapCancel to create a tactile pressed/sunken effect.
   Condition Demonstration
   The main condition is:
   if (rescues >= 3)

After three rescues, the app displays the CITY SAVED! banner and changes the accent color.
Screenshot Evidence
Insert screenshot here showing the running app after 3 rescues with "CITY SAVED!" visible.
