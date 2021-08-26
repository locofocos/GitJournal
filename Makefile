keys:
	mkdir -p /tmp/codegen
	yq -o=json eval assets/langs/en.yaml -P > /tmp/codegen/en.json
	flutter pub run easy_localization:generate -S /tmp/codegen -f keys -o locale_keys.g.dart
	dart format lib/generated
	flutter pub run import_sorter:main lib/generated/*

protos:
	protoc --dart_out=grpc:lib/analytics/generated -Ilib/analytics/ lib/analytics/analytics.proto
	protoc --dart_out=grpc:lib/generated -Iprotos protos/shared_preferences.proto
	dart format lib/generated
	flutter pub run import_sorter:main lib/generated/*
