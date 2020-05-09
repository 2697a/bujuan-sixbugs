package com.sixbugs.bujuan;

import com.lzx.starrysky.provider.SongInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BasicMessageChannel;

public class MusicRequest {

    BasicMessageChannel<Object> basicMessageChannelPlugin;
    Map<String, String> map;

    public MusicRequest() {
    }


    public void getSongUrl(String songId, RequestInfoCallback callback) {
        if (basicMessageChannelPlugin == null) {
            basicMessageChannelPlugin = MainActivity.basicMessageChannelPlugin;
        }
        if (map == null) {
            map = new HashMap<>();
        }
        map.put("type", "getUrl");
        map.put("id", songId);
        MainActivity.activity.runOnUiThread(() -> basicMessageChannelPlugin.send(map, reply -> {
            Map<String,String> map = (Map<String, String>) reply;
            callback.onSuccess(map.get("url"));
        }));
    }

    interface RequestCallback {
        void onSuccess(List<SongInfo> list);
    }

    public interface RequestInfoCallback {
        void onSuccess(String songUrl);
    }
}
