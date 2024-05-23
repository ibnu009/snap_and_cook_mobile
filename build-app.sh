#!/bin/bash
# Example: bash build-app.sh -b=apk -e=staging/.env --add-args=--release --add-args=--target=lib/main_staging.dart
# Example prod: bash build-app.sh -b=apk -e=production/.env --add-args=--release --add-args=--target=lib/main_production.dart
# Example aab: bash build-app.sh -b=appbundle -e=production/.env --add-args=--release --add-args=--target=lib/main_production.dart

# Example get Env : String.fromEnvironment, bool.fromEnvironment, int.fromEnvironment, and double.fromEnvironment

# --build-number
# On Android it is used as "versionCode".
# On Xcode builds it is used as "CFBundleVersion".

#--obfuscate --split-debug-info=./debug_symbols

# --build-name
# On Android it is used as "versionName".
# On Xcode builds it is used as "CFBundleShortVersionString".

# for window run on Git Bash/ Bash For Window

# Read user input for a specific argument
read_argument() {
    read -p "Enter $1: " input
    echo "$input"
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in

 		-e=*|--env=*)
            env_file="${1#*=}"
            shift
            ;;
        -b=*|--bundle=*)
            bundle="${1#*=}"
            shift
            ;;
        --add-args=*)
            add_args+=" ${1#*=}"
            shift
            ;;
        *)
            echo "Invalid argument: $1"
            exit 1
            ;;
    esac
done

# Validation Environment
if [[ -z "$env_file" ]]; then
    env_file=$(read_argument "env file path")
fi


# Validation Bundle
if [[ -z "$bundle" ]]; then
    bundle=$(read_argument "bundle (aar, apk, appbundle, ios, ipa)")
fi

if [[ "$bundle" != "aar" && "$bundle" != "apk"  && "$bundle" != "appbundle" && "$bundle" != "ios" && "$bundle" != "ipa" ]]; then
    echo "Invalid bundle option: $bundle"
    exit 1
fi

# Generate dart define
generate_dart_define_args() {
    env_file="$1"
    dart_define_args=""
    while IFS= read -r line; do
        # Ignore lines starting with '#' and lines with only whitespace
        if [[ ! -z "$line" && "$line" != "#"* && ! "$line" =~ ^[[:space:]]*$ ]]; then
            key=$(echo "$line" | cut -d '=' -f 1)
            value=$(echo "$line" | cut -d '=' -f 2-)
            dart_define_args+="--dart-define=$key=$value "
        fi
    done < "$env_file"
    echo "$dart_define_args"
}

dart_define_args=$(generate_dart_define_args "$env_file")
dart_define_args+="$add_args"

echo "Arguments:"
echo "> Platform: $platform"
echo "> Env: $env_file"
echo "> Build: $build_type"
echo ""

echo "Running flutter clean"

flutter clean
echo ""

# Remove pubspec.lock if it exists
if [ -f "pubspec.lock" ]; then
    echo "Removing pubspec.lock"
    echo ""
    rm pubspec.lock
fi

echo "Running flutter pub get"
flutter pub get
echo ""

# Add obfuscation for APK and AAB
if [[ "$bundle" == "apk" || "$bundle" == "appbundle" ]]; then
    dart_define_args+=" --obfuscate --split-debug-info=./debug_symbols "
fi

echo "Running flutter build $bundle $dart_define_args"
echo ""
flutter build $bundle $dart_define_args

echo "Flutter build $bundle finished"
