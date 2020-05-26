package com.sixbugs.bujuan;


import android.util.Log;

import androidx.annotation.NonNull;

import com.lzx.starrysky.StarrySky;
import com.lzx.starrysky.control.OnPlayerEventListener;
import com.lzx.starrysky.provider.SongInfo;
import com.sixbugs.bujuan.utils.GsonUtil;

import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/**
 * FlutterpluginPlugin
 */
public class FlutterStarrySkyPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private static final String TAG = "FlutterStarrySkyPlugin";
    private MethodChannel channel;
    private OnPlayerEventListener onPlayerEventListener;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_starry_sky");
        channel.setMethodCallHandler(this);
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_starry_sky");
        channel.setMethodCallHandler(new FlutterStarrySkyPlugin());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "init":
                Log.d(TAG, "onMethodCall: ========我将初始化OnPlayerEventListener");
                addPlayerEventListener();
                result.success("初始化完毕");
                break;
            case "setPlayList":
                String playList = (String) call.arguments;
                List<SongInfo> songInfos = GsonUtil.jsonToList(playList, SongInfo.class);
                StarrySky.Companion.with().updatePlayList(songInfos);
                result.success(1);
                break;
            case "playSongById":
                String songId = (String) call.arguments;
                StarrySky.Companion.with().playMusicById(songId);
                result.success(1);
                break;
            case "restore":
                if (!StarrySky.Companion.with().isPlaying())
                    StarrySky.Companion.with().restoreMusic();
                result.success(1);
                break;
            case "pause":
                if (StarrySky.Companion.with().isPlaying())
                    StarrySky.Companion.with().pauseMusic();
                result.success(1);
                break;
            case "next":
                StarrySky.Companion.with().skipToNext();
                result.success(1);
                break;
            case "previous":
                StarrySky.Companion.with().skipToPrevious();
                result.success(1);
                break;
            case "dispose":
                Log.d(TAG, "dispose: ======");
                break;
            default:
                result.notImplemented();
                break;
        }
    }


    //添加监听
    private void addPlayerEventListener() {
        if (onPlayerEventListener == null) {
            onPlayerEventListener = new OnPlayerEventListener() {
                @Override
                public void onMusicSwitch(@NonNull SongInfo songInfo) {
                    channel.invokeMethod("currSong", GsonUtil.GsonString(songInfo));
                    Log.d(TAG, "onMusicSwitch: ======" + songInfo.getSongName());
                }

                @Override
                public void onPlayerStart() {
                    channel.invokeMethod("state", "start");
                    Log.d(TAG, "onPlayerStart: ======");
                }

                @Override
                public void onPlayerPause() {
                    channel.invokeMethod("state", "pause");
                    Log.d(TAG, "onPlayerPause: ======");
                }

                @Override
                public void onPlayerStop() {
                    channel.invokeMethod("state", "stop");
                    Log.d(TAG, "onPlayerStop: ======");
                }

                @Override
                public void onPlayCompletion(@NonNull SongInfo songInfo) {
                    channel.invokeMethod("state", "completion");
                    Log.d(TAG, "onPlayCompletion: ======" + songInfo.getSongName());
                }

                @Override
                public void onBuffering() {

                }

                @Override
                public void onError(int errorCode, @NonNull String errorMsg) {
                    channel.invokeMethod("state", "error");
                    Log.d(TAG, "onError: ======");
                }
            };
        }
        StarrySky.Companion.with().addPlayerEventListener(onPlayerEventListener);
    }

    //播放进度监听
//    private void getPlayPosition() {
//
//    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        Log.d(TAG, "onDetachedFromEngine: ======");
        channel.setMethodCallHandler(null);
    }


    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        Log.d(TAG, "onAttachedToActivity: ======");
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        Log.d(TAG, "onDetachedFromActivityForConfigChanges: ======");
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        Log.d(TAG, "onReattachedToActivityForConfigChanges: ======");
    }

    @Override
    public void onDetachedFromActivity() {
        Log.d(TAG, "onDetachedFromActivity: ======");
        if (onPlayerEventListener != null)
            StarrySky.Companion.with().removePlayerEventListener(onPlayerEventListener);
        StarrySky.Companion.with().stopMusic();
        StarrySky.Companion.release();
        System.exit(0);
    }
}
