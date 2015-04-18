# Nutzungshinweise
## Point Cloud Library mit C++, MSVC 2010 und CMake

### Vorbereitung

1. PCL Standalone-Installer für 32-Bit Installieren
2. Binaries für PCL, VTK und FLANN in den Umgebungspfad eintragen
3. Visual Studio 2010 (z.B. Express) installieren - in v1.6.0 funktioniert es nur mit dem Compiler! Die neueren Releases gibt es nur ungetestet als precompiled Binaries...
4. Cmake installieren (in v.3.2.2 getestet)

### Projekt builden

1. CPP-File mit entsprechendem Code und includes erzeugen
2. im gleichen Ordner eine passende CMakeLists.txt für Cmake anlegen (siehe vorhandene Beispiele)
3. Subfolder "build" erstellen (wird von Git in dieser Config wegen entstehender Datenmenge ingnoriert)
4. Cmake mit MSVC2010 im erstellten Ordner "build" ausführen:
  **cmake .. -G "Visual Studio 10"**
5. Cmake erstellt nun die VS Projektfiles - sln-Datei aufrufen und in Visual Studio Erstellen
