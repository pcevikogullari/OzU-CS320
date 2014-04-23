package com.example.CetinApp;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;

/**
 * Created with IntelliJ IDEA.
 * User: Pamir
 * Date: 23.04.2014
 * Time: 01:26
 * To change this template use File | Settings | File Templates.
 */
public class ChatScreenAdapter extends BaseAdapter{


    private String[] messages;
    private String[] sendUserId;
    private Context context;
    private int width;
    private int height;
    private  LayoutInflater inFlater;

    public ChatScreenAdapter(Context context, String[] messages, String[] sendUserId) {
        this.context = context;
        this.messages = messages;
        this.sendUserId = sendUserId;
        this.inFlater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

    }

    public int getCount() {
        return messages.length;
    }

    public Object getItem(int position) {
        return null;
    }

    public long getItemId(int position) {
        return 0;
    }

    static class ViewHolder {
        public TextView message;

    }

    public View getView(final int position, View convertView, ViewGroup parent) {

        if(sendUserId[position].trim().equals(MyPreferences.getValue("userId",""))){
            convertView = inFlater.inflate(R.layout.chat_screen_adapter_sag, parent, false);
        }else{
            convertView = inFlater.inflate(R.layout.chat_screen_adapter_sol, parent, false);
        }

        TextView message = (TextView) convertView.findViewById(R.id.textView);

        message.setEllipsize(TextUtils.TruncateAt.END);

        message.setText(messages[position]);

        return convertView;
    }

}