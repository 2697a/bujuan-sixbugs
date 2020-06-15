package com.sixbugs.flutterstarrysky.starry.intercept

import com.sixbugs.flutterstarrysky.starry.provider.SongInfo
import com.sixbugs.flutterstarrysky.starry.utils.MainLooper

/**
 * 拦截器
 */
interface StarrySkyInterceptor {

    fun process(songInfo: SongInfo?, mainLooper: MainLooper, callback: InterceptorCallback)
}