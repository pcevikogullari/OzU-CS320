package com.example.CetinApp;

import android.app.Activity;
import android.os.Bundle;
import android.os.StrictMode;
import android.support.v4.app.NavUtils;
import android.view.MenuItem;

/**
 * Created with IntelliJ IDEA.
 * User: Pamir
 * Date: 11.04.2014
 * Time: 23:24
 * To change this template use File | Settings | File Templates.
 */
public class ChatScreen extends Activity {
    public void onCreate(Bundle savedInstanceState) {
        StrictMode.ThreadPolicy mThreadPolicy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(mThreadPolicy);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.chat_screen_activity);
        getActionBar().setDisplayHomeAsUpEnabled(true);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            // Respond to the action bar's Up/Home button
            case android.R.id.home:
                NavUtils.navigateUpFromSameTask(this);
                return true;
        }
        return super.onOptionsItemSelected(item);
    }
}