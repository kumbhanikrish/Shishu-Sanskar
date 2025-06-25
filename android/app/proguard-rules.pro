# Flutter-specific
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# Razorpay or any SDK example
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Avoid stripping annotations
-keepattributes *Annotation*

# Keep class members for callbacks
-keepclasseswithmembers class * {
    public void onPayment*(...);
}
