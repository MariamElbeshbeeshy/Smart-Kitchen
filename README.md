# smart_kitchen

## 🛠 Troubleshooting

If you encounter Build Errors, do not panic! Follow this routine in order:

1. **Clean the project:**
   `fvm flutter clean`

2. **Get dependencies again:**
   `fvm flutter pub get`

3. **Clean Android Gradle:**
   `cd android`
   `./gradlew clean` (or `gradlew.bat clean` on Windows)
   `cd ..`

4. **Run again:**
   `fvm flutter run`
