package com.ez;

import com.ez.NodeListAsyncTask;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class JSONListActivity extends ListActivity {
    // Called when the activity is first created
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // URL to the eZ Publish REST resource
        // Create a new async task object
        new NodeListAsyncTask(this).execute("http://www.example.com/api/ezp/content/node/2/list");
    }
    
    // Called when async task is done with execution
    public void onNodeListResult(Node[] nodes) {
    	// Populate list with data
    	this.setListAdapter(new ArrayAdapter<Node>(this, android.R.layout.simple_list_item_1, nodes));
    }
    
    // Called when list item is clicked
	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
		super.onListItemClick(l, v, position, id);
		
		// Load detail view with node data
		Intent detailIntent = new Intent(v.getContext(), DetailActivity.class);
		detailIntent.putExtra("Node", (Node)this.getListAdapter().getItem(position));
		startActivityForResult(detailIntent, 0);
	}
}