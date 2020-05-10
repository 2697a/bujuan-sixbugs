package com.sixbugs.bujuan;

import android.view.View;
import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.lzx.starrysky.StarrySky;
import com.lzx.starrysky.control.OnPlayerEventListener;
import com.lzx.starrysky.provider.SongInfo;
import com.lzx.starrysky.utils.TimerTaskManager;
import com.sixbugs.bujuan.entity.Lyric;
import com.sixbugs.bujuan.entity.SongBean;
import com.sixbugs.bujuan.utils.ActivityUtils;
import com.sixbugs.bujuan.utils.GsonUtil;
import com.sixbugs.bujuan.utils.PrefUtils;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.EventChannel;
import me.wcy.lrcview.LrcView;

public class LyricActivity extends AppCompatActivity implements OnPlayerEventListener {

    private LrcView lrcView;
    private LinearLayout lrcMain;
    private TextView songName;
    private TextView songSinger;
    private TimerTaskManager mTimerTask;
    private BasicMessageChannel<Object> basicMessageChannelPlugin;
    Map<String, String> map;

    private String TAG = "LyricActivity";
    private String zhLyric = "";
    private String enLyric = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= 21){
            View decorView = getWindow().getDecorView();
            decorView.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
            getWindow().setStatusBarColor(Color.TRANSPARENT);
        }
        setContentView(R.layout.activity_lyric);
        lrcMain = findViewById(R.id.lrcMain);
        songSinger = findViewById(R.id.songSinger);
        songName = findViewById(R.id.songName);
        SongInfo nowPlayingSongInfo = StarrySky.Companion.with().getNowPlayingSongInfo();
        if (nowPlayingSongInfo != null) {
            songSinger.setText(nowPlayingSongInfo.getSongName());
            songName.setText(nowPlayingSongInfo.getArtist());
        }
        String dark = getIntent().getStringExtra("dark");
        if (dark.equals("0")) {
            lrcMain.setBackgroundColor(Color.WHITE);
            songName.setTextColor(Color.BLACK);
            songSinger.setTextColor(Color.GRAY);
        } else {
            lrcMain.setBackgroundColor(Color.parseColor("#FF303030"));
            songName.setTextColor(Color.WHITE);
            songSinger.setTextColor(Color.WHITE);
        }
        lrcView = findViewById(R.id.lrcView);
//        lrcView.setCurrentColor(Color.GREEN);
        if (mTimerTask == null) mTimerTask = new TimerTaskManager();
        StarrySky.Companion.with().addPlayerEventListener(this);
        getLyric(StarrySky.Companion.with().getNowPlayingSongId());
        listenerPos();
        //获取当前歌曲的播放进度，更新歌词位置
        long playingPosition = StarrySky.Companion.with().getPlayingPosition();
        lrcView.updateTime(playingPosition);
        //如果正在播放开始监听
        boolean playing = StarrySky.Companion.with().isPlaying();
        if (playing) {
            mTimerTask.startToUpdateProgress();
        }
        //歌词滑动监听
        lrcView.setDraggable(true, time -> {
            StarrySky.Companion.with().seekTo(time);
            return true;
        });
    }

    //获取歌词
    private void getLyric(String id) {
        zhLyric = PrefUtils.getString(LyricActivity.this, id + "zh", "");
        enLyric = PrefUtils.getString(LyricActivity.this, id + "en", "");
        if (!TextUtils.isEmpty(zhLyric)) {
            lrcView.loadLrc(zhLyric, enLyric);
        } else {
            if (basicMessageChannelPlugin == null)
                basicMessageChannelPlugin = MainActivity.basicMessageChannelPlugin;
            if (map == null) map = new HashMap<>();
            map.put("type", "getLyric");
            map.put("id", id);
            basicMessageChannelPlugin.send(map, reply -> {
                if (reply != null) {
                    Map<String,String> lyricMap = (Map<String, String>) reply;
                    Lyric lyric = GsonUtil.GsonToBean(lyricMap.get("lyric"), Lyric.class);
                    int code = lyric.getCode();
                    if (code == 200) {
                        if (lyric.getLrc() != null) zhLyric = lyric.getLrc().getLyric();
                        if (lyric.getTlyric() != null) enLyric = lyric.getTlyric().getLyric();
                        PrefUtils.putString(LyricActivity.this, id + "zh", zhLyric);
                        PrefUtils.putString(LyricActivity.this, id + "en", enLyric);
                        lrcView.loadLrc(zhLyric, enLyric);
                    }
                }
            });
        }
    }


    private void listenerPos() {
        //设置更新回调
        mTimerTask.setUpdateProgressTask(() -> {
            long position = StarrySky.Companion.with().getPlayingPosition();
            long duration = StarrySky.Companion.with().getDuration();
            long buffered = StarrySky.Companion.with().getBufferedPosition();
            lrcView.updateTime(position);
        });
    }

    @Override
    public void onBuffering() {

    }

    @Override
    public void onError(int i, @NotNull String s) {
        mTimerTask.stopToUpdateProgress();
    }

    @Override
    public void onMusicSwitch(@NotNull SongInfo songInfo) {
        songSinger.setText(songInfo.getSongName());
        songName.setText(songInfo.getArtist());
        getLyric(songInfo.getSongId());
    }

    @Override
    public void onPlayCompletion(@NotNull SongInfo songInfo) {
        mTimerTask.stopToUpdateProgress();
    }

    @Override
    public void onPlayerPause() {
        mTimerTask.stopToUpdateProgress();
    }

    @Override
    public void onPlayerStart() {
        mTimerTask.startToUpdateProgress();
    }

    @Override
    public void onPlayerStop() {
        mTimerTask.stopToUpdateProgress();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        StarrySky.Companion.with().removePlayerEventListener(this);
        mTimerTask.removeUpdateProgressTask();
    }
}
