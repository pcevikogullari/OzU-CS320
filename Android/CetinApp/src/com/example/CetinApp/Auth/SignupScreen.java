package com.example.CetinApp.Auth;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
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

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Pamir
 * Date: 6.03.2014
 * Time: 00:24
 * To change this template use File | Settings | File Templates.
 */
public class SignupScreen extends Activity {

    private ProgressBar progressBar;
    private Button submitButton;
    private EditText username;
    private EditText email;
    private EditText password;


    public void onCreate(Bundle savedInstanceState) {
        StrictMode.ThreadPolicy mThreadPolicy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(mThreadPolicy);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.signup_screen);

        username = (EditText)findViewById(R.id.username);
        email = (EditText)findViewById(R.id.email);
        password = (EditText)findViewById(R.id.password);
        submitButton = (Button)findViewById(R.id.submitButton);
        progressBar = (ProgressBar) findViewById(R.id.progressBar);
        progressBar.setVisibility(View.INVISIBLE);


        submitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                InputMethodManager imm = (InputMethodManager)getSystemService(
                        Context.INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(username.getWindowToken(), 0);
                new DownloadWebPageTask().execute();

            }
        });


    }

    private class DownloadWebPageTask extends AsyncTask<String, Integer, String> {


        @Override
        protected void onPreExecute() {

            progressBar.setVisibility(View.VISIBLE);
            super.onPreExecute();
        }

        @Override
        protected void onProgressUpdate(Integer... values) {
            super.onProgressUpdate(values);

        }

        @Override
        protected String doInBackground(String... urls) {
            StringBuffer sb = new StringBuffer("");
            postData(sb);

            return sb.toString();
        }

        @Override
        protected void onPostExecute(String result) {

            if(result.contains("Registered!")){
                Intent intent = new Intent(getApplicationContext(),MyActivity.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                MyPreferences.setNotFirstRun();
                startActivity(intent);
                finish();
            }

            progressBar.setVisibility(View.INVISIBLE);
        }
    }

    public void postData(StringBuffer sb) {
        // Create a new HttpClient and Post Header
        HttpClient httpclient = new DefaultHttpClient();
        HttpPost httppost = new HttpPost("http://www.pamir.me/deneme.php");

        try {
            // Add your data
            List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(4);
            nameValuePairs.add(new BasicNameValuePair("username", username.getEditableText().toString()));
            nameValuePairs.add(new BasicNameValuePair("email", email.getEditableText().toString()));
            nameValuePairs.add(new BasicNameValuePair("password", password.getEditableText().toString()));
            HttpEntity entity = new UrlEncodedFormEntity(nameValuePairs);

            httppost.addHeader(entity.getContentType());
            httppost.setEntity(entity);

            // Execute HTTP Post Request
            HttpResponse response = httpclient.execute(httppost);


            BufferedReader in = new BufferedReader
                    (new InputStreamReader(response.getEntity().getContent()));

            String line = "";

            while ((line = in.readLine()) != null) {
                sb.append(line);
            }
            in.close();


            Log.v("response-->", sb.toString()+"");

        } catch (ClientProtocolException e) {
            // TODO Auto-generated catch block
        } catch (IOException e) {
            // TODO Auto-generated catch block
        }
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