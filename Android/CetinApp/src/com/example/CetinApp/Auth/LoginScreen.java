package com.example.CetinApp.Auth;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import com.example.CetinApp.MyActivity;
import com.example.CetinApp.MyPreferences;
import com.example.CetinApp.R;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Pamir
 * Date: 7.03.2014
 * Time: 23:28
 * To change this template use File | Settings | File Templates.
 */
public class LoginScreen extends Activity {

    private ProgressDialog progressDialog;
    private Button submitButton;
    private EditText email;
    private EditText password;

    public void onCreate(Bundle savedInstanceState) {
        StrictMode.ThreadPolicy mThreadPolicy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(mThreadPolicy);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_screen);

        email = (EditText)findViewById(R.id.email);
        password = (EditText)findViewById(R.id.password);
        submitButton = (Button)findViewById(R.id.submitButton);

        submitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                InputMethodManager imm = (InputMethodManager)getSystemService(
                        Context.INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(email.getWindowToken(), 0);
                new login(email.getText().toString(),password.getText().toString()).execute();
            }
        });


    }


    class login extends AsyncTask<String, Integer, String> {

        String email;
        String password;

        public login(String email,String password){
            this.email = email;
            this.password = password;
        }

        @Override
        protected String doInBackground(String... params) {

            String convertedText = "";
            String convertedText2 = "";
            String convertedText3 = "";
            try {
                URL url = new URL("http://cevikogullari.com/system/call.php?comp=auth&subcomp=usrform&email="+email+"&pass="+password+"&"+Math.random());
                URLConnection urlConnection = url.openConnection();
                InputStream in = new BufferedInputStream(urlConnection.getInputStream());

                convertedText = convertStreamToString(in).trim();
                Log.v("dataText1-->",convertedText.trim().equals("4")+"");

                if(convertedText != "0"){
                    URL url2 = new URL("http://cevikogullari.com/system/call.php/?comp=auth&subcomp=sesstart&usrid="+convertedText+"&"+Math.random());
                    URLConnection urlConnection2 = url2.openConnection();
                    InputStream in2 = new BufferedInputStream(urlConnection2.getInputStream());

                    convertedText2 = convertStreamToString(in2).trim();

                    Log.v("dataText2-->",convertedText+" - "+convertedText2);
                    in2.close();
                }
                /*
                if(convertedText2 != "0"){
                    URL url3 = new URL("http://cevikogullari.com/system/call.php/?comp=auth&subcomp=sesreq");
                    URLConnection urlConnection3 = url3.openConnection();
                    InputStream in3 = new BufferedInputStream(urlConnection3.getInputStream());

                    convertedText3 = convertStreamToString(in3).trim();

                    Log.v("dataText2-->",convertedText+" - "+convertedText2 + " - "+convertedText3);
                    in3.close();
                } */


            }catch(Exception e){
                Log.e("convertedText",e.toString());
            }
            return convertedText;
        }

        @Override
        protected void onPostExecute(String result) {

            Intent intent = new Intent(getApplicationContext(),MyActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            MyPreferences.setNotFirstRun();
            MyPreferences.setUserId(result);
            startActivity(intent);
            finish();

            progressDialog.cancel();

        }

        @Override
        protected void onPreExecute() {
            //users.clear();
            progressDialog = new ProgressDialog(LoginScreen.this);
            progressDialog.setMessage("Loading...");
            progressDialog.setCancelable(false);
            progressDialog.show();

        }

        @Override
        protected void onProgressUpdate(Integer... values) {


        }
    }




    public String convertStreamToString(InputStream is) {
        /*
         * To convert the InputStream to String we use the BufferedReader.readLine()
         * method. We iterate until the BufferedReader return null which means
         * there's no more data to read. Each line will appended to a StringBuilder
         * and returned as String.
         */
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();

        String line = null;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }


    @Override
    public boolean onTouchEvent(MotionEvent event) {
        InputMethodManager imm = (InputMethodManager)getSystemService(Context.
                INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(getCurrentFocus().getWindowToken(), 0);
        return true;
    }

    @Override
    public void onBackPressed()
    {
        Intent intent = new Intent(getApplicationContext(),LoginOrSignupScreen.class);
        startActivity(intent);
        finish();
        super.onBackPressed();

        // optional depending on your needs
    }
}