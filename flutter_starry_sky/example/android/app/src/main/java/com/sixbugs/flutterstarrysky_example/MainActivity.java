package com.sixbugs.flutterstarrysky_example;

import android.os.Bundle;
import android.os.PersistableBundle;

import androidx.annotation.Nullable;


import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState, @Nullable PersistableBundle persistentState) {
        super.onCreate(savedInstanceState, persistentState);
        GeneratedPluginRegistrant.registerWith(Objects.requireNonNull(this.getFlutterEngine()));
    }

}
