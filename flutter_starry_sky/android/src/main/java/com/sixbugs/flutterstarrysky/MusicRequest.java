package com.sixbugs.flutterstarrysky;



import androidx.annotation.Nullable;


import com.lzx.starrysky.provider.SongInfo;
import com.lzx.starrysky.utils.MainLooper;

import java.util.List;

import io.flutter.plugin.common.MethodChannel;

public class MusicRequest {
    public MusicRequest() {

    }


    public void getSongUrl(final String songId, final RequestInfoCallback callback, final MethodChannel channel, MainLooper mainLooper) {
        mainLooper.runOnUiThread(() -> channel.invokeMethod("getUrl", songId, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object result) {
                if(result!=null){
                    callback.onSuccess((String) result);
                }
            }

            @Override
            public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {

            }

            @Override
            public void notImplemented() {

            }
        }));
    }

    interface RequestCallback {
        void onSuccess(List<SongInfo> list);
    }

    public interface RequestInfoCallback {
        void onSuccess(String songUrl);
    }
}
