//
//  JSONTableViewController.m
//  Reader
//
//  Created by Łukasz Serwatka on 11-05-02.
//  Copyright 2011 eZ Systems. All rights reserved.
//

#import "JSONTableViewController.h"


@implementation JSONTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        nodes = [[NSMutableArray alloc] init];
        
        self.title = @"Reader";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)loadData
{
    [nodes removeAllObjects];
    [[self tableView] reloadData];
    
    // A URL to the eZ Publish REST resource
    NSURL *url = [NSURL URLWithString:@"http://www.example.com/api/ezp/content/node/2/list"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData 
                                         timeoutInterval:30];
    if (connectionInProgress)
    {
        [connectionInProgress cancel];
        [connectionInProgress release];
    }
    
    [jsonData release];
    jsonData = [[NSMutableData alloc] init];
    
    connectionInProgress = [[NSURLConnection alloc] initWithRequest:request 
                                                           delegate:self 
                                                   startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jsonData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Get JSON string from the server response
    NSString *jsonString = [[[NSString alloc] initWithData:jsonData 
                                                  encoding:NSUTF8StringEncoding] autorelease];
    
    // Translate JSON data to Node business objects
    for (NSDictionary *childNode in [[jsonString JSONValue] objectForKey:@"childrenNodes"])
    {
        Node *node = [[Node alloc] init];
        node.id = [[childNode objectForKey:@"nodeId"] intValue];
        node.name = [childNode objectForKey:@"objectName"];
        
        [nodes addObject:node];
        [node release];
    }
    
    // Reload table view to get data
    [[self tableView] reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [nodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Get Node object and display its name
    Node *node = [nodes objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:node.name];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Load detail view with node data
    Node *node = [nodes objectAtIndex:[indexPath row]];

    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNode:node];

    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
