package com.sixbugs.bujuan;

import android.Manifest;
import android.os.Bundle;
import android.os.PowerManager;
import android.widget.Toast;

import com.lzx.starrysky.StarrySky;
import com.lzx.starrysky.control.OnPlayerEventListener;
import com.lzx.starrysky.provider.SongInfo;
import com.lzx.starrysky.utils.TimerTaskManager;
import com.qw.soul.permission.SoulPermission;
import com.qw.soul.permission.bean.Permission;
import com.qw.soul.permission.bean.Permissions;
import com.qw.soul.permission.callbcak.CheckRequestPermissionsListener;
import com.sixbugs.bujuan.entity.Lyric;
import com.sixbugs.bujuan.entity.SongBean;
import com.sixbugs.bujuan.utils.GsonUtil;
import com.sixbugs.bujuan.utils.PrefUtils;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.MethodChannel;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements OnPlayerEventListener {
    //    private BuJuanMusicListenPlugin buJuanMusicListenPlugin;
    private TimerTaskManager mTimerTask;
    private Map<String, String> map = new HashMap<>();
    private BuJuanMusicPlayListenPlugin buJuanMusicPlayListenPlugin;
    public static BasicMessageChannel<Object> basicMessageChannelPlugin;
    private String zhLyric = "";
    private String enLyric = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        StarrySky.with().addPlayerEventListener(this);
        BujuanMusicPlugin.registerWith(this.registrarFor(BujuanMusicPlugin.CHANNEL));
        MyViewFlutterPlugin.registerWith(this);
        buJuanMusicPlayListenPlugin = BuJuanMusicPlayListenPlugin.registerWith(this.registrarFor(BuJuanMusicPlayListenPlugin.CHANNEL));
        basicMessageChannelPlugin = new BasicMessageChannel<>(getFlutterView(), Config.URL_FM_CHANNEL, StandardMessageCodec.INSTANCE);
        listenerPos();
        getRead();
        //通讯名称,回到手机桌面
        String CHANNEL = "android/back/desktop";
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    if (methodCall.method.equals("backDesktop")) {
                        result.success(true);
                        moveTaskToBack(false);
                    }
                }
        );
        basicMessageChannelPlugin.setMessageHandler((message, reply) -> {
            if (message.equals("local")) {
                List<SongInfo> songInfos = StarrySky.with().querySongInfoInLocal();
                List<SongBean> songs = new ArrayList<>();
                for (SongInfo songInfo : songInfos) {
                    SongBean song = new SongBean();
                    String size = songInfo.getSize();
                    long l = Long.parseLong(size);
                    if (l / 1024 / 1024 > 1) {
                        song.setId(songInfo.getSongId());
                        song.setName(songInfo.getSongName());
                        song.setUrl(songInfo.getSongUrl());
                        song.setPicUrl(songInfo.getAlbumCover());
                        song.setSinger(songInfo.getArtist());
                        songs.add(song);
                    }
                }
                reply.reply(GsonUtil.GsonString(songs));
            }
        });
    }


    private void getRead() {
        SoulPermission.getInstance().checkAndRequestPermissions(
                Permissions.build(
                        Manifest.permission.READ_EXTERNAL_STORAGE,
                        Manifest.permission.WRITE_EXTERNAL_STORAGE),
                new CheckRequestPermissionsListener() {
                    @Override
                    public void onAllPermissionOk(Permission[] allPermissions) {
                    }

                    @Override
                    public void onPermissionDenied(Permission[] refusedPermissions) {
                        Toast.makeText(MainActivity.this, "没有给权限，缓存将会失败", Toast.LENGTH_SHORT).show();
                    }
                });
    }

    private void listenerPos() {
        mTimerTask = new TimerTaskManager();
        //设置更新回调
        mTimerTask.setUpdateProgressTask(() -> {
            long position = StarrySky.with().getPlayingPosition();
            long duration = StarrySky.with().getDuration();
            long buffered = StarrySky.with().getBufferedPosition();
            map.clear();
            map.put("currSongPos", String.valueOf(position));
            map.put("currSongAllPos", String.valueOf(duration));
            EventChannel.EventSink event = buJuanMusicPlayListenPlugin.event;
            if (event != null)
                event.success(map);
        });
    }


    private void getLyric(String id) {
        map.clear();
        map.put("type", "getLyric");
        map.put("id", id);
        basicMessageChannelPlugin.send(map, reply -> {
            if (reply != null) {
                Lyric lyric = GsonUtil.GsonToBean(reply.toString(), Lyric.class);
                int code = lyric.getCode();
                if (code == 200) {
                    if (lyric.getLrc() != null) zhLyric = lyric.getLrc().getLyric();
                    if (lyric.getTlyric() != null) enLyric = lyric.getTlyric().getLyric();
                    PrefUtils.putString(MainActivity.this, id + "zh", zhLyric);
                    PrefUtils.putString(MainActivity.this, id + "en", enLyric);
                }
            }
        });
    }

    @Override
    public void onBuffering() {

    }

    @Override
    public void onError(int i, @NotNull String s) {
        mTimerTask.stopToUpdateProgress();
        StarrySky.with().skipToNext();
    }

    @Override
    public void onMusicSwitch(@NotNull SongInfo songInfo) {
        SongBean song = new SongBean();
        song.setId(songInfo.getSongId());
        song.setName(songInfo.getSongName());
        song.setSinger(songInfo.getArtist());
        song.setPicUrl(songInfo.getAlbumCover());
        getLyric(songInfo.getSongId());
        map.clear();
        map.put("type", "currSong");
        map.put("data", GsonUtil.GsonString(song));
        basicMessageChannelPlugin.send(map);
        boolean isFM = PrefUtils.getBoolean(MainActivity.this, "isFm", false);
        if (isFM) {
            //是fm的话播放完一首就在获取下
            map.clear();
            map.put("type", "getFm");
            basicMessageChannelPlugin.send(map, reply -> {
                Map<String, String> fm = (Map<String, String>) reply;
                List<SongBean> songs = GsonUtil.jsonToList(fm.get("fm"), SongBean.class);
                List<SongInfo> songInfos = new ArrayList<>();
                for (SongBean song_bean : songs) {
                    SongInfo songa = new SongInfo();
                    songa.setSongName(song_bean.getName() == null ? "" : song_bean.getName());
                    songa.setAlbumCover(song_bean.getPicUrl() == null ? "" : song_bean.getPicUrl());
                    songa.setSongId(song_bean.getId() == null ? "001" : song_bean.getId());
                    songa.setArtist(song_bean.getSinger() == null ? "" : song_bean.getSinger());
                    songInfos.add(songa);
                }
                if (songInfos.size() > 0)
                    StarrySky.with().addSongInfo(songInfos.get(0));
            });
        }else {
        }

    }

    @Override
    public void onPlayCompletion(@NotNull SongInfo songInfo) {
        map.clear();
        map.put("type", "state");
        map.put("data", "completion");
        mTimerTask.stopToUpdateProgress();
    }

    @Override
    public void onPlayerPause() {
        map.clear();
        map.put("type", "state");
        map.put("data", "pause");
        basicMessageChannelPlugin.send(map);
        mTimerTask.stopToUpdateProgress();
    }

    @Override
    public void onPlayerStart() {
        map.clear();
        map.put("type", "state");
        map.put("data", "start");
        basicMessageChannelPlugin.send(map);
        mTimerTask.startToUpdateProgress();
    }

    @Override
    public void onPlayerStop() {
        map.clear();
        map.put("type", "state");
        map.put("data", "start");
        basicMessageChannelPlugin.send(map);
        mTimerTask.stopToUpdateProgress();
    }

    @Override
    protected void onDestroy() {
        StarrySky.with().removePlayerEventListener(this);
        StarrySky.with().stopMusic();
        mTimerTask.removeUpdateProgressTask();
        super.onDestroy();
    }
}
