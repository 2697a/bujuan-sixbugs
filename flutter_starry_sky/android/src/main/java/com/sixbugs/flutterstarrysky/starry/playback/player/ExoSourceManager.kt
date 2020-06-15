package com.sixbugs.flutterstarrysky.starry.playback.player

import android.annotation.SuppressLint
import android.content.Context
import android.net.Uri
import com.google.android.exoplayer2.C
import com.google.android.exoplayer2.extractor.DefaultExtractorsFactory
import com.google.android.exoplayer2.source.ExtractorMediaSource
import com.google.android.exoplayer2.source.MediaSource
import com.google.android.exoplayer2.source.ads.AdsMediaSource
import com.google.android.exoplayer2.upstream.DataSource
import com.google.android.exoplayer2.upstream.DefaultBandwidthMeter
import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory
import com.google.android.exoplayer2.upstream.DefaultHttpDataSourceFactory
import com.google.android.exoplayer2.upstream.cache.CacheDataSource
import com.google.android.exoplayer2.upstream.cache.CacheDataSourceFactory
import com.google.android.exoplayer2.util.Util
import com.sixbugs.flutterstarrysky.starry.StarrySky
import com.sixbugs.flutterstarrysky.starry.playback.offline.ExoCache
import com.sixbugs.flutterstarrysky.starry.playback.offline.ICache
import com.sixbugs.flutterstarrysky.starry.utils.StarrySkyUtils

class ExoSourceManager constructor(private val context: Context) {

    private var dataSource: String = ""
    private var sHttpConnectTimeout = -1L
    private var sHttpReadTimeout = -1L
    private var sSkipSSLChain = false
    private var mMapHeadData: Map<String, String>? = hashMapOf()
    private var playbackCache: ICache? = null
    private var isCached = false

    companion object {
        const val TYPE_RTMP = 4
        const val TYPE_FLAC = 5
        const val DEFAULT_MAX_SIZE = 512 * 1024 * 1024
        const val dashClassName = "com.google.android.exoplayer2.source.dash.DashMediaSource"
        const val ssClassName = "com.google.android.exoplayer2.source.smoothstreaming.SsMediaSource"
        const val hlsClassName = "com.google.android.exoplayer2.source.hls.HlsMediaSource"
        const val rtmpClassName = "com.google.android.exoplayer2.ext.rtmp.RtmpDataSourceFactory"
        const val MSG_DASH_ERROR = "类 DashMediaSource 不存在，请导入 exoplayer:exoplayer-dash 包"
        const val MSG_SS_ERROR = "类 SsMediaSource 不存在，请导入 exoplayer:exoplayer-smoothstreaming 包"
        const val MSG_HLS_ERROR = "类 HlsMediaSource 不存在，请导入 exoplayer:exoplayer-hls 包"
        const val MSG_RTMP_ERROR = "类 RtmpDataSourceFactory 不存在，请导入 exoplayer:extension-rtmp 包"
    }

    init {
        sHttpConnectTimeout = StarrySky.get().config().httpConnectTimeout
        sHttpReadTimeout = StarrySky.get().config().httpReadTimeout
        sSkipSSLChain = StarrySky.get().config().skipSSLChain
    }

    @SuppressLint("DefaultLocale")
    fun buildMediaSource(
        dataSource: String,
        overrideExtension: String?,
        mapHeadData: Map<String, String>?,
        playbackCache: ICache
    ): MediaSource {
        this.dataSource = dataSource
        this.mMapHeadData = mapHeadData
        this.playbackCache = playbackCache

        val contentUri = Uri.parse(dataSource)
        val contentType: Int = inferContentType(dataSource, overrideExtension)

        when (contentType) {
            C.TYPE_DASH -> {
                checkClassExist(dashClassName, MSG_DASH_ERROR)
                val dataSourceFactory = getDataSourceFactoryCache(false)
                val factory: AdsMediaSource.MediaSourceFactory =
                    newClassInstance(dashClassName, dataSourceFactory)
                return factory.createMediaSource(contentUri)
            }
            C.TYPE_SS -> {
                checkClassExist(ssClassName, MSG_SS_ERROR)
                val dataSourceFactory = getDataSourceFactoryCache(false)
                val factory: AdsMediaSource.MediaSourceFactory =
                    newClassInstance(ssClassName, dataSourceFactory)
                return factory.createMediaSource(contentUri)
            }
            C.TYPE_HLS -> {
                checkClassExist(hlsClassName, MSG_HLS_ERROR)
                val dataSourceFactory = getDataSourceFactoryCache(false)
                val factory: AdsMediaSource.MediaSourceFactory =
                    newClassInstance(hlsClassName, dataSourceFactory)
                return factory.createMediaSource(contentUri)
            }
            C.TYPE_OTHER -> {
                val dataSourceFactory = getDataSourceFactoryCache(playbackCache.isOpenCache())
                return ExtractorMediaSource.Factory(dataSourceFactory)
                    .setExtractorsFactory(DefaultExtractorsFactory())
                    .createMediaSource(contentUri)
            }
            TYPE_RTMP -> {
                checkClassExist(rtmpClassName, MSG_RTMP_ERROR)
                val clazz = Class.forName(rtmpClassName)
                val factory: DataSource.Factory = clazz.newInstance() as DataSource.Factory
                return ExtractorMediaSource.Factory(factory).createMediaSource(contentUri)
            }
            TYPE_FLAC -> {
                val dataSourceFactory = getDataSourceFactoryCache(false)
                val extractorsFactory = DefaultExtractorsFactory()
                return ExtractorMediaSource(contentUri, dataSourceFactory, extractorsFactory, null,
                    null)
            }
            else -> {
                throw IllegalStateException("Unsupported type: $contentType")
            }
        }
    }

    @SuppressLint("WrongConstant", "DefaultLocale")
    @C.ContentType
    private fun inferContentType(dataSource: String, overrideExtension: String?): Int {
        val isRtmpSource = dataSource.toLowerCase().startsWith("rtmp://")
        val isFlacSource = dataSource.toLowerCase().endsWith(".flac")
        return when {
            isRtmpSource -> {
                TYPE_RTMP
            }
            isFlacSource -> {
                TYPE_FLAC
            }
            else -> {
                inferContentType(Uri.parse(dataSource), overrideExtension)
            }
        }
    }

    @C.ContentType
    private fun inferContentType(uri: Uri?, overrideExtension: String?): Int {
        return Util.inferContentType(uri, overrideExtension)
    }

    private fun getDataSourceFactoryCache(isOpenCache: Boolean): DataSource.Factory {
        return if (isOpenCache) {
            isCached = playbackCache?.isCache(dataSource) ?: false
            if (playbackCache is ExoCache) {
                val cache = playbackCache as ExoCache
                CacheDataSourceFactory(cache.getDownloadCache(), getDataSourceFactory(),
                    CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR)
            } else {
                getDataSourceFactory()
            }
        } else {
            getDataSourceFactory()
        }
    }

    private fun getDataSourceFactory(): DataSource.Factory {
        return DefaultDataSourceFactory(context, buildHttpDataSourceFactory())
    }

    private fun buildHttpDataSourceFactory(): DataSource.Factory? {
        var connectTimeout = 8000L
        var readTimeout = 8000L
        if (sHttpConnectTimeout > 0) {
            connectTimeout = sHttpConnectTimeout
        }
        if (sHttpReadTimeout > 0) {
            readTimeout = sHttpReadTimeout
        }
        var allowCrossProtocolRedirects = false
        if (!mMapHeadData.isNullOrEmpty() && mMapHeadData!!.isNotEmpty()) {
            allowCrossProtocolRedirects = "true" == mMapHeadData!!["allowCrossProtocolRedirects"]
        }
        val userAgent =
            StarrySkyUtils.getUserAgent(context, context.applicationInfo?.name ?: "StarrySky")
        if (sSkipSSLChain) {
            val dataSourceFactory =
                SkipSSLHttpDataSourceFactory(
                    userAgent,
                    DefaultBandwidthMeter.Builder(context).build(),
                    connectTimeout,
                    readTimeout,
                    allowCrossProtocolRedirects)
            if (!mMapHeadData.isNullOrEmpty() && mMapHeadData!!.isNotEmpty()) {
                for ((key, value) in mMapHeadData!!.entries) {
                    dataSourceFactory.defaultRequestProperties.set(key, value)
                }
            }
            return dataSourceFactory
        }
        val dataSourceFactory = DefaultHttpDataSourceFactory(
            userAgent,
            DefaultBandwidthMeter.Builder(context).build(),
            connectTimeout.toInt(),
            readTimeout.toInt(),
            allowCrossProtocolRedirects)
        if (!mMapHeadData.isNullOrEmpty() && mMapHeadData!!.isNotEmpty()) {
            for ((key, value) in mMapHeadData!!.entries) {
                dataSourceFactory.defaultRequestProperties[key] = value
            }
        }
        return dataSourceFactory
    }

    private fun checkClassExist(className: String, errorStr: String) {
        try {
            javaClass.classLoader?.loadClass(className)
        } catch (ex: ClassNotFoundException) {
            throw IllegalArgumentException(errorStr)
        }
    }

    private fun newClassInstance(className: String, dataSourceFactory: DataSource.Factory): AdsMediaSource.MediaSourceFactory {
        val clazz = Class.forName(className)
        val innerClazz = clazz.declaredClasses
        for (cls in innerClazz) {
            if (cls.name == clazz.name + "\$Factory") {
                val constructors = cls.getConstructor(DataSource.Factory::class.java)
                constructors.isAccessible = true
                return constructors.newInstance(dataSourceFactory) as AdsMediaSource.MediaSourceFactory
            }
        }
        throw IllegalArgumentException("获取 " + clazz.name + "\$Factory 实例失败")
    }
}