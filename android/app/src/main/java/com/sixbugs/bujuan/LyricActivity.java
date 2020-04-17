package com.sixbugs.bujuan;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import me.wcy.lrcview.LrcView;

public class LyricActivity extends AppCompatActivity {

    private  LrcView lrcView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lyric);
        lrcView = findViewById(R.id.lrcView);
    }
}
