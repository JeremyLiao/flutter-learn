package com.jeremyliao.flutter.plugins;

import android.content.Context;
import android.support.annotation.NonNull;
import android.widget.Toast;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Created by liaohailiang on 2019-11-22.
 */
public class ToastPlugin implements MethodChannel.MethodCallHandler {

    private static final String PLUGIN_NAME = "com.jeremyliao.flutter.plugins/toast";
    private static final String SHOW_TOAST = "showToast";
    private final Context context;

    public ToastPlugin(Context context) {
        this.context = context.getApplicationContext();
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(BinaryMessenger messenger, Context context) {
        final MethodChannel channel = new MethodChannel(messenger, PLUGIN_NAME);
        channel.setMethodCallHandler(new ToastPlugin(context));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        if (methodCall.method.equals(SHOW_TOAST)) {
            String message = methodCall.argument("message");
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
            result.success(null);
        } else {
            result.notImplemented();
        }
    }
}
