package com.sixbugs.bujuan.entity;

public class Lyric{

    /**
     * code : 200
     * qfy : false
     * klyric : {"lyric":null,"version":0}
     * sfy : false
     * tlyric : {"lyric":null,"version":0}
     * lrc : {"lyric":"[00:00.000] 作曲 : 隔壁老樊\n[00:00.361] 作词 : 隔壁老樊\n[00:01.85]我曾被无数的冷风\n[00:03.94]吹透我胸口\n[00:09.95]我曾被遥远的梦\n[00:12.19]逼着我仰望星空\n[00:17.04]我曾被无数的嘲讽\n[00:19.84]让我放弃我的音乐梦\n[00:25.19]我曾被无数的黄土\n[00:28.25]淹没我的澎湃汹涌\n[01:06.53]我曾想要我的歌声\n[01:09.59]无尽沉沦的感动\n[01:14.88]我曾把他们当成我\n[01:16.81]风雨过后那一道彩虹\n[01:23.18]我曾把堕落的原因\n[01:26.35]都丢给时间\n[01:31.40]我曾把机会就扔在我眼前\n[01:39.64]我曾把完整的镜子打碎\n[01:43.52]夜晚的枕头都是眼泪\n[01:47.65]我多想让过去重来\n[01:51.22]再给我一次机会\n[01:56.23]我想说过去的时间\n[02:00.25]我谁都不为\n[02:04.42]除了空谈\n[02:07.58]也就是事事非非\n[02:54.42]我曾想要我的歌声\n[02:57.22]无尽沉沦的感动\n[03:02.37]我曾把他们当作我\n[03:04.26]风雨过后那一道彩虹\n[03:10.59]我曾把堕落的原因\n[03:14.00]都丢给时间\n[03:18.70]我曾把机会就扔在我眼前\n[03:27.01]我曾把完整的镜子打碎\n[03:31.34]夜晚的枕头都是眼泪\n[03:35.31]我多想让过去重来\n[03:38.79]再给我一次机会\n[03:43.51]我想说过去的时间\n[03:47.80]我谁都不为\n[03:52.19]除了空谈\n[03:54.97]也就是事事非非\n[04:00.17]我曾把完整的镜子打碎\n[04:04.40]夜晚的枕头都是眼泪\n[04:08.49]我多想让过去重来\n[04:11.89]再给我一次机会\n[04:16.62]我想说过去的时间\n[04:20.85]我谁都不为\n[04:33.33]除了空谈\n[04:36.49]也就是事事非非\n","version":6}
     * sgc : true
     */

    private int code;
    private boolean qfy;
    private KlyricBean klyric;
    private boolean sfy;
    private TlyricBean tlyric;
    private LrcBean lrc;
    private boolean sgc;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public boolean isQfy() {
        return qfy;
    }

    public void setQfy(boolean qfy) {
        this.qfy = qfy;
    }

    public KlyricBean getKlyric() {
        return klyric;
    }

    public void setKlyric(KlyricBean klyric) {
        this.klyric = klyric;
    }

    public boolean isSfy() {
        return sfy;
    }

    public void setSfy(boolean sfy) {
        this.sfy = sfy;
    }

    public TlyricBean getTlyric() {
        return tlyric;
    }

    public void setTlyric(TlyricBean tlyric) {
        this.tlyric = tlyric;
    }

    public LrcBean getLrc() {
        return lrc;
    }

    public void setLrc(LrcBean lrc) {
        this.lrc = lrc;
    }

    public boolean isSgc() {
        return sgc;
    }

    public void setSgc(boolean sgc) {
        this.sgc = sgc;
    }

    public static class KlyricBean {
        /**
         * lyric : null
         * version : 0
         */

        private Object lyric;
        private int version;

        public Object getLyric() {
            return lyric;
        }

        public void setLyric(Object lyric) {
            this.lyric = lyric;
        }

        public int getVersion() {
            return version;
        }

        public void setVersion(int version) {
            this.version = version;
        }
    }

    public static class TlyricBean {
        /**
         * lyric : null
         * version : 0
         */

        private String lyric;
        private int version;

        public String getLyric() {
            return lyric;
        }

        public void setLyric(String lyric) {
            this.lyric = lyric;
        }

        public int getVersion() {
            return version;
        }

        public void setVersion(int version) {
            this.version = version;
        }
    }

    public static class LrcBean {
        /**
         * lyric : [00:00.000] 作曲 : 隔壁老樊
         [00:00.361] 作词 : 隔壁老樊
         [00:01.85]我曾被无数的冷风
         [00:03.94]吹透我胸口
         [00:09.95]我曾被遥远的梦
         [00:12.19]逼着我仰望星空
         [00:17.04]我曾被无数的嘲讽
         [00:19.84]让我放弃我的音乐梦
         [00:25.19]我曾被无数的黄土
         [00:28.25]淹没我的澎湃汹涌
         [01:06.53]我曾想要我的歌声
         [01:09.59]无尽沉沦的感动
         [01:14.88]我曾把他们当成我
         [01:16.81]风雨过后那一道彩虹
         [01:23.18]我曾把堕落的原因
         [01:26.35]都丢给时间
         [01:31.40]我曾把机会就扔在我眼前
         [01:39.64]我曾把完整的镜子打碎
         [01:43.52]夜晚的枕头都是眼泪
         [01:47.65]我多想让过去重来
         [01:51.22]再给我一次机会
         [01:56.23]我想说过去的时间
         [02:00.25]我谁都不为
         [02:04.42]除了空谈
         [02:07.58]也就是事事非非
         [02:54.42]我曾想要我的歌声
         [02:57.22]无尽沉沦的感动
         [03:02.37]我曾把他们当作我
         [03:04.26]风雨过后那一道彩虹
         [03:10.59]我曾把堕落的原因
         [03:14.00]都丢给时间
         [03:18.70]我曾把机会就扔在我眼前
         [03:27.01]我曾把完整的镜子打碎
         [03:31.34]夜晚的枕头都是眼泪
         [03:35.31]我多想让过去重来
         [03:38.79]再给我一次机会
         [03:43.51]我想说过去的时间
         [03:47.80]我谁都不为
         [03:52.19]除了空谈
         [03:54.97]也就是事事非非
         [04:00.17]我曾把完整的镜子打碎
         [04:04.40]夜晚的枕头都是眼泪
         [04:08.49]我多想让过去重来
         [04:11.89]再给我一次机会
         [04:16.62]我想说过去的时间
         [04:20.85]我谁都不为
         [04:33.33]除了空谈
         [04:36.49]也就是事事非非
         * version : 6
         */

        private String lyric;
        private int version;

        public String getLyric() {
            return lyric;
        }

        public void setLyric(String lyric) {
            this.lyric = lyric;
        }

        public int getVersion() {
            return version;
        }

        public void setVersion(int version) {
            this.version = version;
        }
    }
}
