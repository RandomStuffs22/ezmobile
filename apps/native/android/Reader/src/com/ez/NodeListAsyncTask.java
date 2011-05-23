package com.ez;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;

public class NodeListAsyncTask extends AsyncTask<String, Void, Node[]> {
	private ProgressDialog progressDialog;
	private Context context;

	// Constructor, takes context as an argument
    public NodeListAsyncTask(Context context) {
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
	protected Node[] doInBackground(String... requestURL) {
		
        Node[] nodes = null;
        String requestString = requestURL[0];
		
        try {
        	// Connect to the eZ Publish REST resource
    		DefaultHttpClient httpClient = new DefaultHttpClient();
    		HttpGet request = new HttpGet(requestString);
    		HttpResponse response = httpClient.execute(request);

    		// Get JSON result
            String result = EntityUtils.toString(response.getEntity());
            JSONObject root = new JSONObject(result);
            JSONArray childrenNodes = root.getJSONArray("childrenNodes");
 
            nodes = new Node[childrenNodes.length()];
            
            // Translate JSON result into the Node business objects
			for (int i = 0; i < childrenNodes.length(); i++) {
				JSONObject childNode = childrenNodes.getJSONObject(i);
				
				Node node = new Node();
				node.setId(childNode.getInt("nodeId"));
				node.setName(childNode.getString("objectName"));
				nodes[i] = node;
			}
    		
        } catch(Exception e) {
        	e.printStackTrace();
        }

		return nodes;
	}

	@Override
	protected void onPostExecute(Node[] result) {
		super.onPostExecute(result);

		// Dismiss progress dialog
		this.progressDialog.dismiss();

		// Pass result to the activity
		((JSONListActivity)this.context).onNodeListResult(result);
	}
	
}
