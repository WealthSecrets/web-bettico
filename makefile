format:
	fvm dart format --set-exit-if-changed -l 120 lib

packages:
	fvm flutter pub get

run_dev:
	fvm flutter run --flavor dev --dart-define=env.mode=dev -d chrome

clean: 
	fvm flutter clean

build_runner:
	fvm dart run build_runner build --delete-conflicting-outputs