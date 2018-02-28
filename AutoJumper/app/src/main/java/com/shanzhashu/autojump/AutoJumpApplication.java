package com.shanzhashu.autojump;

import android.app.Application;
import android.graphics.Bitmap;

/**
 * Created by me on 2018-02-28.
 */
public class AutoJumpApplication extends Application {


  private Bitmap mScreenCaptureBitmap;

  @Override
  public void onCreate() {
    super.onCreate();
  }


  public Bitmap getmScreenCaptureBitmap() {
    return mScreenCaptureBitmap;
  }

  public void setmScreenCaptureBitmap(Bitmap mScreenCaptureBitmap) {
    this.mScreenCaptureBitmap = mScreenCaptureBitmap;
  }
}
