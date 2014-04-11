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
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
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

    private ProgressBar progressBar;
    private Button submitButton;
    private EditText username;
    private EditText email;
    private EditText password;

    public void onCreate(Bundle savedInstanceState) {
        StrictMode.ThreadPolicy mThreadPolicy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(mThreadPolicy);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_screen);

        username = (EditText)findViewById(R.id.username);
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
                new login(username.getText().toString(),password.getText().toString()).execute();
            }
        });


    }

    private class login extends AsyncTask<String, Integer, String> {

        private String username;
        private String password;
        private int position;
        private Activity activity;


        private login(String username,String password){
            this.username =username;
            this.password = password;

        }

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
            String convertedText = "";

            HttpClient httpclient = new DefaultHttpClient();
            HttpPost httppost = new HttpPost("http://www.pamir.me/login.php");

            try {
                // Add your data
                List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(4);
                nameValuePairs.add(new BasicNameValuePair("username", username ));
                nameValuePairs.add(new BasicNameValuePair("password", password ));
                HttpEntity entity = new UrlEncodedFormEntity(nameValuePairs);

                httppost.addHeader(entity.getContentType());
                httppost.setEntity(entity);

                // Execute HTTP Post Request
                HttpResponse response = httpclient.execute(httppost);

                convertedText = convertStreamToString(response.getEntity().getContent());

                JSONObject jsonObj = new JSONObject(convertedText);
                JSONArray jsonArray = jsonObj.getJSONArray("results");

                for (int i = 0 ; i < jsonArray.length(); i++){

                    JSONObject jsonObject = (JSONObject) jsonArray.get(i);
                    convertedText = jsonObject.getString("id");
                }



            } catch (Exception e) {

            }


            return convertedText;
        }

        @Override
        protected void onPostExecute(String result) {

            if(result.contains("error") == false){
                Log.v("convertedText", result);

                Intent intent = new Intent(getApplicationContext(),MyActivity.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                MyPreferences.setNotFirstRun();
                //MyPreferences.setUserId(result);
                startActivity(intent);
                finish();
            }
            progressBar.setVisibility(View.INVISIBLE);
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