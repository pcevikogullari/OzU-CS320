package com.example.CetinApp;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.StrictMode;
import android.support.v4.app.NavUtils;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;


/**
 * Created with IntelliJ IDEA.
 * User: Pamir
 * Date: 11.04.2014
 * Time: 23:24
 * To change this template use File | Settings | File Templates.
 */
public class ChatScreen extends Activity {

    private ProgressDialog progressDialog;
    String[] messages;
    String[] sendUserId;
    String[] chatroomId;

    ListView listview;
    EditText editText;
    Button sendButton;
    String chatroom_id;

    Handler handler;

    public void onCreate(Bundle savedInstanceState) {
        StrictMode.ThreadPolicy mThreadPolicy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(mThreadPolicy);
        super.onCreate(savedInstanceState);

        Bundle bundle = getIntent().getExtras();
        chatroom_id = bundle.getString("crid");

        setContentView(R.layout.chat_screen_activity);
        getActionBar().setDisplayHomeAsUpEnabled(true);

        listview = (ListView)findViewById(R.id.listView);
        editText = (EditText)findViewById(R.id.editText);
        sendButton = (Button) findViewById(R.id.sendButton);

        handler = new Handler();
        handler.post(mRunnable);

        listview.setTranscriptMode(ListView.TRANSCRIPT_MODE_ALWAYS_SCROLL);

        new loadChatrooms(true).execute();

        sendButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new sendMessage().execute();
            }
        });

    }

    private final Runnable mRunnable = new Runnable()
    {
        public void run()

        {
            //Toast.makeText(getApplicationContext(),"in runnable",Toast.LENGTH_SHORT).show();
            new loadChatrooms(false).execute();
            handler.postDelayed(mRunnable, 5000);
        }

    };//runnable

    class loadChatrooms extends AsyncTask<String, Integer, String> {

        boolean flag = false;

        public loadChatrooms(boolean flag){
            this.flag = false;
        }

        @Override
        protected String doInBackground(String... params) {

            String convertedText = "";

            try {

                //TODO:Preferences id'si ile değisecek
                URL url = new URL("http://cevikogullari.com/system/call.php?comp=connector&subcomp=sql&sql=[\"SELECT\",\"*\",\"FROM\",\"user_message\",\"where\",\"chatroom_id\",\"=\",\""+ chatroom_id +"\"]&"+Math.random());
                URLConnection urlConnection = url.openConnection();
                InputStream in = new BufferedInputStream(urlConnection.getInputStream());

                Log.v("urlcheck",url.toString());

                convertedText = convertStreamToString(in).trim();

                //JSONObject jsonObj = new JSONObject(convertedText);
                JSONArray jsonArray = new JSONArray(convertedText);
                messages = new String[jsonArray.length()];
                sendUserId = new String[jsonArray.length()];
                chatroomId = new String[jsonArray.length()];

                for (int i = 0 ; i < jsonArray.length(); i++){

                    JSONObject jsonObject = (JSONObject) jsonArray.get(i);


                    messages[i] = jsonObject.getString("message");
                    sendUserId[i] = jsonObject.getString("send_usr_id");
                    chatroomId[i] = jsonObject.getString("chatroom_id");

                    Log.v("usersOfApp:", sendUserId[i]) ;
                }


                Log.v("dataText1-->", convertedText);


            }catch(Exception e){
                Log.e("convertedText",e.toString());
            }
            return convertedText;
        }

        @Override
        protected void onPostExecute(String result) {
            ChatScreenAdapter adapter = new ChatScreenAdapter(getApplicationContext(),messages,sendUserId);
            listview.setAdapter(adapter);
            listview.setTranscriptMode(ListView.TRANSCRIPT_MODE_ALWAYS_SCROLL);
            listview.setStackFromBottom(true);

            if(flag != false){
                progressDialog.cancel();
            }
        }

        @Override
        protected void onPreExecute() {
            if(flag != false){
                progressDialog = new ProgressDialog(ChatScreen.this);
                progressDialog.setMessage("Loading...");
                progressDialog.setCancelable(false);
                progressDialog.show();
            }
        }

        @Override
        protected void onProgressUpdate(Integer... values) {


        }
    }


    class sendMessage extends AsyncTask<String, Integer, String> {
        @Override
        protected String doInBackground(String... params) {

            String convertedText = "";

            try {

                //TODO:Preferences id'si ile değisecek
                URL url = new URL("http://cevikogullari.com/system/call.php?comp=sender&subcomp=sendmsg&crid="+chatroom_id+"&msg="+editText.getText().toString()+"&uid="+MyPreferences.getValue("userId","")+"&"+Math.random());
                URLConnection urlConnection = url.openConnection();
                InputStream in = new BufferedInputStream(urlConnection.getInputStream());

                Log.v("urlcheck",url.toString());

                convertedText = convertStreamToString(in).trim();


                Log.v("dataText1-->", convertedText);


            }catch(Exception e){
                Log.e("convertedText",e.toString());
            }
            return convertedText;
        }

        @Override
        protected void onPostExecute(String result) {
            progressDialog.cancel();
            editText.getText().clear();
            new loadChatrooms(true).execute();


        }

        @Override
        protected void onPreExecute() {
            progressDialog = new ProgressDialog(ChatScreen.this);
            progressDialog.setMessage("Sending...");
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