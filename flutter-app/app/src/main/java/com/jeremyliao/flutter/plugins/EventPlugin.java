package com.jeremyliao.flutter.plugins;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * Created by liaohailiang on 2019-11-22.
 */
public class EventPlugin implements EventChannel.StreamHandler, PluginRegister {

    private static final String PLUGIN_NAME = "com.jeremyliao.flutter.plugins/event";
    private EventChannel.EventSink event;

    public EventPlugin() {
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        PluginRegistry.Registrar registrar = registry.registrarFor(this.getClass().getCanonicalName());
        final EventChannel channel = new EventChannel(registrar.messenger(), PLUGIN_NAME);
        channel.setStreamHandler(this);
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.event = eventSink;
    }

    @Override
    public void onCancel(Object o) {
        this.event = null;
    }

    public void onReceiveMessage(String msg) {
        if (this.event == null) {
            return;
        }
        this.event.success(msg);
    }
}
