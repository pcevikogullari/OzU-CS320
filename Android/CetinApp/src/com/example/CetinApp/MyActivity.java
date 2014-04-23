package com.example.CetinApp;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;

public class MyActivity extends Activity {

    private ProgressDialog progressDialog;
    ListView listView;
    String[] names;
    String[] ids;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        StrictMode.ThreadPolicy mThreadPolicy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(mThreadPolicy);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        listView = (ListView)findViewById(R.id.listView);

        new loadChatrooms().execute();

    }

    class loadChatrooms extends AsyncTask<String, Integer, String> {


        @Override
        protected String doInBackground(String... params) {

            String convertedText = "";

            try {

                //TODO:Preferences id'si ile değisecek
                URL url = new URL("http://cevikogullari.com/system/call.php?comp=connector&subcomp=sql&sql=[\"SELECT\",\"*\",\"FROM\",\"chatroom\",\"where\",\"user_id\",\"=\",\""+   "1" +"\"]&"+Math.random());
                URLConnection urlConnection = url.openConnection();
                InputStream in = new BufferedInputStream(urlConnection.getInputStream());

                convertedText = convertStreamToString(in).trim();

                //JSONObject jsonObj = new JSONObject(convertedText);
                JSONArray jsonArray = new JSONArray(convertedText);
                names = new String[jsonArray.length()];
                ids = new String[jsonArray.length()];


                for (int i = 0 ; i < jsonArray.length(); i++){

                    JSONObject jsonObject = (JSONObject) jsonArray.get(i);

                    ids[i] = jsonObject.getString("id").trim();
                    names[i] = jsonObject.getString("name").trim();

                }


                Log.v("dataText1-->", convertedText);
                Log.v("idsandmessages-->", ids.length + " - "+ names.length);

            }catch(Exception e){
                Log.e("convertedText",e.toString());
            }
            return convertedText;
        }

        @Override
        protected void onPostExecute(String result) {
            ArrayAdapter<String> adapter = new ArrayAdapter<String>(getApplicationContext(),android.R.layout.simple_list_item_1,names);
            listView.setAdapter(adapter);

            listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                    Intent intent = new Intent(MyActivity.this,ChatScreen.class);
                    intent.putExtra("crid" ,ids[position]);
                    startActivity(intent);

                }
            });

            progressDialog.cancel();

        }

        @Override
        protected void onPreExecute() {
            //users.clear();
            progressDialog = new ProgressDialog(MyActivity.this);
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
    public boolean onCreateOptionsMenu(Menu menu)
    {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if(item.getItemId() == R.id.search){

            Intent intent = new Intent(MyActivity.this,SearchActivity.class);
            startActivity(intent);
        }


        return super.onOptionsItemSelected(item);
    }
}
