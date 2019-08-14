package com.jeremyliao.flutter.app1;

import android.os.Bundle;
import android.support.v4.app.FragmentActivity;

import io.flutter.facade.Flutter;

public class FlutterFragmentActivity extends FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fm);
        getSupportFragmentManager()
                .beginTransaction()
                .add(R.id.fragment_container, Flutter.createFragment("demo_app"))
                .commit();
    }
}