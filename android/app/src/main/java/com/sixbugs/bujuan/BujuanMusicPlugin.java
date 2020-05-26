package com.sixbugs.bujuan;


import android.content.Intent;
import android.support.v4.media.session.PlaybackStateCompat;
import android.util.Log;


import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

import com.lzx.starrysky.StarrySky;
import com.lzx.starrysky.control.RepeatMode;
import com.lzx.starrysky.provider.SongInfo;
import com.sixbugs.bujuan.entity.SongBean;
import com.sixbugs.bujuan.utils.GsonUtil;
import com.sixbugs.bujuan.utils.PrefUtils;


import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * BujuanMusicPlugin
 */
public class BujuanMusicPlugin implements MethodCallHandler {
    /**
     * 插件标识
     */
    public static String CHANNEL = "music_plugin";

    public static MethodChannel channel;

    private static MainActivity activity;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        BujuanMusicPlugin instance = new BujuanMusicPlugin();
        channel.setMethodCallHandler(instance);
        activity = (MainActivity) registrar.activity();
    }

    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {
        if (methodCall.method.equals("songInfo")) {
            PrefUtils.putBoolean(activity, "isFm", false);
            String readList = methodCall.argument("readList");
            int playIndex = methodCall.argument("playIndex");
            List<SongBean> songs = GsonUtil.jsonToList(readList, SongBean.class);
            List<SongInfo> songInfos = new ArrayList<>();
            for (SongBean song : songs) {
                SongInfo songInfo = new SongInfo();
                songInfo.setSongName(song.getName() == null ? "" : song.getName());
                songInfo.setSongCover(song.getPicUrl() == null ? "" : song.getPicUrl());
                songInfo.setSongId(song.getId() == null ? "001" : song.getId());
                songInfo.setArtist(song.getSinger() == null ? "" : song.getSinger());
                songInfo.setSongUrl(song.getUrl() == null ? "" : song.getUrl());
                songInfos.add(songInfo);
            }
            StarrySky.Companion.with().playMusic(songInfos, playIndex);
            result.success("");
        } else if (methodCall.method.equals("control")) {
            String task = methodCall.argument("task");
            if (task != null)
                if (task.equals("play"))
                    StarrySky.Companion.with().restoreMusic();
                else if (task.equals("pause"))
                    StarrySky.Companion.with().pauseMusic();
                else if (task.equals("next"))
                    StarrySky.Companion.with().skipToNext();
                else if (task.equals("previous"))
                    StarrySky.Companion.with().skipToPrevious();
        } else if (methodCall.method.equals("fm")) {
            String readList = methodCall.argument("fmList");
            PrefUtils.putBoolean(activity, "isFm", true);
            List<SongBean> songs = GsonUtil.jsonToList(readList, SongBean.class);
            List<SongInfo> songInfos = new ArrayList<>();
            for (SongBean song : songs) {
                SongInfo songInfo = new SongInfo();
                songInfo.setSongName(song.getName() == null ? "" : song.getName());
                songInfo.setSongCover(song.getPicUrl() == null ? "" : song.getPicUrl());
                songInfo.setSongId(song.getId() == null ? "001" : song.getId());
                songInfo.setArtist(song.getSinger() == null ? "" : song.getSinger());
                songInfo.setSongUrl(song.getUrl() == null ? "" : song.getUrl());
                songInfos.add(songInfo);
            }
            StarrySky.Companion.with().playMusic(songInfos, 0);
            result.success("success");
        } else if (methodCall.method.equals("lyric")) {
            Intent intent = new Intent(activity, LyricActivity.class);
            String dark = methodCall.argument("dark");
            intent.putExtra("dark", dark);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            activity.startActivity(intent);
        } else if (methodCall.method.equals("playIndex")) {
            int index = methodCall.argument("index");
            StarrySky.Companion.with().playMusicByIndex(index);
        } else if (methodCall.method.equals("seekTo")) {
            String seekNum = methodCall.argument("seekNum");
            if (seekNum != null) {
                StarrySky.Companion.with().seekTo(Long.parseLong(seekNum));
            }
        } else if ((methodCall.method.equals("playMode"))) {
            int mod = methodCall.argument("mode");
            Log.d("TAG", "onMethodCall: ====" + mod);
            RepeatMode repeatMode = StarrySky.Companion.with().getRepeatMode();
            switch (repeatMode.getRepeatMode()) {
                case RepeatMode.REPEAT_MODE_NONE:
                    if (repeatMode.isLoop()) {
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_ONE, true);
                    } else {
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_NONE, true);
                    }
                    break;
                case RepeatMode.REPEAT_MODE_ONE:
                    if (repeatMode.isLoop()) {
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_SHUFFLE, true);
                    } else {
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_ONE, true);
                    }
                case RepeatMode.REPEAT_MODE_SHUFFLE:
                    if (repeatMode.isLoop()) {
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_NONE, true);
                    } else {
                        StarrySky.Companion.with().setRepeatMode(RepeatMode.REPEAT_MODE_SHUFFLE, true);
                    }
                    break;
                default:
            }
//            if (mod == 0) {
//                StarrySky.Companion.with().setRepeatMode(PlaybackStateCompat.REPEAT_MODE_ALL, true);
//            } else if (mod == 1) {
//                StarrySky.Companion.with().setRepeatMode(PlaybackStateCompat.REPEAT_MODE_ONE, true);
//            } else {
//                StarrySky.Companion.with().setRepeatMode(PlaybackStateCompat.SHUFFLE_MODE_ALL, true);
//            }
        } else {
            result.notImplemented();
        }
    }

    private void getPlayList(Result result) {
        List<SongInfo> playList = StarrySky.Companion.with().getPlayList();
        for (SongInfo songInfo : playList) {

        }
        StarrySky.Companion.with().getNowPlayingIndex();
        result.success("");
    }

    public boolean fileIsExists(String strFile) {
        try {
            File f = new File(strFile);
            if (!f.exists()) {
                return false;
            }

        } catch (Exception e) {
            return false;
        }

        return true;
    }
}
