package com.sixbugs.bujuan.entity;

import java.util.List;

public class SongUrl{

    /**
     * data : [{"id":1333335577,"url":"http://m10.music.126.net/20191130032254/bc76b51a4ca4db102876ba920c1920cf/ymusic/0652/025f/0108/18227a204f556b2574fd6b3f964ae633.mp3","br":128000,"size":3558130,"md5":"18227a204f556b2574fd6b3f964ae633","code":200,"expi":1200,"type":"mp3","gain":0,"fee":8,"uf":null,"payed":0,"flag":4,"canExtend":false,"freeTrialInfo":null,"level":"standard","encodeType":"mp3"}]
     * code : 200
     */

    private int code;
    private List<DataBean> data;

    public SongUrl() {
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean {
        /**
         * id : 1333335577
         * url : http://m10.music.126.net/20191130032254/bc76b51a4ca4db102876ba920c1920cf/ymusic/0652/025f/0108/18227a204f556b2574fd6b3f964ae633.mp3
         * br : 128000
         * size : 3558130
         * md5 : 18227a204f556b2574fd6b3f964ae633
         * code : 200
         * expi : 1200
         * type : mp3
         * gain : 0
         * fee : 8
         * uf : null
         * payed : 0
         * flag : 4
         * canExtend : false
         * freeTrialInfo : null
         * level : standard
         * encodeType : mp3
         */

        private int id;
        private String url;
        private int br;
        private int size;
        private String md5;
        private int code;
        private int expi;
        private String type;
        private int gain;
        private int fee;
        private Object uf;
        private int payed;
        private int flag;
        private boolean canExtend;
        private Object freeTrialInfo;
        private String level;
        private String encodeType;

        public DataBean() {
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public int getBr() {
            return br;
        }

        public void setBr(int br) {
            this.br = br;
        }

        public int getSize() {
            return size;
        }

        public void setSize(int size) {
            this.size = size;
        }

        public String getMd5() {
            return md5;
        }

        public void setMd5(String md5) {
            this.md5 = md5;
        }

        public int getCode() {
            return code;
        }

        public void setCode(int code) {
            this.code = code;
        }

        public int getExpi() {
            return expi;
        }

        public void setExpi(int expi) {
            this.expi = expi;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public int getGain() {
            return gain;
        }

        public void setGain(int gain) {
            this.gain = gain;
        }

        public int getFee() {
            return fee;
        }

        public void setFee(int fee) {
            this.fee = fee;
        }

        public Object getUf() {
            return uf;
        }

        public void setUf(Object uf) {
            this.uf = uf;
        }

        public int getPayed() {
            return payed;
        }

        public void setPayed(int payed) {
            this.payed = payed;
        }

        public int getFlag() {
            return flag;
        }

        public void setFlag(int flag) {
            this.flag = flag;
        }

        public boolean isCanExtend() {
            return canExtend;
        }

        public void setCanExtend(boolean canExtend) {
            this.canExtend = canExtend;
        }

        public Object getFreeTrialInfo() {
            return freeTrialInfo;
        }

        public void setFreeTrialInfo(Object freeTrialInfo) {
            this.freeTrialInfo = freeTrialInfo;
        }

        public String getLevel() {
            return level;
        }

        public void setLevel(String level) {
            this.level = level;
        }

        public String getEncodeType() {
            return encodeType;
        }

        public void setEncodeType(String encodeType) {
            this.encodeType = encodeType;
        }
    }
}
