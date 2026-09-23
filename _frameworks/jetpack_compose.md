---
layout: base
title: Jetpack Compose
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Jetpack Compose
{: .no_toc }

Jetpack Compose is a modern declarative UI toolkit for building native Android UIs that
consists of libraries in the AndroidX ecosystem.

| Language | Implementation | License            | Current Version   |
| :------- | :------------- | :----------------- | :---------------- |
| Kotlin   | Kotlin         | Apache-2.0 license | Library dependent |

## Table of Contents
{: .no_toc .text-delta }

- TOC
  {:toc}

## 1 Resources

- Official documentation:
  [Compose | Jetpack | Android Developers](https://developer.android.com/jetpack/androidx/releases/compose)

- Official Jetpack repository:
  [androidx/androidx](https://github.com/androidx/androidx)

- Official Compose repository:
  [Compose](https://android.googlesource.com/platform/frameworks/support/+/refs/heads/androidx-main/compose/)

- Official samples:
  [android/compose-samples](https://github.com/android/compose-samples)

## 2 Installation

- Jetpack Compose is designed to be used with Android Studio, which provides the recommended
  development environment and tooling for Android development.
  - Compose libraries are added to the project as Gradle dependencies.
  - Android Studio is based on IntelliJ IDEA Community Edition and is developed by Google.

- Official Android Studio installation:
  [Download Android Studio](https://developer.android.com/studio)

## 3 Project Structure

- Jetpack Compose projects follow the standard Gradle project structure.

```text
src/                                # project source directory
├── androidTest/                    # instrumented tests
│   └── java/                       # Java/Kotlin test files
│       └── com.example.mypackage/  # instrumented test package
├── main/                           # application source files
│   ├── java/                       # Java/Kotlin source files
│   │   └── com.example.mypackage/  # application package
│   │       ├── ui/                 # UI-related files
│   │       │   └── theme/          # application theme
│   │       │       ├── Color.kt    # color definitions
│   │       │       ├── Theme.kt    # theme definitions
│   │       │       └── Type.kt     # typography definitions
│   │       └── MainActivity.kt     # main activity
│   ├── keepRules/                  # code shrinking rules
│   │   └── rules.keep              # keep rules
│   ├── res/                        # resource files
│   │   ├── drawable/               # image resources
│   │   ├── mipmap/                 # launcher icon resources
│   │   ├── values/                 # default value resources
│   │   │   ├── colors.xml          # color resources
│   │   │   ├── strings.xml         # default text resources
│   │   │   └── themes.xml          # Android theme resources
│   │   ├── values-en/              # English value resources
│   │   │   └── strings.xml         # English text resources
│   │   └── values-de/              # German value resources
│   │       └── strings.xml         # German text resources
│   └── AndroidManifest.xml         # application manifest
└── test/                           # unit tests
    └── java/                       # Java/Kotlin test files
        └── com.example.mypackage/  # test package
```

## 4 Entry Point

- The app's entry point is the `MainActivity` class in the `MainActivity.kt` file.

```kotlin
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.material3.Scaffold
import androidx.compose.ui.Modifier
import com.example.myapp.ui.theme.MyAppTheme // Custom app theme.

// Main activity derived from ComponentActivity.
class MainActivity : ComponentActivity() {

    // Called when the activity is created.
    override fun onCreate(savedInstanceState: Bundle?) {

        // Execute the parent's onCreate lifecycle method.
        super.onCreate(savedInstanceState)

        // Allow the app to draw behind the system bars.
        enableEdgeToEdge()

        // Set the content to display.
        setContent {
            // Use the custom theme composable as the entry point.
            MyAppTheme {
                // Provide safe insets for the content.
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    // Display the main application content.
                    MyMainComponent(modifier = Modifier.padding(innerPadding))
                }
            }
        }

    }
}
```

## 5 Composables

- UI elements are created with composables.
  - Composables are functions annotated with the `Composable` annotation.
  - Composables can call other composables.

- Composables are re-executed through recomposition when relevant state or inputs change.
  - Compose tracks state reads and can skip composables whose relevant stable inputs have not
    changed.

```kotlin
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable

// Define a composable.
@Composable
fun Greeting(name: String) {

    // Display another composable.
    Text(text = "Hello $name!")

}
```

- <u>Best practices</u>:
  - Composable functions should be named in Pascal case.
  - Composable function names should describe what they represent, typically using nouns.

### 5.1 Text

- Text element sizes can be specified in scalable pixels or density-independent pixels.
  - Scalable pixels (`sp`) scale according to the user's preferred font size.
  - Density-independent pixels (`dp`) are independent of the device's pixel density.

```kotlin
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun MyComposable() {

    // Display a text composable.
    Text(
        text = "Hello, World!",        // Text to display.

        // Optional parameters.
        fontSize = 12.sp,              // Font size in scalable pixels.
        lineHeight = 20.dp,            // Line height in density-independent pixels.
        fontWeight = FontWeight.Bold,  // Font weight.
        textAlign = TextAlign.Center,  // Text alignment.
    )
}
```

### 5.2 Images

- Drawable image resources can be displayed by composables (see [8 Resources](#8-resources)).

```kotlin
import androidx.compose.foundation.Image
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource

@Composable
fun MyComposable() {

    // Load a drawable image resource by its resource ID.
    val image: Painter = painterResource(R.drawable.myimage)

    // Display an image composable.
    Image(
        painter = image,                    // Loaded image to display.
        contentDescription = "Some image",  // Image description for accessibility.

        // Optional parameters.
        contentScale = ContentScale.Fit,    // Scale the image to fit its bounds.
        alpha = 0.8F,                       // Image opacity.
    )
}
```

### 5.3 Spacers

- Spacers can be used to add space between composables
- Spacer composables require a modifier object to set their size (see [6 Modifiers](#6-modifiers)).

```kotlin
import androidx.compose.foundation.layout.Spacer
import androidx.compose.runtime.Composable

@Composable
fun MyComposable() {

    // Display an empty space composable.
    Spacer()
}
```

## 6 Modifiers

- Modifiers change the appearance, layout, and behavior of composables.

```kotlin
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

// Pass a modifier parameter to the composable.
@Composable
fun MyComposable(modifier: Modifier = Modifier) {

    Text(
        text = "A",
        modifier = modifier,  // Pass the modifier argument to the composable.
    )

    Text(
        text = "B",

        // Adjust the passed modifier; modifier order is relevant.
        modifier = modifier
            .width(width = 12.dp)              // Set width.
            .height(width = 12.dp)             // Set height.
            .size(size = 12.dp)                // Set width and height.
            .padding(all = 16.dp)              // Set padding for all sides.
            .padding(                          // Set padding for individual sides.
                start = 16.dp,
                top = 16.dp,
                end = 16.dp,
                bottom = 16.dp,
            )
            .align(alignment = Alignment.End)  // Align within the parent.
            .fillMaxSize()                     // Expand to the maximum size.
            .background(color = Color.Blue)    // Set the background color.
            .weight(                           // Scale owned space relative to siblings' weights.
                weight = 1.0F,                 // Set the relative weight.
                fill = true,                   // Fill the allocated space.
            ),
    )
}
```

- <u>Best practices</u>:
  - Composable functions should accept a `Modifier` parameter with a default value.
  - Always pass the `Modifier` argument to subsequent composable functions.
  - Define common modifier values between composables in their parent composable.

## 7 Layouts

- Child composables are placed inside their parent composable in the UI hierarchy.
- Layout composables control the position and arrangement of their child composables.

```kotlin
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier

@Composable
fun MyComposable(modifier: Modifier = Modifier) {

    // Arrange composables on top of each other.
    Box(
        contentAlignment = Alignment.Center,  // Align elements horizontally and vertically.
        modifier = modifier,
    ) {
        Text(text = "A", modifier = modifier)
        Text(text = "B", modifier = modifier)
        Text(text = "C", modifier = modifier)
    }

    // Arrange composables in a row.
    Row(
        horizontalArrangement = Arrangement.Center,      // Align elements horizontally.
        verticalAlignment = Alignment.CenterVertically,  // Align elements vertically.
        modifier = modifier,
    ) {
        Text(text = "A", modifier = modifier)
        Text(text = "B", modifier = modifier)
        Text(text = "C", modifier = modifier)
    }

    // Arrange composables in a column.
    Column(
        verticalArrangement = Arrangement.Center,            // Align elements vertically.
        horizontalAlignment = Alignment.CenterHorizontally,  // Align elements horizontally.
        modifier = modifier,
    ) {
        Text(text = "A", modifier = modifier)
        Text(text = "B", modifier = modifier)
        Text(text = "C", modifier = modifier)
    }
}
```

## 8 Resources

- Resources are static content used by the app.
- Resources must be stored in the `res` directory and its corresponding subdirectories.
- Resources can be managed through the Resource Manager window in Android Studio.

```kotlin
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource

// Access the internal resource ID.
myResourceId: Int

myResourceId = R.drawable.my_image  // Drawable resource ID.
myResourceId = R.mipmap.my_icon     // Mipmap resource ID.
myResourceId = R.color.my_color     // Color resource ID.
myResourceId = R.string.my_text     // String resource ID.
myResourceId = R.style.Theme_MyApp  // Android theme resource ID.

// Load a drawable image resource.
val image: Painter = painterResource(id = R.drawable.myimage)

// Load a text resource.
val text: String = stringResource(id = R.string.my_text)
```

### 8.1 Images

- Image files must be placed in the `res/drawable` or `res/drawable-nodpi` directory to use
  them as image resources.

### 8.2 Colors

- Colors can be defined in the `res/values/colors.xml` file and used as color resources.

```xml
<?xml version="1.0" encoding="utf-8"?>

<resources>

    <!-- Pre-defined color resources. -->
    <color name="purple_200">#FFBB86FC</color>
    <color name="purple_500">#FF6200EE</color>
    <color name="purple_700">#FF3700B3</color>
    <color name="teal_200">#FF03DAC5</color>
    <color name="teal_700">#FF018786</color>
    <color name="black">#FF000000</color>
    <color name="white">#FFFFFFFF</color>

    <!-- Custom color resources. -->
    <color name="my_red">#FFFF0000</color>
    <color name="my_green">#FF00FF00</color>

</resources>
```

- <u>Best practices</u>:
  - Color resources should be named in snake case.
  - For custom Compose colors, `ui/theme/Color.kt` should be used instead of
    `res/values/colors.xml`.

### 8.3 Texts

- Text resources must be defined in the `res/values/strings.xml` file.
  - Language-specific directories such as `values-en` and `values-de` can be used to define
    localized text resources.
  - Android automatically selects the appropriate resources according to the device's language
    settings.

```xml
<?xml version="1.0" encoding="utf-8"?>

<resources>

    <!-- Pre-defined application name. -->
    <string name="app_name">My App</string>

    <!-- Custom text resources. -->
    <string name="my_text">Hello!</string>
    <string name="my_other_text">Hello again!</string>

</resources>
```

- <u>Best practices</u>:
  - Text resources should be named in snake case.

### 8.4 Themes

- Android themes can be defined in the `res/values/themes.xml` file and used as Android theme
  resources.

```xml
<?xml version="1.0" encoding="utf-8"?>

<resources>

    <!-- Pre-defined Android theme resource. -->
    <style name="Theme.MyApp" parent="android:Theme.Material.Light.NoActionBar" />

</resources>
```

- <u>Best practices</u>:
  - Theme resources should use Pascal case and the `Theme.` prefix.
  - For custom Compose themes, `ui/theme/Theme.kt` should be used instead of
    `res/values/themes.xml`.

## 9 Previews

- Composables can be rendered as previews in Android Studio by annotating them with the
  `Preview` annotation.
- Previews are only used during development and do not affect the final app.

```kotlin
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import com.example.myapp.ui.theme.MyAppTheme

@Composable
fun Greeting() {
    Text(text = "Hello, World!")
}

// Define a preview composable.
@Preview(
    showBackground = true, // Show a background for the preview.
)
@Composable
fun MyAppPreview() {

    // Render the composable using the app theme.
    MyAppTheme {
        Greeting()
    }
}

```

{% endraw %}
