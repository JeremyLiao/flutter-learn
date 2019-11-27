package com.jeremyliao.flutter.app;

import android.os.Bundle;
import android.os.Handler;

import com.jeremyliao.flutter.plugins.EventPlugin;
import com.jeremyliao.flutter.plugins.PluginRegistrantHelper;
import com.jeremyliao.flutter.plugins.ToastPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class FlutterAppActivity extends FlutterActivity {

    EventPlugin eventPlugin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        if (PluginRegistrantHelper.canRegisterWith(this)) {
            new ToastPlugin(this).registerWith(this);
            eventPlugin = new EventPlugin();
            eventPlugin.registerWith(this);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        eventPlugin.onReceiveMessage("onResume!");
    }
}
