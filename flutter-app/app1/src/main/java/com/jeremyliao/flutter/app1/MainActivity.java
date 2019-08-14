package com.jeremyliao.flutter.app1;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

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
}
