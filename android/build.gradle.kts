allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Some plugins (e.g. onnxruntime 1.4.1) hardcode an outdated compileSdkVersion
// in their own android/build.gradle, which fails AAR metadata checks against
// newer androidx transitive deps. Force every Android library subproject to
// compile against at least API 36 (matches android/app/build.gradle.kts).
// The onnxruntime plugin (1.4.1, latest on pub.dev) hardcodes
// compileSdkVersion 33 in its own android/build.gradle while pulling in
// androidx deps that themselves require 34+ — an inconsistency in the
// plugin itself. Only that one subproject needs the override; scope it
// narrowly (rather than all subprojects) since other plugins' own build
// scripts (e.g. record's :jni, which configures native/CMake builds) read
// compileSdk earlier in their own configuration than a subprojects-wide
// listener fires, and get a "too late to set compileSdk" error otherwise.
gradle.afterProject {
    if (name == "onnxruntime") {
        plugins.withId("com.android.library") {
            extensions.configure<com.android.build.gradle.LibraryExtension> {
                compileSdk = 36
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
