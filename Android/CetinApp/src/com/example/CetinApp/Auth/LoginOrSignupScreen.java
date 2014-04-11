package com.example.CetinApp.Auth;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import com.example.CetinApp.MyActivity;
import com.example.CetinApp.MyPreferences;
import com.example.CetinApp.R;


/**
 * Created with IntelliJ IDEA.
 * User: Pamir
 * Date: 5.03.2014
 * Time: 20:49
 * To change this template use File | Settings | File Templates.
 */
public class LoginOrSignupScreen extends Activity {


    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_or_signup_screen);

        Button signupButton = (Button)findViewById(R.id.signupButton);
        Button loginButton = (Button)findViewById(R.id.loginButton);


        MyPreferences.context = getApplicationContext();

        if(MyPreferences.isFirstRun()){

            signupButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(LoginOrSignupScreen.this,SignupScreen.class);
                    startActivity(intent);
                    finish();
                }
            });

            loginButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(LoginOrSignupScreen.this,LoginScreen.class);
                    startActivity(intent);
                    finish();

                }
            });

        } else{
            Intent intent = new Intent(LoginOrSignupScreen.this, MyActivity.class);
            startActivity(intent);
            finish();
        }
    }

    public void onResume(){

        super.onResume();
    }

    @Override
    public void onBackPressed()
    {
        super.onBackPressed();

        // optional depending on your needs
    }


}