package com.jeremyliao.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;

public final class PluginRegistrantHelper {

    public static boolean canRegisterWith(PluginRegistry registry) {
        return !alreadyRegisteredWith(registry);
    }

    private static boolean alreadyRegisteredWith(PluginRegistry registry) {
        final String key = PluginRegistrantHelper.class.getCanonicalName();
        if (registry.hasPlugin(key)) {
            return true;
        }
        registry.registrarFor(key);
        return false;
    }
}
