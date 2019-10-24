package com.jeremyliao.flutter.app;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import io.flutter.facade.Flutter;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void toFlutterView(View view) {
        startActivity(new Intent(this, FlutterViewActivity.class));
    }

    public void toFlutterFragment(View view) {
        startActivity(new Intent(this, FlutterFragmentActivity.class));
    }

    public void toFlutterApp(View view) {
        startActivity(new Intent(this, FlutterAppActivity.class));
    }
}
