plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.vaanisetu.vaanisetu"
    // onnxruntime's AAR (via androidx.fragment/window/activity) requires
    // compiling against API 34+; flutter.compileSdkVersion resolves lower
    // on this Flutter install, so pin explicitly.
    compileSdk = maxOf(flutter.compileSdkVersion, 36)
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.vaanisetu.vaanisetu"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    packaging {
        // Both the `sherpa_onnx` (ASR) and `onnxruntime` (MT) plugins bundle
        // their own copy of libonnxruntime.so at the same jniLibs path.
        // Keep one; the ORT C API entry point (OrtGetApiBase) both plugins'
        // bindings use has been ABI-stable across recent releases.
        jniLibs {
            pickFirsts += setOf("**/libonnxruntime.so")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
