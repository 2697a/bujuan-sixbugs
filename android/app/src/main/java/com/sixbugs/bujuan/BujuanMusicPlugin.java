package com.sixbugs.bujuan;


import android.content.Intent;
import android.os.Bundle;
import android.support.v4.media.session.PlaybackStateCompat;
import android.util.Log;
import android.widget.Toast;


import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

import com.lzx.starrysky.StarrySky;
import com.lzx.starrysky.provider.SongInfo;
import com.sixbugs.bujuan.entity.SongBean;
import com.sixbugs.bujuan.imageloader.GsonUtil;


import java.io.File;
import java.io.Serializable;
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

    private static MethodChannel channel;

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
            String readList = methodCall.argument("readList");
            int playIndex = methodCall.argument("playIndex");
            List<SongBean> songs = GsonUtil.jsonToList(readList, SongBean.class);
            List<SongInfo> songInfos = new ArrayList<>();
            for (SongBean song : songs) {
                SongInfo songInfo = new SongInfo();
                songInfo.setSongName(song.getName() == null ? "" : song.getName());
                songInfo.setAlbumCover(song.getPicUrl() == null ? "" : song.getPicUrl());
                songInfo.setSongId(song.getId() == null ? "001" : song.getId());
                songInfo.setArtist(song.getSinger() == null ? "" : song.getSinger());
//                songInfo.setSongUrl(null);
                songInfos.add(songInfo);
            }
            StarrySky.with().playMusic(songInfos, playIndex);
            result.success("");
        } else if (methodCall.method.equals("control")) {
            String task = methodCall.argument("task");
            if (task != null)
                if (task.equals("play"))
                    StarrySky.with().restoreMusic();
                else if (task.equals("pause"))
                    StarrySky.with().pauseMusic();
                else if (task.equals("next"))
                    StarrySky.with().skipToNext();
                else if (task.equals("previous"))
                    StarrySky.with().skipToPrevious();
        } else if (methodCall.method.equals("local_music")) {
            //本地音乐
            List<SongInfo> songInfos = StarrySky.with().querySongInfoInLocal();
            List<SongBean> songs = new ArrayList<>();
            for (SongInfo songInfo : songInfos) {
                SongBean song = new SongBean();
                String size = songInfo.getSize();
                long l = Long.parseLong(size);
                if (l / 1024 / 1024 > 1) {
                    song.setId(songInfo.getSongId());
                    song.setName(songInfo.getSongName());
//                    song.setUrl(songInfo.getSongUrl());
                    song.setPicUrl(fileIsExists(songInfo.getAlbumCover()) ? songInfo.getAlbumCover() : null);
                    song.setSinger(songInfo.getArtist());
                    songs.add(song);
                }
                Log.d("", "onMethodCall: =======" + songInfo.getAlbumHDCover());
            }
            String local = GsonUtil.GsonString(songs);
            result.success(local);
        } else if (methodCall.method.equals("playSingleSong")) {
            int index = methodCall.argument("index") == null ? 0 : methodCall.argument("index");
            StarrySky.with().playMusicByIndex(index);
        } else if (methodCall.method.equals("seekTo")) {
            String seekNum = methodCall.argument("seekNum");
            if (seekNum != null) {
                StarrySky.with().seekTo(Long.parseLong(seekNum));
            }
        } else if ((methodCall.method.equals("playMode"))) {
            int mod = methodCall.argument("mode");
            if (mod == 0) {
                StarrySky.with().setShuffleMode(PlaybackStateCompat.SHUFFLE_MODE_NONE);
                StarrySky.with().setRepeatMode(PlaybackStateCompat.REPEAT_MODE_ALL);
            } else if (mod == 1) {
                StarrySky.with().setRepeatMode(PlaybackStateCompat.REPEAT_MODE_ONE);
            } else {
                StarrySky.with().setShuffleMode(PlaybackStateCompat.SHUFFLE_MODE_ALL);
            }
        } else {
            result.notImplemented();
        }
    }

    private void getPlayList(Result result) {
        List<SongInfo> playList = StarrySky.with().getPlayList();
        for (SongInfo songInfo : playList) {

        }
        StarrySky.with().getNowPlayingIndex();
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
