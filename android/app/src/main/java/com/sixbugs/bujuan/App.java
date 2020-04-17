package com.sixbugs.bujuan;

import android.Manifest;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Environment;
import android.text.TextUtils;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.lzx.starrysky.StarrySky;
import com.lzx.starrysky.StarrySkyBuilder;
import com.lzx.starrysky.StarrySkyConfig;
import com.lzx.starrysky.delayaction.Valid;
import com.lzx.starrysky.notification.NotificationConfig;
import com.lzx.starrysky.notification.StarrySkyNotificationManager;
import com.lzx.starrysky.provider.SongInfo;
import com.lzx.starrysky.registry.StarrySkyRegistry;
import com.lzx.starrysky.utils.StarrySkyUtils;
import com.qw.soul.permission.SoulPermission;
import com.qw.soul.permission.bean.Permission;
import com.qw.soul.permission.bean.Permissions;
import com.qw.soul.permission.callbcak.CheckRequestPermissionsListener;
import com.sixbugs.bujuan.imageloader.GlideLoader;

import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        StarrySky.init(this, new TestConfig());
        StarrySkyUtils.isDebug = true;

    }

    private static class TestConfig extends StarrySkyConfig {

        @Override
        public void applyOptions(@NonNull Context context, @NonNull StarrySkyBuilder builder) {
            super.applyOptions(context, builder);
            builder.setOpenNotification(true);
//            builder.setOpenCache(true);
//            String destFileDir = Environment.getExternalStorageDirectory().getAbsolutePath() + "/Android/data/com.sixbugs.bujuan/cache/";
//            builder.setCacheDestFileDir(destFileDir);
        }

        @Override
        public StarrySkyNotificationManager.NotificationFactory getNotificationFactory() {
            return StarrySkyNotificationManager.Companion.getSYSTEM_NOTIFICATION_FACTORY();
        }

        @Override
        public void applyStarrySkyRegistry(@NonNull Context context, StarrySkyRegistry registry) {
            super.applyStarrySkyRegistry(context, registry);
            registry.appendValidRegistry(new RequestSongInfoValid(context));
            NotificationConfig config = new NotificationConfig();
            config.setTargetClass("com.sixbugs.bujuan.MainActivity");
            config.setNotificationCanClearBySystemBtn(true);
            config.setSmallIconRes(R.drawable.music);
            registry.registryNotificationConfig(config);
            registry.registryImageLoader(new GlideLoader());
        }
    }

    public static class RequestSongInfoValid implements Valid {
        private MusicRequest mMusicRequest;
        private Context mContext;

        RequestSongInfoValid(Context context) {
            mContext = context;
            mMusicRequest = new MusicRequest();
        }

        @Override
        public void doValid(SongInfo songInfo, ValidCallback callback) {
            SoulPermission.getInstance().checkAndRequestPermissions(
                    Permissions.build(
                            Manifest.permission.READ_EXTERNAL_STORAGE,
                            Manifest.permission.WRITE_EXTERNAL_STORAGE),
                    new CheckRequestPermissionsListener() {
                        @Override
                        public void onAllPermissionOk(Permission[] allPermissions) {
                            if (TextUtils.isEmpty(songInfo.getSongUrl())) {
                                mMusicRequest.getSongUrl(songInfo.getSongId(), songUrl -> {
                                    songInfo.setSongUrl(songUrl); //给songInfo设置Url
                                    callback.finishValid();
                                });
                            } else {
                                callback.doActionDirect();
                            }
                        }

                        @Override
                        public void onPermissionDenied(Permission[] refusedPermissions) {
                            Toast.makeText(mContext, "没有权限，播放失败", Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

}
