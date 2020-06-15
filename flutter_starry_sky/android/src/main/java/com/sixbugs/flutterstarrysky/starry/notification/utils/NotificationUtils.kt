package com.sixbugs.flutterstarrysky.starry.notification.utils

import android.annotation.SuppressLint
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.annotation.RequiresApi
import com.sixbugs.flutterstarrysky.starry.R
import com.sixbugs.flutterstarrysky.starry.StarrySky
import com.sixbugs.flutterstarrysky.starry.notification.INotification
import com.sixbugs.flutterstarrysky.starry.notification.NotificationConfig

/**
 * 通知栏工具类，主要提供一些公共的方法
 */
object NotificationUtils {
    /**
     * 得到目标界面 Class
     */
    fun getTargetClass(targetClass: String): Class<*>? {
        var clazz: Class<*>? = null
        try {
            if (targetClass.isNotEmpty()) {
                clazz = Class.forName(targetClass)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return clazz
    }

    /**
     * 设置content点击事件
     */
    fun createContentIntent(
        context: Context, mBuilder: NotificationConfig?,
        songId: String?, bundle: Bundle?, targetClass: Class<*>
    ): PendingIntent {
        //构建 Intent
        val songInfo = StarrySky.get().mediaQueueProvider().songList
            .filter { it.songId == songId }.elementAtOrNull(0)
        val openUI = Intent(context, targetClass)
        openUI.flags = Intent.FLAG_ACTIVITY_SINGLE_TOP
        openUI.putExtra("notification_entry", INotification.ACTION_INTENT_CLICK)
        songInfo?.let {
            openUI.putExtra("songInfo", it)
        }
        bundle?.let {
            openUI.putExtra("bundleInfo", it)
        }
        //构建 PendingIntent
        @SuppressLint("WrongConstant")
        val pendingIntent: PendingIntent
        val requestCode = INotification.REQUEST_CODE
        val flags = PendingIntent.FLAG_CANCEL_CURRENT
        pendingIntent = when (mBuilder?.pendingIntentMode) {
            NotificationConfig.MODE_ACTIVITY -> {
                PendingIntent.getActivity(context, requestCode, openUI, flags)
            }
            NotificationConfig.MODE_BROADCAST -> {
                PendingIntent.getBroadcast(context, requestCode, openUI, flags)
            }
            NotificationConfig.MODE_SERVICE -> {
                PendingIntent.getService(context, requestCode, openUI, flags)
            }
            else -> PendingIntent.getActivity(context, requestCode, openUI, flags)
        }
        return pendingIntent
    }

    /**
     * 兼容8.0
     */
    @RequiresApi(Build.VERSION_CODES.O)
    fun createNotificationChannel(
        context: Context,
        manager: NotificationManager
    ) {
        if (manager.getNotificationChannel(INotification.CHANNEL_ID) == null) {
            val notificationChannel = NotificationChannel(INotification.CHANNEL_ID,
                context.getString(R.string.notification_channel),
                NotificationManager.IMPORTANCE_LOW)
            notificationChannel.description =
                context.getString(R.string.notification_channel_description)
            manager.createNotificationChannel(notificationChannel)
        }
    }
}
