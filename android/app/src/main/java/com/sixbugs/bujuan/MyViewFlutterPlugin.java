package com.sixbugs.bujuan;


import io.flutter.plugin.common.PluginRegistry;

public class MyViewFlutterPlugin {
    public static void registerWith(PluginRegistry registry) {
        final String key = MyViewFlutterPlugin.class.getCanonicalName();
        if (registry.hasPlugin(key)) return;
        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("plugins.woshiku.top/myview", new MyViewFactory(registrar.messenger()));
    }
}