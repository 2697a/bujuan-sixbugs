package com.sixbugs.flutterstarrysky;


import android.app.Application;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.lzx.starrysky.StarrySky;
import com.lzx.starrysky.StarrySkyConfig;
import com.lzx.starrysky.common.IMediaConnection;
import com.lzx.starrysky.control.OnPlayerEventListener;
import com.lzx.starrysky.control.RepeatMode;
import com.lzx.starrysky.intercept.InterceptorCallback;
import com.lzx.starrysky.intercept.StarrySkyInterceptor;
import com.lzx.starrysky.notification.NotificationConfig;
import com.lzx.starrysky.provider.SongInfo;
import com.lzx.starrysky.utils.MainLooper;
import com.lzx.starrysky.utils.SpUtil;
import com.lzx.starrysky.utils.TimerTaskManager;
import com.sixbugs.flutterstarrysky.starry.GsonUtil;

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
    private TimerTaskManager mTimerTask;

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
                listenerPos();
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
                if (playList.size() > 0) result.success(GsonUtil.GsonString(playList));
                else result.success("");
                break;
            case "playSongById":
                String songId = (String) call.arguments;
                Log.d(TAG, "onMethodCall: ======" + songId);
                StarrySky.Companion.with().playMusicById(songId);
                result.success(1);
                break;
            case "playSongByIndex":
                int index = (int) call.arguments;
                Log.d(TAG, "onMethodCall: ======" + index);
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
            case "playMod":
                int playMod = (int) call.arguments;
                switch (playMod) {
                    case 0:
                        //順序播放
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_NONE, true);
                        break;
                    case 1:
                        //單曲循環
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_ONE, true);
                        break;
                    case 2:
                        //隨機播放
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_SHUFFLE, true);
                        break;
                }
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
        if (mTimerTask == null) mTimerTask = new TimerTaskManager();
        if (onPlayerEventListener == null) {
            onPlayerEventListener = new OnPlayerEventListener() {
                @Override
                public void onMusicSwitch(@NonNull SongInfo songInfo) {
                    channel.invokeMethod("currSong", GsonUtil.GsonString(songInfo));
                    Log.d(TAG, "onMusicSwitch: ======" + songInfo.getSongName());
                }

                @Override
                public void onPlayerStart() {
                    mTimerTask.startToUpdateProgress();
                    channel.invokeMethod("state", "start");
                    Log.d(TAG, "onPlayerStart: ======");
                }

                @Override
                public void onPlayerPause() {
                    mTimerTask.stopToUpdateProgress();
                    channel.invokeMethod("state", "pause");
                    Log.d(TAG, "onPlayerPause: ======");
                }

                @Override
                public void onPlayerStop() {
                    mTimerTask.stopToUpdateProgress();
                    channel.invokeMethod("state", "stop");
                    Log.d(TAG, "onPlayerStop: ======");
                }

                @Override
                public void onPlayCompletion(@NonNull SongInfo songInfo) {
                    mTimerTask.stopToUpdateProgress();
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
                    mTimerTask.stopToUpdateProgress();
                    Log.d(TAG, "onError: ======" + errorMsg);
                }
            };
        }
        StarrySky.Companion.with().addPlayerEventListener(onPlayerEventListener);
    }


    private void listenerPos() {
        //设置更新回调
        mTimerTask.setUpdateProgressTask(() -> {
            long position = StarrySky.Companion.with().getPlayingPosition();
            long duration = StarrySky.Companion.with().getDuration();
            long buffered = StarrySky.Companion.with().getBufferedPosition();
            channel.invokeMethod("playPosition", position);
        });
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
                .setInterceptorTimeOut(10 * 1000)
                .isOpenNotification(true)
                .setNotificationConfig(notificationConfig)
                .build();
        StarrySky.Companion.init((Application) context, config, null);
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
        public void process(@Nullable final SongInfo songInfo, @NotNull MainLooper mainLooper, @NotNull final InterceptorCallback callback) {
            if (songInfo == null) {
                callback.onInterrupt(new RuntimeException("SongInfo is null"));
                return;
            }
            if (TextUtils.isEmpty(songInfo.getSongUrl())) {
                mMusicRequest.getSongUrl(songInfo.getSongId(), songUrl -> {
                    songInfo.setSongUrl(songUrl);
                    callback.onContinue(songInfo);
                }, channel, mainLooper);
            } else {
                callback.onContinue(songInfo);
            }
        }
    }
}
