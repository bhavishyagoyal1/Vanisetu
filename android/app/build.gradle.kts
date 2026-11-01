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
        // their own copy of libonnxruntime.so at the same jniLibs path, but
        // they are NOT interchangeable: sherpa_onnx 1.13.8 bundles ONNX
        // Runtime 1.28.2 and its libsherpa-onnx-c-api.so links against the
        // *versioned* symbol OrtGetApiBase@VERS_1.28.2, while the onnxruntime
        // plugin (1.4.1) only bundles ONNX Runtime 1.15.1, which defines
        // OrtGetApiBase@VERS_1.15.1. If AGP's merge picks the older copy,
        // sherpa's dlopen fails at runtime with "cannot locate symbol
        // OrtGetApiBase" even though the symbol name exists in both files
        // (verified via direct ELF .gnu.version_d inspection). ORT's C API
        // is additive/backward-compatible, so standardizing on the newer
        // 1.28.2 build satisfies both plugins. copyCorrectOrtNativeLibs
        // (below) overrides app/src/main/jniLibs with that copy; pickFirsts
        // then just needs to prefer it over the AAR-provided ones.
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

// See the packaging{} comment above: overwrite this module's own jniLibs
// with sherpa_onnx's (newer, ONNX Runtime 1.28.2) libonnxruntime.so so it
// wins native-lib merging over the onnxruntime plugin's older 1.15.1 copy,
// regardless of AGP's otherwise nondeterministic pickFirsts ordering.
val ortAbiToSherpaProject = mapOf(
    "arm64-v8a" to "sherpa_onnx_android_arm64",
    "armeabi-v7a" to "sherpa_onnx_android_armeabi",
    "x86" to "sherpa_onnx_android_x86",
    "x86_64" to "sherpa_onnx_android_x86_64",
)

val copyCorrectOrtNativeLibs by tasks.registering(Copy::class) {
    ortAbiToSherpaProject.forEach { (abi, sherpaProjectName) ->
        val sherpaProject = rootProject.findProject(":$sherpaProjectName")
        if (sherpaProject != null) {
            from(sherpaProject.projectDir.resolve("src/main/jniLibs/$abi/libonnxruntime.so")) {
                into(abi)
            }
        }
    }
    into(layout.projectDirectory.dir("src/main/jniLibs"))
}

tasks.matching { it.name.matches(Regex("merge.*(NativeLibs|JniLibFolders)")) }.configureEach {
    dependsOn(copyCorrectOrtNativeLibs)
}

flutter {
    source = "../.."
}
