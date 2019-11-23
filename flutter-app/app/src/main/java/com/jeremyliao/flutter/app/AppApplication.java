package com.jeremyliao.flutter.app;

import android.app.Application;

import com.jeremyliao.flutter.plugins.CustomPluginRegistrant;

import io.flutter.view.FlutterMain;

/**
 * Created by liaohailiang on 2019-08-20.
 */
public class AppApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        FlutterMain.startInitialization(this);
    }
}
