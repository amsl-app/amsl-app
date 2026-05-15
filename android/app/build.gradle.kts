plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.FileInputStream

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.reader(Charsets.UTF_8).use { reader ->
        localProperties.load(reader)
    }
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

// Use keystore if available
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use { stream ->
        keystoreProperties.load(stream)
    }
}


android {
    flavorDimensions += "flavor-type"
    namespace = "edu.kit.iism.issd.amsl.app"


    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationIdSuffix = ".dev"
            resValue(
                type = "string",
                name = "app_name",
                value = "Amsl Dev"
            )
            manifestPlaceholders["appAuthRedirectScheme"] = "edu.kit.iism.issd.amsl.app.dev"
        }
        create("qa") {
            dimension = "flavor-type"
            applicationIdSuffix = ".test"
            resValue(
                type = "string",
                name = "app_name",
                value = "Amsl Test"
            )
            manifestPlaceholders["appAuthRedirectScheme"] = "edu.kit.iism.issd.amsl.app.test"
        }
        create("staging") {
            dimension = "flavor-type"
            applicationIdSuffix = ".staging"
            resValue(
                type = "string",
                name = "app_name",
                value = "Amsl Staging"
            )
            manifestPlaceholders["appAuthRedirectScheme"] = "edu.kit.iism.issd.amsl.app.staging"
        }
        create("prod") {
            dimension = "flavor-type"
            resValue(
                type = "string",
                name = "app_name",
                value = "Amsl"
            )
            manifestPlaceholders["appAuthRedirectScheme"] = "edu.kit.iism.issd.amsl.app"
        }
    }

    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }
    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.window:window:1.3.0")
    implementation("androidx.window:window-java:1.3.0")
    implementation("androidx.multidex:multidex:2.0.1")
}

flutter {
    source = "../.."
}
