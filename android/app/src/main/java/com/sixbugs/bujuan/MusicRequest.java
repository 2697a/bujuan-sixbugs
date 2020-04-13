package com.sixbugs.bujuan;

import com.lzx.starrysky.provider.SongInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BasicMessageChannel;

public class MusicRequest {

    BasicMessageChannel<Object> basicMessageChannelPlugin;
    Map<String,String> map ;

    public MusicRequest() {
    }

//    /**
//     * 获取数据
//     */
//    public void getMusicList(Context context, RequestCallback callback) {
//        Request request = new Request.Builder()
//                .url("http://tingapi.ting.baidu.com/v1/restserver/ting?" +
//                        "format=json" +
//                        "&calback=" +
//                        "&from=webapp_music" +
//                        "&method=baidu.ting.billboard.billList" +
//                        "&type=2" +
//                        "&size=20" +
//                        "&offset=0")
//                .build();
//        client.newCall(request).enqueue(new Callback() {
//            @Override
//            public void onFailure(@NotNull Call call, @NotNull IOException e) {
//                Toast.makeText(context, "接口请求失败", Toast.LENGTH_SHORT).show();
//            }
//
//            @Override
//            public void onResponse(@NotNull Call call, @NotNull Response response)
//                    throws IOException {
//                try {
//                    String json = response.body().string();
//                    JSONObject jsonObject = new JSONObject(json);
//                    JSONArray jsonArray = jsonObject.getJSONArray("song_list");
//                    List<SongInfo> list = new ArrayList<>();
//                    for (int i = 0; i < jsonArray.length(); i++) {
//                        JSONObject object = jsonArray.getJSONObject(i);
//                        SongInfo info = new SongInfo();
//                        info.setSongId(object.getString("song_id"));
//                        info.setSongCover(object.getString("pic_big"));
//                        info.setSongName(object.getString("title"));
//                        info.setArtist(object.getString("author"));
//                        list.add(info);
//                        callback.onSuccess(list);
//                    }
//                } catch (JSONException e) {
//                    e.printStackTrace();
//                }
//            }
//        });
//    }


    public void getSongUrl(String songId, RequestInfoCallback callback) {
        if (basicMessageChannelPlugin == null) {
            basicMessageChannelPlugin = MainActivity.basicMessageChannelPlugin;
        }
        if(map==null){
            map = new HashMap<>();
        }
        map.put("type","getUrl");
        map.put("id",songId);
        basicMessageChannelPlugin.send(map, reply -> {
            callback.onSuccess(reply.toString());
        });
    }

    /**
     * 获取音频url
     */
//    public void getSongInfoDetail(String songId, RequestInfoCallback callback) {
//        Request request = new Request.Builder()
//                .url("http://127.0.0.1:3001/song/url?id=" +
//                        songId + "&br=128000")
//                .build();
//        client.newCall(request).enqueue(new Callback() {
//            @Override
//            public void onFailure(@NotNull Call call, @NotNull IOException e) {
//                Log.d("======", "onFailure: " + e.getLocalizedMessage());
//                callback.onSuccess("https://music.163.com/song/media/outer/url?id=" + songId + ".mp3");
//            }
//
//            @Override
//            public void onResponse(@NotNull Call call, @NotNull Response response)
//                    throws IOException {
//                if (response.code() == 200) {
//                    String string = Objects.requireNonNull(response.body()).string();
//                    Log.d("======", "onResponse: " + string);
//                    SongUrl songUrl = JSON.parseObject(string, SongUrl.class);
//                    if (songUrl != null && songUrl.getData() != null && songUrl.getData().size() > 0 && !TextUtils.isEmpty(songUrl.getData().get(0).getUrl())) {
//                        String url = songUrl.getData().get(0).getUrl();
//                        callback.onSuccess(url);
//                    } else {
//                        callback.onSuccess("https://music.163.com/song/media/outer/url?id=" + songId + ".mp3");
//                    }
//                } else {
//                    callback.onSuccess("https://music.163.com/song/media/outer/url?id=" + songId + ".mp3");
//                }
//            }
//        });
//    }

    interface RequestCallback {
        void onSuccess(List<SongInfo> list);
    }

    public interface RequestInfoCallback {
        void onSuccess(String songUrl);
    }
}
