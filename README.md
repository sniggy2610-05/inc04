Activity 04 - Flutter Widget Wars
Team Members
Team Name: Superhero!!
Snigdha Addagarla - Student ID: 002801863
Sai Athota - Student ID: 002858863
Google Doc: [Paste your shared Google Doc link here]
How to Run
Open the inc04 Flutter project in VS Code or Android Studio.
Make sure Flutter is installed and connected to an emulator or browser.
Run:
flutter pub get
flutter run

The app will open as the Superhero Deck.
Build Challenge
Theme: Superhero Deck 🦸
For Round 3, we changed the starter app into a superhero control panel. Users can use different powers, rescue civilians, manage their energy, and charge the laser.
The main state variables are:

int energy = 100;
int rescues = 0;
double chargeLevel = 0;
bool shieldActive = false;
String heroStatus = "ON PATROL";

The main actions are:
Laser Blast uses 25 energy.
Forcefield uses 15 energy.
Rescue increases the rescue counter.
Recharge restores energy.
Laser Charge uses a slider to update the charge level.
Our main condition is that after 3 rescues, the app displays "CITY SAVED!" and changes the colors to show that the goal has been completed.
The app also has light/dark mode, interactive buttons, a dynamic energy meter, and tactile button animations.

State Defense
What widgets are Stateless and why?
Our reusable display widgets are StatelessWidgets because they mainly display information passed to them and do not need to manage their own changing state.
What widget is Stateful and what private variables does it own?
Our TactileButton is a StatefulWidget because each button needs to remember whether it is currently being pressed. Its State class owns the isPressed variable.
Our main dashboard is also Stateful because it manages changing values such as energy, rescues, charge level, shield status, and hero status.

Where is setState() invoked and what UI element rebuilds?
We use setState() when the user performs an action or changes the slider. This tells Flutter that the state changed and causes the dashboard UI to rebuild, including the energy meter, rescue counter, status text, and laser charge display.
Round 1 Findings
State Identification Blitz
Team Name: Superhero!!
Scenario 1 - PriceTag: STATELESS - Correct
Scenario 2 - LikeToggle: STATEFUL - Correct
Scenario 3 - MenuActionTile: STATELESS - Correct
Scenario 4 - SearchField: STATEFUL - Correct
Scenario 5 - StatBadge: STATELESS - Correct
Scenario 6 - PulsingDot: STATEFUL - Correct
Final Score: 6 / 6
Round 2 Bug Fixes
Bug 1 - Shared Pressed State
The shared isPressed state was stored in _ControlDeckScreenState instead of inside each TactileButton. Because all four buttons used the same variable, pressing one button caused all four buttons to react.
Fix: The isPressed state was moved into the individual TactileButton State class so each button manages its own pressed state.

Bug 2 - Missing setState()
The slider changed powerLevel in memory, but without setState(), Flutter did not know that the UI needed to rebuild. This caused the displayed value to stay the same.
Fix:

onChanged: (newVal) => setState(() => powerLevel = newVal),

Bug 3 - Geometry Inversion
The pressed and unpressed shadow values were reversed. The larger shadows made the button look raised when it was pressed instead of making it look sunken.
Fix: The smaller shadow offsets are used when pressed, while the larger offsets are used when unpressed.

Bug 4 - Callback Timing
onTapDown should only create the pressed visual feedback. The actual action should happen when the user releases the button.
Fix: onTapDown sets isPressed to true, while onTapUp sets it back to false and triggers the button action.