package com.jeremyliao.flutter.app;

import android.os.Bundle;

import com.jeremyliao.flutter.plugins.CustomPluginRegistrant;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class FlutterAppActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        CustomPluginRegistrant.registerWith(this,this);
    }
}
