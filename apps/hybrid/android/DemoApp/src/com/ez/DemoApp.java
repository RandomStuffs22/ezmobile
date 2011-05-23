package com.ez;

import android.app.Activity;
import android.os.Bundle;
import android.view.KeyEvent;
import android.webkit.WebView;

public class DemoApp extends Activity {
	WebView webview;

    // Called when the activity is first created
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        // Get WebView instance and load content from eZ Publish mobile web interface
        // Change URL to the eZ Publish mobile web interface
        webview = (WebView) findViewById(R.id.webview);
        webview.setWebViewClient(new DemoAppWebViewClient());
        webview.getSettings().setJavaScriptEnabled(true);
        webview.loadUrl("www.example.com");
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
    	// Go back when user press back button on keypad
        if ((keyCode == KeyEvent.KEYCODE_BACK) && webview.canGoBack()) {
            webview.goBack();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
}