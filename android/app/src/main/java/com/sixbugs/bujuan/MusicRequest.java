//package com.sixbugs.bujuan;
//
//
//import androidx.annotation.Nullable;
//
//import com.sixbugs.flutterstarrysky.FlutterStarrySkyPlugin;
//
//import io.flutter.plugin.common.MethodChannel;
//
//public class MusicRequest {
//
//    MethodChannel channel;
//    public MusicRequest() {
//    }
//
//
//    public void getSongUrl(String songId, RequestInfoCallback callback) {
//        if(channel==null)channel = FlutterStarrySkyPlugin.channel;
//        MainActivity.activity.runOnUiThread(() -> channel.invokeMethod("getUrl", songId, new MethodChannel.Result() {
//            @Override
//            public void success(@Nullable Object result) {
//                if(result!=null){
//                    callback.onSuccess((String) result);
//                }
//            }
//
//            @Override
//            public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
//
//            }
//
//            @Override
//            public void notImplemented() {
//
//            }
//        }));
//    }
//
//    interface RequestCallback {
//        void onSuccess(List<SongInfo> list);
//    }
//
//    public interface RequestInfoCallback {
//        void onSuccess(String songUrl);
//    }
//}
