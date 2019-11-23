package com.jeremyliao.flutter.plugins;


import android.content.Context;

import io.flutter.plugin.common.PluginRegistry;

/**
 * Generated file. Do not edit.
 */
public final class CustomPluginRegistrant {
    public static void registerWith(PluginRegistry registry, Context context) {
        if (alreadyRegisteredWith(registry)) {
            return;
        }
        PluginRegistry.Registrar registrar = registry.registrarFor(ToastPlugin.class.getCanonicalName());
        ToastPlugin.registerWith(registrar.messenger(), context);
    }

    private static boolean alreadyRegisteredWith(PluginRegistry registry) {
        final String key = CustomPluginRegistrant.class.getCanonicalName();
        if (registry.hasPlugin(key)) {
            return true;
        }
        registry.registrarFor(key);
        return false;
    }
}
