format:
	fvm flutter format --set-exit-if-changed -l 120 lib

packages:
	fvm flutter pub get

run_dev_release:
	fvm flutter run --flavor dev --dart-define=env.mode=dev --release -d chrome

run_dev:
	fvm flutter run --flavor dev --dart-define=env.mode=dev -d chrome

port: 
	fvm flutter run --flavor dev --dart-define=env.mode=dev -d web-server --web-port 8080 --web-hostname 0.0.0.0

clean: 
	fvm flutter clean

build_runner:
	fvm dart run build_runner build --delete-conflicting-outputs