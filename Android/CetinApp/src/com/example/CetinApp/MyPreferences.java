package com.example.CetinApp;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

/**
 * Created with IntelliJ IDEA.
 * User: Pamir
 * Date: 11.03.2014
 * Time: 12:13
 * To change this template use File | Settings | File Templates.
 */
public class MyPreferences {

    public static final String PREFERENCES_FILE = "MusicPlayerPref";


    public static Context context;


    public MyPreferences(Context context){
        this.context = context;
    }

    public Context getContext(){
        return context;
    }

    public static int getValue ( String preference, int defaultValue )
    {
        SharedPreferences preferences = context.getSharedPreferences( PREFERENCES_FILE, Context.MODE_PRIVATE );
        return preferences.getInt( preference, defaultValue );
    }

    public static String getValue ( String preference, String defaultValue )
    {
        SharedPreferences preferences = context.getSharedPreferences( PREFERENCES_FILE, Context.MODE_PRIVATE );
        return preferences.getString( preference, defaultValue );
    }


    public static boolean getValue ( String preference, boolean defaultValue )
    {
        SharedPreferences preferences = context.getSharedPreferences( PREFERENCES_FILE, Context.MODE_PRIVATE );
        return preferences.getBoolean( preference, defaultValue );
    }


    public static boolean isFirstRun ()
    {
        SharedPreferences preferences = context.getSharedPreferences( PREFERENCES_FILE, Context.MODE_PRIVATE );
        return preferences.getBoolean( "firstTime", true );
    }

    public static void setNotFirstRun ()
    {
        SharedPreferences preferences = context.getSharedPreferences( PREFERENCES_FILE, Context.MODE_PRIVATE );
        SharedPreferences.Editor editor = preferences.edit();
        editor.putBoolean( "firstTime", false );
        editor.commit();
    }

    public static void resetLoginPreferences ()
    {
        SharedPreferences preferences = context.getSharedPreferences( PREFERENCES_FILE, Context.MODE_PRIVATE );
        SharedPreferences.Editor editor = preferences.edit();
        editor.putBoolean( "firstTime", true );
        editor.commit();
    }



    /*
    *
    *
    *
    *
     */
    private void getSavedPreferences() {

        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
        boolean checkBoxValue = sharedPreferences.getBoolean("hasLoggedIn", false);
        String name = sharedPreferences.getString("storedName", "YourName");

    }

    private void savePreferences(String key, boolean value) {

        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putBoolean(key, value);
        editor.commit();

    }

    private void savePreferences(String key, String value) {

        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(key, value);
        editor.commit();

    }


}
