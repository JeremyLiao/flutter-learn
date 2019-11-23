package com.jeremyliao.flutter.app;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.jeremyliao.flutter.plugins.CustomPluginRegistrant;
import com.jeremyliao.flutter.plugins.ToastPlugin;

import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class FlutterViewActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        FlutterView flutterView = Flutter.createView(
                FlutterViewActivity.this,
                getLifecycle(),
                "demo_app"
        );
        setContentView(flutterView);
        CustomPluginRegistrant.registerWith(flutterView.getPluginRegistry(), this);
        getSupportActionBar().hide();
    }
}
