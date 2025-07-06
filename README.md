# Teleprompter

Training:
- GetX, Bloc, Provider
- Clean Architecture

## Getting Started

### Installation

- Generate JSON serialization code for models, assets and fonts,...
```bash
flutter pub run build_runner build -d
```

- Update app icon
```bash
flutter pub run flutter_launcher_icons -f app_icon.yaml
```

### Running

```bash
flutter run
```

## Project Structure

```
lib\
 ├──configs\                    # Config files
 │  └──themes\
 ├──data\                       # The data layer's responsibility is to retrieve/manipulate data from one or more sources
 │  ├──local\
 │  ├──network\
 │  └──repository\
 ├──di\                         # Dependency injection
 ├──domain\                     # The domain layer contains Entities, Use cases & Repository Interfaces
 │  ├──error\
 │  ├──models\
 │  ├──repository\
 │  └──usecases\
 ├──gen\                        # Generated files (note flutter pub run build_runner build -d)
 │  ├──assets.gen.dart
 │  ├──fonts.gen.dart
 ├──presentation\               # The presentation layer's responsibility is to manage the state of the application and display the user ui
 │  ├──blocs\
 │  ├──dialogs\
 │  ├──screens\
 │  └──widgets\
 └──utils\                      # Utilities in the form of a function
```