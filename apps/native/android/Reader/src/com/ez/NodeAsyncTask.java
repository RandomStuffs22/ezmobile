package com.ez;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;

public class NodeAsyncTask extends AsyncTask<String, Void, String> {
	private ProgressDialog progressDialog;
	private Context context;

	// Constructor, takes context as an argument
    public NodeAsyncTask(Context context) {
        this.context = context;
    }
	
	@Override
	protected void onPreExecute() {
		super.onPreExecute();

		// Display progress dialog while downloading data
		this.progressDialog = ProgressDialog.show(this.context, "Please wait ...",
				"Acquiring data", true);
	}
	
	@Override
	protected String doInBackground(String... requestURL) {
		
        String renderedOutput = null;
        String requestString = requestURL[0];
		
        try {
            // Connect to the eZ Publish REST resource
    		DefaultHttpClient httpClient = new DefaultHttpClient();
    		HttpGet request = new HttpGet(requestString);
    		HttpResponse response = httpClient.execute(request);
    		
    		// Get JSON result
            String result = EntityUtils.toString(response.getEntity());
            JSONObject root = new JSONObject(result);
            
            // Get XHTML string from renderedOuput key
            renderedOutput = root.getString("renderedOutput");
        } catch(Exception e) {
        	e.printStackTrace();
        }

		return renderedOutput;
	}

	@Override
	protected void onPostExecute(String result) {
		super.onPostExecute(result);

		// Dismiss progress dialog
		this.progressDialog.dismiss();

		// Pass result to the activity
		((DetailActivity)this.context).onNodeResult(result);
	}
}
