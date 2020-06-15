package com.sixbugs.flutterstarrysky.starry.imageloader

import android.content.Context

interface ImageLoaderStrategy {
    fun loadImage(context: Context, url: String?, callBack: ImageLoaderCallBack)
}
