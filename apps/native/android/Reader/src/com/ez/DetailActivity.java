package com.ez;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;

public class DetailActivity extends Activity {
    // Called when the activity is first created
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.detail);
        
        // Get node object passed from list view
        Node node = (Node)getIntent().getExtras().get("Node");
        
        // URL to the eZ Publish REST resource, created dynamically with node ID
        // Create a new async task object
        new NodeAsyncTask(this).execute(String.format("http://www.example.com/api/ezp/content/node/%d?OutputFormat=xhtml", node.getId()));
    }
    
    // Called when async task is done with execution
    public void onNodeResult(String result) {
    	// Load content inside WebView
    	WebView webview = (WebView) findViewById(R.id.webview);
    	webview.loadData(result, "text/html", "utf-8");
    }
}
