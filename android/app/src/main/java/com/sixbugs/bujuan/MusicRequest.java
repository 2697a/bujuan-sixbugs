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
        basicMessageChannelPlugin.send(map, reply -> {
            callback.onSuccess(reply.toString());
        });
    }

    interface RequestCallback {
        void onSuccess(List<SongInfo> list);
    }

    public interface RequestInfoCallback {
        void onSuccess(String songUrl);
    }
}
