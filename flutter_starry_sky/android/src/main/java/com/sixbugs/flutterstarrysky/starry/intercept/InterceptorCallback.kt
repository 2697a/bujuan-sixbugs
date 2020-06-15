package com.sixbugs.flutterstarrysky.starry.intercept

import com.sixbugs.flutterstarrysky.starry.provider.SongInfo

interface InterceptorCallback {
    /**
     * 继续进行
     *
     * @param songInfo 音频信息
     */
    fun onContinue(songInfo: SongInfo?)

    /**
     * 中断，中断后会直接回调失败
     *
     * @param exception 异常信息，没有可传null
     */
    fun onInterrupt(exception: Throwable?)
}