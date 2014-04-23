package com.example.CetinApp;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
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
 * Time: 22:13
 * To change this template use File | Settings | File Templates.
 */
public class SearchActivity extends Activity {

    private ProgressDialog progressDialog;
    ListView listView;
    EditText editText;
    Button searchButton;
    String[] array;

    public void onCreate(Bundle savedInstanceState) {
        StrictMode.ThreadPolicy mThreadPolicy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(mThreadPolicy);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.search_activity);
        getActionBar().setDisplayHomeAsUpEnabled(true);

        listView = (ListView)findViewById(R.id.listView);
        editText = (EditText)findViewById(R.id.searchText);
        searchButton = (Button)findViewById(R.id.searchButton);

        searchButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
               new showUser().execute();
            }
        });

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent = new Intent(SearchActivity.this,ChatScreen.class);
                startActivity(intent);

            }
        });
    }


    class showUser extends AsyncTask<String, Integer, String> {


        @Override
        protected String doInBackground(String... params) {

            String convertedText = "";

            try {
                URL url = new URL("http://cevikogullari.com/system/call.php?comp=connector&subcomp=sql&sql=[\"SELECT\",\"*\",\"FROM\",\"user\",\"where\",\"mail\",\"=\",\"'"+  editText.getText().toString() +"'\"]&"+Math.random());
                URLConnection urlConnection = url.openConnection();
                InputStream in = new BufferedInputStream(urlConnection.getInputStream());

                convertedText = convertStreamToString(in).trim();
                Log.v("urlbaglantisi",url.toString());
                //JSONObject jsonObj = new JSONObject(convertedText);
                JSONArray jsonArray = new JSONArray(convertedText);
                array = new String[jsonArray.length()];

                for (int i = 0 ; i < jsonArray.length(); i++){

                    JSONObject jsonObject = (JSONObject) jsonArray.get(i);


                    array[i] = jsonObject.getString("mail");

                    //Log.v("usersOfApp:", jsonObject.get("id") + "") ;
                }


                Log.v("dataText1-->", convertedText);


            }catch(Exception e){
                Log.e("convertedText",e.toString());
            }
            return convertedText;
        }

        @Override
        protected void onPostExecute(String result) {
            ArrayAdapter<String> adapter = new ArrayAdapter<String>(getApplicationContext(),android.R.layout.simple_list_item_1,array);
            listView.setAdapter(adapter);



            progressDialog.cancel();

        }

        @Override
        protected void onPreExecute() {
            //users.clear();
            progressDialog = new ProgressDialog(SearchActivity.this);
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