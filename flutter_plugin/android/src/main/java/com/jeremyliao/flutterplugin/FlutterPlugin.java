package com.jeremyliao.flutterplugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterPlugin
 */
public class FlutterPlugin implements MethodCallHandler {

    private static final String PLUGIN_NAME = "flutter_plugin";
    private static final String GET_PLATFORM_VERSION = "getPlatformVersion";
    private static final String GET_SDK_INT = "getSdkInt";

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), PLUGIN_NAME);
        channel.setMethodCallHandler(new FlutterPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals(GET_PLATFORM_VERSION)) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals(GET_SDK_INT)) {
            result.success("Android SDK: " + android.os.Build.VERSION.SDK_INT);
        } else {
            result.notImplemented();
        }
    }
}
