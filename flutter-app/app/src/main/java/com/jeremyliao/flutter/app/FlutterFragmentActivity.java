package com.jeremyliao.flutter.app;

import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import io.flutter.facade.Flutter;
import io.flutter.facade.FlutterFragment;

public class FlutterFragmentActivity extends FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fm);
        FlutterFragment flutterFragment = Flutter.createFragment("demo_app");
        getSupportFragmentManager()
                .beginTransaction()
                .add(R.id.fragment_container, flutterFragment)
                .commit();
    }
}