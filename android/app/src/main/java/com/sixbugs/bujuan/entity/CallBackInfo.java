package com.sixbugs.bujuan.entity;

import java.util.List;

public class CallBackInfo {
    List<SongBean> songs;

    int index;

    public CallBackInfo() {
    }

    public List<SongBean> getSongs() {
        return songs;
    }

    public void setSongs(List<SongBean> songs) {
        this.songs = songs;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }
}
