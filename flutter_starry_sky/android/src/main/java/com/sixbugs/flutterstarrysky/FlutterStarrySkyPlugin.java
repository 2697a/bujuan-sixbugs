package com.sixbugs.flutterstarrysky;


import android.app.Application;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.sixbugs.flutterstarrysky.starry.GsonUtil;
import com.sixbugs.flutterstarrysky.starry.StarrySky;
import com.sixbugs.flutterstarrysky.starry.StarrySkyConfig;
import com.sixbugs.flutterstarrysky.starry.control.OnPlayerEventListener;
import com.sixbugs.flutterstarrysky.starry.intercept.InterceptorCallback;
import com.sixbugs.flutterstarrysky.starry.intercept.StarrySkyInterceptor;
import com.sixbugs.flutterstarrysky.starry.notification.NotificationConfig;
import com.sixbugs.flutterstarrysky.starry.provider.SongInfo;
import com.sixbugs.flutterstarrysky.starry.utils.MainLooper;
import com.sixbugs.flutterstarrysky.starry.utils.SpUtil;

import org.jetbrains.annotations.NotNull;

import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterpluginPlugin
 */
public class FlutterStarrySkyPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private static final String TAG = "FlutterStarrySkyPlugin";
    public static MethodChannel channel;
    private OnPlayerEventListener onPlayerEventListener;
    private Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        initStarrySky(flutterPluginBinding.getApplicationContext(), "com.sixbugs.bujuan.MainActivity");
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_starry_sky");
        channel.setMethodCallHandler(this);
    }

//    public static void registerWith(Registrar registrar) {
//        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_starry_sky");
//        channel.setMethodCallHandler(new FlutterStarrySkyPlugin());
//    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "init":
                Log.d(TAG, "onMethodCall: ========我将初始化OnPlayerEventListener");
                addPlayerEventListener();
                result.success("初始化完毕");
                break;
            case "setPlayList":
                String setPlayList = (String) call.arguments;
                List<SongInfo> songInfos = GsonUtil.jsonToList(setPlayList, SongInfo.class);
                StarrySky.Companion.with().updatePlayList(songInfos);
                result.success(1);
                break;
            case "getPlayList":
                List<SongInfo> playList = StarrySky.Companion.with().getPlayList();
                if(playList.size() > 0)result.success(GsonUtil.GsonString(playList));
                else result.success("");
                break;
            case "playSongById":
                String songId = (String) call.arguments;
                Log.d(TAG, "onMethodCall: ======"+songId);
                StarrySky.Companion.with().playMusicById(songId);
                result.success(1);
                break;
            case "playSongByIndex":
                int index = (int) call.arguments;
                Log.d(TAG, "onMethodCall: ======"+index);
                StarrySky.Companion.with().playMusicByIndex(index);
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
                    StarrySky.Companion.with().skipToNext();
                    Log.d(TAG, "onError: ======"+errorMsg);
                }
            };
        }
        StarrySky.Companion.with().addPlayerEventListener(onPlayerEventListener);
    }


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

    //初始化音乐插件
    private void initStarrySky(Context context, String className) {
        NotificationConfig notificationConfig =
                new NotificationConfig();
        notificationConfig.setTargetClass(className);
        StarrySkyConfig config = new StarrySkyConfig().newBuilder()
                .addInterceptor(new PermissionInterceptor())
                .addInterceptor(new RequestSongInfoInterceptor())
                .isOpenNotification(true)
                .setNotificationConfig(notificationConfig)
                .build();
        StarrySky.Companion.init((Application) context, config);
    }

    private static class PermissionInterceptor implements StarrySkyInterceptor {

        @Override
        public void process(@Nullable SongInfo songInfo, @NotNull MainLooper mainLooper,
                            @NotNull InterceptorCallback callback) {
            if (songInfo == null) {
                callback.onInterrupt(new RuntimeException("SongInfo is null"));
                return;
            }
            boolean hasPermission = SpUtil.Companion.getInstance().getBoolean("HAS_PERMISSION", true);
            if (hasPermission) {
                callback.onContinue(songInfo);
                return;
            }
//        SoulPermission.getInstance()
//                .checkAndRequestPermissions(Permissions.build(Manifest.permission.READ_EXTERNAL_STORAGE,
//                        Manifest.permission.WRITE_EXTERNAL_STORAGE),
//                        new CheckRequestPermissionsListener() {
//                            @Override
//                            public void onAllPermissionOk(Permission[] allPermissions) {
//                                SpUtil.Companion.getInstance().putBoolean("HAS_PERMISSION", true);
//                                callback.onContinue(songInfo);
//                            }
//
//                            @Override
//                            public void onPermissionDenied(Permission[] refusedPermissions) {
//                                SpUtil.Companion.getInstance().putBoolean("HAS_PERMISSION", false);
//                                callback.onInterrupt(new RuntimeException("没有权限，播放失败"));
//                            }
//                        });
        }
    }

    private static class RequestSongInfoInterceptor implements StarrySkyInterceptor {

        private MusicRequest mMusicRequest = new MusicRequest();

        @Override
        public void process(@Nullable final SongInfo songInfo, MainLooper mainLooper, final InterceptorCallback callback) {
            if (songInfo == null) {
                callback.onInterrupt(new RuntimeException("SongInfo is null"));
                return;
            }
            if (TextUtils.isEmpty(songInfo.getSongUrl())) {
                mMusicRequest.getSongUrl(songInfo.getSongId(), new MusicRequest.RequestInfoCallback() {
                    @Override
                    public void onSuccess(String songUrl) {
                        songInfo.setSongUrl(songUrl);
                        callback.onContinue(songInfo);
                    }
                },channel,mainLooper);
            } else {
                callback.onContinue(songInfo);
            }
        }
    }
}
