package com.jeremyliao.flutter.app;

import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;

import com.jeremyliao.flutter.plugins.EventPlugin;
import com.jeremyliao.flutter.plugins.PluginRegistrantHelper;
import com.jeremyliao.flutter.plugins.ToastPlugin;

import io.flutter.app.FlutterPluginRegistry;
import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class FlutterViewActivity extends AppCompatActivity {

    EventPlugin eventPlugin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        FlutterView flutterView = Flutter.createView(
                FlutterViewActivity.this,
                getLifecycle(),
                "demo_app"
        );
        setContentView(flutterView);
        FlutterPluginRegistry registry = flutterView.getPluginRegistry();
        if (PluginRegistrantHelper.canRegisterWith(registry)) {
            new ToastPlugin(this).registerWith(registry);
            eventPlugin = new EventPlugin();
            eventPlugin.registerWith(registry);
        }
        getSupportActionBar().hide();
    }

    @Override
    protected void onResume() {
        super.onResume();
        eventPlugin.onReceiveMessage("onResume!");
    }
}
