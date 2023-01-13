package com.euda.euda_app;

import com.ryanheise.audioservice.AudioServiceActivity;
import android.content.Context;
import androidx.multidex.MultiDex;

public class MainActivity extends AudioServiceActivity {
    @Override
      public void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}

