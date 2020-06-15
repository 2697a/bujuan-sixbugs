package com.sixbugs.flutterstarrysky.starry

import com.sixbugs.flutterstarrysky.starry.common.IMediaConnection
import com.sixbugs.flutterstarrysky.starry.control.PlayerControl
import com.sixbugs.flutterstarrysky.starry.imageloader.ImageLoaderStrategy
import com.sixbugs.flutterstarrysky.starry.intercept.StarrySkyInterceptor
import com.sixbugs.flutterstarrysky.starry.notification.NotificationConfig
import com.sixbugs.flutterstarrysky.starry.notification.StarrySkyNotificationManager
import com.sixbugs.flutterstarrysky.starry.playback.offline.ICache
import com.sixbugs.flutterstarrysky.starry.playback.player.Playback
import com.sixbugs.flutterstarrysky.starry.playback.queue.MediaQueue
import com.sixbugs.flutterstarrysky.starry.playback.queue.MediaQueueManager
import com.sixbugs.flutterstarrysky.starry.provider.IMediaSourceProvider

/**
 * StarrySky 初始化配置类
 */
open class StarrySkyConfig internal constructor(
    builder: Builder
) : Cloneable {

    //媒体信息存储管理类
    @get:JvmName("mediaQueueProvider")
    val mediaQueueProvider: IMediaSourceProvider? = builder.mediaQueueProvider

    //播放队列管理类
    @get:JvmName("mediaQueue")
    val mediaQueue: MediaQueue = builder.mediaQueue

    //通知栏开关
    @get:JvmName("isOpenNotification")
    val isOpenNotification = builder.isOpenNotification

    //缓存开关
    @get:JvmName("isOpenCache")
    val isOpenCache = builder.isOpenCache

    //缓存文件夹
    @get:JvmName("cacheDestFileDir")
    val cacheDestFileDir: String? = builder.cacheDestFileDir

    //超时时间设置
    @get:JvmName("httpConnectTimeout")
    val httpConnectTimeout: Long = builder.httpConnectTimeout

    @get:JvmName("httpReadTimeout")
    val httpReadTimeout: Long = builder.httpReadTimeout

    //是否跳过https
    @get:JvmName("skipSSLChain")
    val skipSSLChain = builder.skipSSLChain

    @get:JvmName("interceptors")
    val interceptors: MutableList<StarrySkyInterceptor> = builder.interceptors

    @get:JvmName("interceptorTimeOut")
    val interceptorTimeOut: Long = builder.interceptorTimeOut

    @get:JvmName("imageLoader")
    val imageLoader: ImageLoaderStrategy? = builder.imageLoader

    @get:JvmName("notificationFactory")
    val notificationFactory: StarrySkyNotificationManager.NotificationFactory? =
        builder.notificationFactory

    @get:JvmName("notificationConfig")
    val notificationConfig: NotificationConfig? = builder.notificationConfig

    @get:JvmName("cacheManager")
    val cache: ICache? = builder.cache

    @get:JvmName("mediaConnection")
    val mediaConnection: IMediaConnection? = builder.mediaConnection

    @get:JvmName("playerControl")
    val playerControl: PlayerControl? = builder.playerControl

    @get:JvmName("playback")
    val playback: Playback? = builder.playback

    constructor() : this(Builder())

    open fun newBuilder(): Builder = Builder(this)

    class Builder constructor() {
        internal var mediaQueueProvider: IMediaSourceProvider? = null
        internal var mediaQueue: MediaQueue = MediaQueueManager()
        internal var isOpenNotification = false
        internal var isOpenCache = false
        internal var cacheDestFileDir: String? = null
        internal var httpConnectTimeout: Long = -1
        internal var httpReadTimeout: Long = -1
        internal var skipSSLChain = false
        internal val interceptors: MutableList<StarrySkyInterceptor> = mutableListOf()
        internal var interceptorTimeOut = 60L   //拦截器超时时间
        internal var imageLoader: ImageLoaderStrategy? = null
        internal var mediaConnection: IMediaConnection? = null
        internal var notificationFactory: StarrySkyNotificationManager.NotificationFactory? = null
        internal var notificationConfig: NotificationConfig? = null
        internal var cache: ICache? = null
        internal var playback: Playback? = null
        internal var playerControl: PlayerControl? = null

        internal constructor(config: StarrySkyConfig) : this() {
            this.mediaQueueProvider = config.mediaQueueProvider
            this.mediaQueue = config.mediaQueue
            this.isOpenNotification = config.isOpenNotification
            this.isOpenCache = config.isOpenCache
            this.cacheDestFileDir = config.cacheDestFileDir
            this.httpConnectTimeout = config.httpConnectTimeout
            this.httpReadTimeout = config.httpReadTimeout
            this.skipSSLChain = config.skipSSLChain
            this.interceptors += config.interceptors
            this.interceptorTimeOut = config.interceptorTimeOut
            this.imageLoader = config.imageLoader
            this.notificationFactory = config.notificationFactory
            this.notificationConfig = config.notificationConfig
            this.cache = config.cache
            this.playback = config.playback
            this.mediaConnection = config.mediaConnection
            this.playerControl = config.playerControl
        }

        fun setMediaQueueProvider(mediaQueueProvider: IMediaSourceProvider) = apply {
            this.mediaQueueProvider = mediaQueueProvider
        }

        fun setMediaQueue(mediaQueue: MediaQueue) = apply {
            this.mediaQueue = mediaQueue
        }

        fun isOpenNotification(isOpenNotification: Boolean) = apply {
            this.isOpenNotification = isOpenNotification
        }

        fun isOpenCache(isOpenCache: Boolean) = apply {
            this.isOpenCache = isOpenCache
        }

        fun setCacheDestFileDir(cacheDestFileDir: String) = apply {
            this.cacheDestFileDir = cacheDestFileDir
        }

        fun setHttpConnectTimeout(httpConnectTimeout: Long) =
            apply { this.httpConnectTimeout = httpConnectTimeout }

        fun setHttpReadTimeout(httpReadTimeout: Long) =
            apply { this.httpReadTimeout = httpReadTimeout }

        fun skipSSLChain(skipSSLChain: Boolean) = apply {
            this.skipSSLChain = skipSSLChain
        }

        fun addInterceptor(interceptor: StarrySkyInterceptor) = apply {
            interceptors += interceptor
        }

        fun setInterceptorTimeOut(interceptorTimeOut: Long) =
            apply { this.interceptorTimeOut = interceptorTimeOut }

        fun setImageLoader(imageLoader: ImageLoaderStrategy) =
            apply { this.imageLoader = imageLoader }

        fun setIMediaConnection(mediaConnection: IMediaConnection) = apply {
            this.mediaConnection = mediaConnection
        }

        fun setNotificationFactory(
            notificationFactory: StarrySkyNotificationManager.NotificationFactory
        ) = apply {
            this.notificationFactory = notificationFactory
        }

        fun setNotificationConfig(notificationConfig: NotificationConfig) = apply {
            this.notificationConfig = notificationConfig
        }

        fun setCache(cache: ICache) = apply {
            this.cache = cache
        }

        fun setPlayback(playback: Playback) = apply {
            this.playback = playback
        }

        fun setPlayerControl(playerControl: PlayerControl) = apply {
            this.playerControl = playerControl
        }

        fun build(): StarrySkyConfig {
            return StarrySkyConfig(this)
        }
    }
}