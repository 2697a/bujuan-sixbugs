package com.sixbugs.flutterstarrysky.starry
import android.annotation.SuppressLint
import android.app.PendingIntent
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import android.os.*
import android.support.v4.media.MediaBrowserCompat
import android.support.v4.media.MediaMetadataCompat
import android.support.v4.media.session.MediaControllerCompat
import android.support.v4.media.session.MediaSessionCompat
import android.support.v4.media.session.PlaybackStateCompat
import androidx.media.MediaBrowserServiceCompat
import com.sixbugs.flutterstarrysky.starry.StarrySky.Companion.get
import com.sixbugs.flutterstarrysky.starry.notification.INotification
import com.sixbugs.flutterstarrysky.starry.playback.manager.IPlaybackManager
import com.sixbugs.flutterstarrysky.starry.playback.manager.IPlaybackManager.PlaybackServiceCallback
import com.sixbugs.flutterstarrysky.starry.playback.player.Playback
import com.sixbugs.flutterstarrysky.starry.provider.IMediaSourceProvider
import com.sixbugs.flutterstarrysky.starry.provider.SongInfo
import java.lang.ref.WeakReference


class MusicService : MediaBrowserServiceCompat(), IMediaSourceProvider.MetadataUpdateListener, PlaybackServiceCallback {

    companion object {
        const val STOP_DELAY = 30000
        private const val STARRYSKY_BROWSABLE_ROOT = "/"
    }

    private var mediaSession: MediaSessionCompat? = null
    private var mediaController: MediaControllerCompat? = null
    private var transportControls: MediaControllerCompat.TransportControls? = null
    private var mWakeLock: PowerManager.WakeLock?=null;
    var mPlaybackManager: IPlaybackManager? = null
    private var notification: INotification? = null
    private var mBecomingNoisyReceiver: BecomingNoisyReceiver? = null

    private val mDelayedStopHandler = DelayedStopHandler(this)

    @SuppressLint("InvalidWakeLockTag")
    override fun onCreate() {
        super.onCreate()
        initWakeLock()
        mPlaybackManager = get().playbackManager()
        mPlaybackManager?.setServiceCallback(this)
        mPlaybackManager?.setMetadataUpdateListener(this)
        //会话连接
        mediaSession = MediaSessionCompat(this, "com.sixbugs.flutterstarrysky.starry.MusicService")
        sessionToken = mediaSession?.sessionToken
        try {
            //这里可能会报 ：
            //java.lang.NullPointerException: Attempt to invoke virtual method 'boolean android.content.Intent
            // .migrateExtraStreamToClipData()' on a null object reference
            val sessionIntent = packageManager.getLaunchIntentForPackage(packageName)
            val sessionActivityPendingIntent = PendingIntent.getActivity(this, 0, sessionIntent, 0)
            mediaSession?.setSessionActivity(sessionActivityPendingIntent)
        } catch (ex: Exception) {
            ex.printStackTrace()
        }
        mediaSession?.setCallback(mPlaybackManager?.mediaSessionCallback)
        mediaSession?.setFlags(
            MediaSessionCompat.FLAG_HANDLES_MEDIA_BUTTONS or MediaSessionCompat.FLAG_HANDLES_TRANSPORT_CONTROLS)
        mediaSession?.setExtras(Bundle())
        try {
            mediaController = MediaControllerCompat(this, mediaSession!!.sessionToken)
        } catch (e: RemoteException) {
            e.printStackTrace()
        }
        transportControls = mediaController?.transportControls
        mBecomingNoisyReceiver = BecomingNoisyReceiver(this, transportControls)

        //通知栏相关
        val manager = get().notificationManager()
        notification = manager.getNotification(this)
        mPlaybackManager?.registerNotification(notification)

    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent != null) {
            //you can do something
        }
        mDelayedStopHandler.removeCallbacksAndMessages(null)
        mDelayedStopHandler.sendEmptyMessageDelayed(0, STOP_DELAY.toLong())
        return Service.START_STICKY
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        super.onTaskRemoved(rootIntent)
        stopSelf()
    }

    override fun onDestroy() {
        super.onDestroy()
        releaseWakeLock()
        mPlaybackManager?.handleStopRequest(null)
        notification?.stopNotification()
        mDelayedStopHandler.removeCallbacksAndMessages(null)
        mBecomingNoisyReceiver?.unregister()
        mediaSession?.release()
    }


    //开启唤醒锁
    @SuppressLint("InvalidWakeLockTag")
    private fun initWakeLock() {
        if (null == mWakeLock) {
            val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
            mWakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK or
                    PowerManager.ON_AFTER_RELEASE,
                    "mainLockService")
            if (null != mWakeLock) {
                mWakeLock!!.acquire()
            }
        }
    }

    //关闭唤醒锁
    private fun releaseWakeLock() {
        if (null != mWakeLock) {
            mWakeLock!!.release()
            mWakeLock = null
        }
    }

    override fun onLoadChildren(
        parentId: String, result: Result<MutableList<MediaBrowserCompat.MediaItem>>
    ) {
        //可以不做任何事情
    }

    override fun onGetRoot(
        clientPackageName: String, clientUid: Int, rootHints: Bundle?
    ): BrowserRoot? {
        return BrowserRoot(STARRYSKY_BROWSABLE_ROOT, null)
    }

    /**
     * 媒体信息更新时回调
     */
    override fun onMetadataChanged(metadata: MediaMetadataCompat) {
        mediaSession?.setMetadata(metadata)
    }

    /**
     * 当前播放媒体为 null 时回调
     */
    override fun onMetadataRetrieveError(songInfo: SongInfo?) {
        mPlaybackManager?.updatePlaybackState(songInfo, isOnlyUpdateActions = false, isError = true,
            error = "Unable to retrieve metadata")
    }

    /**
     * 播放队列更新时回调
     */
    override fun onQueueUpdated(newQueue: List<MediaSessionCompat.QueueItem>) {
        mediaSession?.setQueue(newQueue)
    }

    /**
     * 播放时回调
     */
    override fun onPlaybackStart() {
        mediaSession?.isActive = true
        mDelayedStopHandler.removeCallbacksAndMessages(null)
    }

    /**
     * 暂停或停止时回调
     */
    override fun onPlaybackStop(isStop: Boolean) {
        if (isStop) {
            mediaSession?.isActive = false
        }
        mDelayedStopHandler.removeCallbacksAndMessages(null)
        mDelayedStopHandler.sendEmptyMessageDelayed(0, STOP_DELAY.toLong())
        stopForeground(true)
    }

    /**
     * 播放状态改变时回调
     */
    override fun onPlaybackStateUpdated(
        newState: PlaybackStateCompat?, currMetadata: MediaMetadataCompat?
    ) {
        mediaSession?.setPlaybackState(newState)
        if (newState?.state == Playback.STATE_BUFFERING ||
            newState?.state == Playback.STATE_PLAYING) {
            mBecomingNoisyReceiver?.register()
        } else {
            mBecomingNoisyReceiver?.unregister()
        }
    }
}

/**
 * 拔下耳机时暂停，具体意思可参考 AudioManager.ACTION_AUDIO_BECOMING_NOISY
 */
private class BecomingNoisyReceiver(
    private val context: Context,
    private val transportControls: MediaControllerCompat.TransportControls?
) : BroadcastReceiver() {
    private val noisyIntentFilter: IntentFilter =
        IntentFilter(AudioManager.ACTION_AUDIO_BECOMING_NOISY)
    private var registered = false

    fun register() {
        if (!registered) {
            context.registerReceiver(this, noisyIntentFilter)
            registered = true
        }
    }

    fun unregister() {
        if (registered) {
            context.unregisterReceiver(this)
            registered = false
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (AudioManager.ACTION_AUDIO_BECOMING_NOISY == intent.action) {
            transportControls?.pause()
        }
    }
}

private class DelayedStopHandler(service: MusicService) : Handler() {
    private val mWeakReference: WeakReference<MusicService> = WeakReference(service)
    override fun handleMessage(msg: Message) {
        val service = mWeakReference.get()
        if (service != null) {
            if (service.mPlaybackManager?.isPlaying == true) {
                return
            }
            service.stopSelf()
        }
    }
}