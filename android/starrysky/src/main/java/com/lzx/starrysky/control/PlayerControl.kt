package com.lzx.starrysky.control

import android.os.Bundle
import androidx.lifecycle.MutableLiveData
import com.lzx.starrysky.common.PlaybackStage
import com.lzx.starrysky.provider.SongInfo

data class RepeatMode(val repeatMode: Int, val isLoop: Boolean) {
    companion object {
        const val KEY_REPEAT_MODE = "StarrySky#KEY_REPEAT_MODE"
        const val REPEAT_MODE_NONE = 100     //顺序播放
        const val REPEAT_MODE_ONE = 200      //单曲播放
        const val REPEAT_MODE_SHUFFLE = 300  //随机播放
        const val REPEAT_MODE_REVERSE = 400  //倒序播放
    }
}

interface PlayerControl {

    /**
     * 根据songId播放,调用前请确保已经设置了播放列表
     */
    fun playMusicById(songId: String)

    /**
     * 根据 SongInfo 播放，实际也是根据 songId 播放
     */
    fun playMusicByInfo(info: SongInfo)

    /**
     * 根据要播放的歌曲在播放列表中的下标播放,调用前请确保已经设置了播放列表
     */
    fun playMusicByIndex(index: Int)

    /**
     * 播放
     *
     * @param mediaList 播放列表
     * @param index     要播放的歌曲在播放列表中的下标
     */
    fun playMusic(songInfos: MutableList<SongInfo>, index: Int)

    /**
     * 暂停
     */
    fun pauseMusic()

    /**
     * 恢复播放
     */
    fun restoreMusic()

    /**
     * 停止播放
     */
    fun stopMusic()

    /**
     * 准备播放
     */
    fun prepare()

    /**
     * 准备播放，根据songId
     */
    fun prepareFromSongId(songId: String)

    /**
     * 下一首
     */
    fun skipToNext()

    /**
     * 上一首
     */
    fun skipToPrevious()

    /**
     * 快进
     */
    fun fastForward()

    /**
     * 开始倒带 每调一次减 0.5 倍，最小为 0
     */
    fun rewind()

    /**
     * 指定语速,通过此方法可配置任意倍速，注意结果要大于0
     *
     * @param refer    refer 是否已当前速度为基数
     * @param multiple multiple 倍率
     */
    fun onDerailleur(refer: Boolean, multiple: Float)

    /**
     * 移动到媒体流中的新位置,以毫秒为单位。
     */
    fun seekTo(pos: Long)

    /**
     * 设置播放模式
     * 必须是以下之一：
     * REPEAT_MODE_NONE      顺序播放
     * REPEAT_MODE_ONE       单曲播放
     * REPEAT_MODE_SHUFFLE   随机播放
     * REPEAT_MODE_REVERSE   倒序播放
     *
     * isLoop 播放倒最后一首时是否从第一首开始循环播放,该参数对随机播放无效
     */
    fun setRepeatMode(repeatMode: Int, isLoop: Boolean)

    /**
     * 获取播放模式,默认顺序播放
     * REPEAT_MODE_NONE      顺序播放
     * REPEAT_MODE_ONE       单曲播放
     * REPEAT_MODE_SHUFFLE   随机播放
     * REPEAT_MODE_REVERSE   倒序播放
     */
    fun getRepeatMode(): RepeatMode

    /**
     * 获取播放列表
     */
    fun getPlayList(): MutableList<SongInfo>

    /**
     * 更新播放列表
     */
    fun updatePlayList(songInfos: MutableList<SongInfo>)

    /**
     * 添加更多播放列表
     */
    fun addPlayList(infos: MutableList<SongInfo>)

    /**
     * 添加一首歌
     */
    fun addSongInfo(info: SongInfo)

    /**
     * 删除
     */
    fun removeSongInfo(songId: String)

    /**
     * 获取当前播放的歌曲信息
     */
    fun getNowPlayingSongInfo(): SongInfo?

    /**
     * 获取当前播放的歌曲songId
     */
    fun getNowPlayingSongId(): String

    /**
     * 获取当前播放歌曲的下标
     */
    fun getNowPlayingIndex(): Int

    /**
     * 以ms为单位获取当前缓冲的位置。
     */
    fun getBufferedPosition(): Long

    /**
     * 获取播放位置 毫秒为单位。
     */
    fun getPlayingPosition(): Long

    /**
     * 是否有下一首
     */
    fun isSkipToNextEnabled(): Boolean

    /**
     * 是否有上一首
     */
    fun isSkipToPreviousEnabled(): Boolean

    /**
     * 将当前播放速度作为正常播放的倍数。 倒带时这应该是负数， 值为1表示正常播放，0表示暂停。
     */
    fun getPlaybackSpeed(): Float

    /**
     * 获取底层框架[android.media.session.PlaybackState]对象。
     * 此方法仅在API 21+上受支持。
     */
    fun getPlaybackState(): Any?

    /**
     * 获取发送错误时的错误信息
     */
    fun getErrorMessage(): CharSequence

    /**
     * 获取发送错误时的错误码
     * 0 : 这是默认的错误代码
     * 1 : 当应用程序状态无效以满足请求时的错误代码。
     * 2 : 应用程序不支持请求时的错误代码。
     * 3 : 由于身份验证已过期而无法执行请求时出现错误代码。
     * 4 : 成功请求需要高级帐户时的错误代码。
     * 5 : 检测到太多并发流时的错误代码。
     * 6 : 由于家长控制而阻止内容时出现错误代码。
     * 7 : 内容因区域不可用而被阻止时的错误代码。
     * 8 : 请求的内容已在播放时出现错误代码。
     * 9 : 当应用程序无法跳过任何更多歌曲时出现错误代码，因为已达到跳过限制。
     * 10: 由于某些外部事件而导致操作中断时的错误代码。
     * 11: 由于队列耗尽而无法播放导航（上一个，下一个）时出现错误代码。
     */
    fun getErrorCode(): Int

    /**
     * 获取当前的播放状态。
     *  Playback.PLAYBACK_STATE_NONE = 100      //什么都没开始
     *  Playback.PLAYBACK_STATE_IDLE = 200      //空闲
     *  Playback.PLAYBACK_STATE_BUFFERING = 300 //正在缓冲
     *  Playback.PLAYBACK_STATE_PLAYING = 400   //正在播放
     *  Playback.PLAYBACK_STATE_PAUSED = 500    //暂停
     *  Playback.PLAYBACK_STATE_STOPPED = 600   //停止
     *  Playback.PLAYBACK_STATE_ERROR = 700     //出错
     */
    fun getState(): Int

    /**
     * 比较方便的判断当前媒体是否在播放
     */
    fun isPlaying(): Boolean

    /**
     * 比较方便的判断当前媒体是否暂停中
     */
    fun isPaused(): Boolean

    /**
     * 比较方便的判断当前媒体是否空闲
     */
    fun isIdea(): Boolean

    /**
     * 判断传入的音乐是不是正在播放的音乐
     */
    fun isCurrMusicIsPlayingMusic(songId: String): Boolean

    /**
     * 判断传入的音乐是否正在播放
     */
    fun isCurrMusicIsPlaying(songId: String): Boolean

    /**
     * 判断传入的音乐是否正在暂停
     */
    fun isCurrMusicIsPaused(songId: String): Boolean

    /**
     * 设置音量
     */
    fun setVolume(audioVolume: Float)

    /**
     * 获取音量
     */
    fun getVolume(): Float

    /**
     * 获取媒体时长，单位毫秒
     */
    fun getDuration(): Long

    /**
     * 获取 AudioSessionId
     */
    fun getAudioSessionId(): Int

    /**
     * 发送自定义事件
     */
    fun sendCommand(command: String, parameters: Bundle)

    /**
     * 扫描本地媒体信息
     */
    fun querySongInfoInLocal(): List<SongInfo>

    /**
     * 添加一个状态监听
     */
    fun addPlayerEventListener(listener: OnPlayerEventListener?)

    /**
     * 删除一个状态监听
     */
    fun removePlayerEventListener(listener: OnPlayerEventListener?)

    /**
     * 删除所有状态监听
     */
    fun clearPlayerEventListener()

    fun getPlayerEventListeners(): MutableList<OnPlayerEventListener>

    fun playbackState(): MutableLiveData<PlaybackStage>
}