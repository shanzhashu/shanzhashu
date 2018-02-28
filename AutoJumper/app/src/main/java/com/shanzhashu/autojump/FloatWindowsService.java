package com.shanzhashu.autojump;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.PixelFormat;
import android.hardware.display.DisplayManager;
import android.hardware.display.VirtualDisplay;
import android.media.Image;
import android.media.ImageReader;
import android.media.projection.MediaProjection;
import android.media.projection.MediaProjectionManager;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.support.v4.os.AsyncTaskCompat;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.GestureDetector;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;

import com.shanzhashu.autojump.R;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;

/**
 *
 * 启动悬浮窗界面
 */
@TargetApi(Build.VERSION_CODES.LOLLIPOP)
public class FloatWindowsService extends Service {
  private static final String TAG = "Jump";

  // huawei honor 9
//  private static final int XSTART = 442;
//  private static final int XEND = 488;
//  private static final int YSTART = 1166;
//  private static final int YEND = 1212;

  // samsung note 4
  private static final int XSTART = 426;
  private static final int XEND = 472;
  private static final int YSTART = 1246;
  private static final int YEND = 1292;

  private static final int PATW = 47;
  private static final int PATH = 47;

  public static Intent newIntent(Context context, Intent mResultData) {

    Intent intent = new Intent(context, FloatWindowsService.class);

    if (mResultData != null) {
      intent.putExtras(mResultData);
    }
    return intent;
  }

  private MediaProjection mMediaProjection;
  private VirtualDisplay mVirtualDisplay;

  private static Intent mResultData = null;


  private ImageReader mImageReader;
  private WindowManager mWindowManager;
  private WindowManager.LayoutParams mLayoutParams;
  private GestureDetector mGestureDetector;

  private ImageView mFloatView;

  private int mScreenWidth;
  private int mScreenHeight;
  private int mScreenDensity;


  @Override
  public void onCreate() {
    super.onCreate();

    createFloatView();

    createImageReader();
  }

  public static Intent getResultData() {
    return mResultData;
  }

  public static void setResultData(Intent mResultData) {
    FloatWindowsService.mResultData = mResultData;
  }

  @Override
  public IBinder onBind(Intent intent) {
    return null;
  }

  private void createFloatView() {
    mGestureDetector = new GestureDetector(getApplicationContext(), new FloatGestrueTouchListener());
    mLayoutParams = new WindowManager.LayoutParams();
    mWindowManager = (WindowManager) getSystemService(Context.WINDOW_SERVICE);

    DisplayMetrics metrics = new DisplayMetrics();
    mWindowManager.getDefaultDisplay().getMetrics(metrics);
    mScreenDensity = metrics.densityDpi;
    mScreenWidth = metrics.widthPixels;
    mScreenHeight = metrics.heightPixels;

    mLayoutParams.type = WindowManager.LayoutParams.TYPE_SYSTEM_ALERT;
    mLayoutParams.format = PixelFormat.RGBA_8888;
    // 设置Window flag
    mLayoutParams.flags = WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL
        | WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE;
    mLayoutParams.gravity = Gravity.LEFT | Gravity.TOP;
    mLayoutParams.x = mScreenWidth;
    mLayoutParams.y = 100;
    mLayoutParams.width = WindowManager.LayoutParams.WRAP_CONTENT;
    mLayoutParams.height = WindowManager.LayoutParams.WRAP_CONTENT;


    mFloatView = new ImageView(getApplicationContext());
    mFloatView.setImageBitmap(BitmapFactory.decodeResource(getResources(), R.mipmap.ic_imagetool_crop));
    mWindowManager.addView(mFloatView, mLayoutParams);


    mFloatView.setOnTouchListener(new View.OnTouchListener() {
      @Override
      public boolean onTouch(View v, MotionEvent event) {
        return mGestureDetector.onTouchEvent(event);
      }
    });

  }


  private class FloatGestrueTouchListener implements GestureDetector.OnGestureListener {
    int lastX, lastY;
    int paramX, paramY;

    @Override
    public boolean onDown(MotionEvent event) {
      lastX = (int) event.getRawX();
      lastY = (int) event.getRawY();
      paramX = mLayoutParams.x;
      paramY = mLayoutParams.y;
      return true;
    }

    @Override
    public void onShowPress(MotionEvent e) {

    }

    @Override
    public boolean onSingleTapUp(MotionEvent e) {
      startScreenShot();
      return true;
    }

    @Override
    public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
      int dx = (int) e2.getRawX() - lastX;
      int dy = (int) e2.getRawY() - lastY;
      mLayoutParams.x = paramX + dx;
      mLayoutParams.y = paramY + dy;
      // 更新悬浮窗位置
      mWindowManager.updateViewLayout(mFloatView, mLayoutParams);
      return true;
    }

    @Override
    public void onLongPress(MotionEvent e) {

    }

    @Override
    public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
      return false;
    }
  }


  private void startScreenShot() {

    mFloatView.setVisibility(View.GONE);

    Handler handler1 = new Handler();
    handler1.postDelayed(new Runnable() {
      public void run() {
        //start virtual
        startVirtual();
      }
    }, 5);

    handler1.postDelayed(new Runnable() {
      public void run() {
        //capture the screen
        startCapture();

      }
    }, 30);
  }


  private void createImageReader() {

    mImageReader = ImageReader.newInstance(mScreenWidth, mScreenHeight, PixelFormat.RGBA_8888, 1);

  }

  public void startVirtual() {
    if (mMediaProjection != null) {
      virtualDisplay();
    } else {
      setUpMediaProjection();
      virtualDisplay();
    }
  }

  public void setUpMediaProjection() {
    if (mResultData == null) {
      Intent intent = new Intent(Intent.ACTION_MAIN);
      intent.addCategory(Intent.CATEGORY_LAUNCHER);
      startActivity(intent);
    } else {
      mMediaProjection = getMediaProjectionManager().getMediaProjection(Activity.RESULT_OK, mResultData);
    }
  }

  private MediaProjectionManager getMediaProjectionManager() {

    return (MediaProjectionManager) getSystemService(Context.MEDIA_PROJECTION_SERVICE);
  }

  private void virtualDisplay() {
    mVirtualDisplay = mMediaProjection.createVirtualDisplay("screen-mirror",
        mScreenWidth, mScreenHeight, mScreenDensity, DisplayManager.VIRTUAL_DISPLAY_FLAG_AUTO_MIRROR,
        mImageReader.getSurface(), null, null);
  }

  private void startCapture() {

    Image image = mImageReader.acquireLatestImage();

    if (image == null) {
      startScreenShot();
    } else {
      SaveTask mSaveTask = new SaveTask();
      AsyncTaskCompat.executeParallel(mSaveTask, image);
    }
  }


  public class SaveTask extends AsyncTask<Image, Void, Bitmap> {

    @Override
    protected Bitmap doInBackground(Image... params) {

      if (params == null || params.length < 1 || params[0] == null) {

        return null;
      }

      Image image = params[0];

      int width = image.getWidth();
      int height = image.getHeight();
      final Image.Plane[] planes = image.getPlanes();
      final ByteBuffer buffer = planes[0].getBuffer();
      //每个像素的间距
      int pixelStride = planes[0].getPixelStride();
      //总的间距
      int rowStride = planes[0].getRowStride();
      int rowPadding = rowStride - pixelStride * width;
      Bitmap bitmap = Bitmap.createBitmap(width + rowPadding / pixelStride, height, Bitmap.Config.ARGB_8888);
      bitmap.copyPixelsFromBuffer(buffer);
      bitmap = Bitmap.createBitmap(bitmap, 0, 0, width, height);
      image.close();

//      File fileImage = null;
//      if (bitmap != null) {
//        try {
//          fileImage = new File(FileUtil.getScreenShotsName(getApplicationContext()));
//          if (!fileImage.exists()) {
//            fileImage.createNewFile();
//          }
//          FileOutputStream out = new FileOutputStream(fileImage);
//          if (out != null) {
//            bitmap.compress(Bitmap.CompressFormat.PNG, 100, out);
//            out.flush();
//            out.close();
//            Intent media = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
//            Uri contentUri = Uri.fromFile(fileImage);
//            media.setData(contentUri);
//            sendBroadcast(media);
//          }
//        } catch (FileNotFoundException e) {
//          e.printStackTrace();
//          fileImage = null;
//        } catch (IOException e) {
//          e.printStackTrace();
//          fileImage = null;
//        }
//      }
//
//      if (fileImage != null) {
//        return bitmap;
//      }
      return bitmap;
    }

    private boolean comparePixcelEqual(int p1, int p2)
    {
      final int GAP = 8;
      int r1,g1,b1,r2,g2,b2;
      r1 = (p1 & 0xff0000) >> 16;
      g1 = (p1 & 0x00ff00) >> 8;
      b1 = (p1 & 0x0000ff);

      r2 = (p2 & 0xff0000) >> 16;
      g2 = (p2 & 0x00ff00) >> 8;
      b2 = (p2 & 0x0000ff);

      if (Math.abs(r1 - r2) > GAP)
        return false;
      if (Math.abs(g1 - g2) > GAP)
        return false;
      if (Math.abs(b1 - b2) > GAP)
        return false;

      return true;
    }

    @Override
    protected void onPostExecute(Bitmap bitmap) {
      super.onPostExecute(bitmap);
      //预览图片
      if (bitmap != null) {

        ((AutoJumpApplication) getApplication()).setmScreenCaptureBitmap(bitmap);
        Log.d(TAG, "Screen Capture OK. Width " + bitmap.getWidth() + " Height: " + bitmap.getHeight());

//=============================================================================
//          int[] pixels = new int[bitmap.getWidth() * bitmap.getHeight()];
//          bitmap.getPixels(pixels, 0, bitmap.getWidth(), 0, 0, bitmap.getWidth(), bitmap.getHeight());
//        int x,y, c;
//        StringBuilder sb = new StringBuilder();
//        for (x = XSTART; x <= XEND; x++)
//        {
//          for (y=YSTART; y<=YEND; y++)
//          {
//            c = pixels[y * bitmap.getWidth()+ x];
//            sb.append("Color at x" + x + ",y " + y + " is " + c + ",\n");
//          }
//        }
//        WriteStringToFile("/sdcard/jump.txt", sb.toString());
//        return;
//=============================================================================

          int[] pixels = new int[bitmap.getWidth() * bitmap.getHeight()];
          bitmap.getPixels(pixels, 0, bitmap.getWidth(), 0, 0, bitmap.getWidth(), bitmap.getHeight());

          int xs, ys, ow, oh, w, h, xc = -1, yc = -1;
          ow = bitmap.getWidth();
          oh = bitmap.getHeight();
          w = ow - PATW;
          h = oh -PATH;
          OutterGoing:
          for (xs=0; xs <w;xs++)
          {
              for (ys=100;ys <h - 100; ys++)
              {
//                  if (xs != XSTART || ys != YSTART)
//                      continue ;

                  // from xs,ys to check a square
                  boolean matched = true;
                  int x, y;
                  //Log.d(TAG, "Checking " + xs + ", " + ys);
                  InnerSquareCheck:
                  for (x=xs; x<xs+PATW;x++)
                  {
                      for (y=ys; y<ys+PATH;y++)
                      {
                          int p = (x - xs) * PATH + y - ys;
                          int c = pixels[y * ow + x];
                          if (! comparePixcelEqual(c, BallPattern.BallPixels_SamSungNote4[p]))
                          {
                              //Log.d(TAG, "NOT Equal at " + x + "," + y);
                              matched = false;
                              break InnerSquareCheck;
                          }
                          else;
                              //Log.d(TAG, "Equal at " + x + "," + y + " when checking " + xs + ", " + ys);
                      }
                  }

                  if (matched)
                  {
                      Log.d(TAG, "Matched found at x " + xs + " y " + ys);
                      //Toast.makeText(getApplicationContext(), "Matched found at x " + xs + " y " + ys, Toast.LENGTH_LONG);
                      xc = xs;
                      yc = ys;
                      break OutterGoing;
                  }
              }
          }

          if (xc >= 0 && yc >= 0)
          {
              xc += PATW / 2;
              yc += 200;
              yc += PATH / 2;
              Log.d(TAG, "Jump Pointer center is at " + xc + ", " + yc);

              int line =(int)( 2 * Math.sqrt(Math.abs(xc - ow /2) * Math.abs(xc - ow /2) + Math.abs(yc - oh /2) * Math.abs(yc - oh /2)));
              Log.d(TAG, "We should press for line " + line);

              // ===== NEED SYSTEM/ROOT permission
//              final int tx = xc;
//              final int ty = yc;
//              Thread t = new Thread() {
//                  public void run()
//                  {
//                      Instrumentation mInst = new Instrumentation();
//                      mInst.sendPointerSync(MotionEvent.obtain(SystemClock.uptimeMillis(),
//                              SystemClock.uptimeMillis(), MotionEvent.ACTION_DOWN, tx, ty, 0));
//                      SystemClock.sleep(line * 5);
//                      mInst.sendPointerSync(MotionEvent.obtain(SystemClock.uptimeMillis(),
//                              SystemClock.uptimeMillis(), MotionEvent.ACTION_UP, tx, ty, 0));
//                  }
//              };
//              t.start();

              String s = " " + xc + " " + yc;
              xc++; yc++;
              line = (int)(line * 1.0);
              s = s + " " + xc + " " + yc + " " + line;

              WriteStringToFile("/sdcard/jump.txt", s);
              // Then invoke input swipe `cat /sdcard/jump.txt` at adb shell
              RootCommand("input swipe `cat /sdcard/jump.txt`");
          }


//============================================================================
      }

      mFloatView.setVisibility(View.VISIBLE);
      Handler handler = new Handler();
      handler.postDelayed(new Runnable() {
        public void run() {
          startScreenShot();
        }
      }, 2000);
    }
  }

  private void WriteStringToFile(String filePath, String s) {
    try {
      FileOutputStream fos = new FileOutputStream(filePath);
      fos.write(s.getBytes());
      fos.close();
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  public static boolean RootCommand(String command)
  {
    Process process = null;
    DataOutputStream os = null;

    try
    {
      process = Runtime.getRuntime().exec("su");
      os = new DataOutputStream(process.getOutputStream());
      os.writeBytes(command + "\n");
      os.writeBytes("exit\n");
      os.flush();

      process.waitFor();

    } catch (Exception e)
    {
      Log.d("*** DEBUG ***", "ROOT Fail" + e.getMessage());
      return false;
    } finally
    {
      try
      {
        if (os != null)
        {
          os.close();
        }
        process.destroy();
      } catch (Exception e)
      {
      }
    }
    Log.d("*** DEBUG ***", "Root SUC ");
    return true;

  }

  private void tearDownMediaProjection() {
    if (mMediaProjection != null) {
      mMediaProjection.stop();
      mMediaProjection = null;
    }
  }

  private void stopVirtual() {
    if (mVirtualDisplay == null) {
      return;
    }
    mVirtualDisplay.release();
    mVirtualDisplay = null;
  }

  @Override
  public void onDestroy() {
    // to remove mFloatLayout from windowManager
    super.onDestroy();
    if (mFloatView != null) {
      mWindowManager.removeView(mFloatView);
    }
    stopVirtual();

    tearDownMediaProjection();
  }
}
