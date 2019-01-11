package com.jeremyliao.flutter.app1;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import io.flutter.facade.Flutter;

public class FlutterViewActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        View flutterView = Flutter.createView(
                FlutterViewActivity.this,
                getLifecycle(),
                "demo_app"
        );
        setContentView(flutterView);
    }
}
