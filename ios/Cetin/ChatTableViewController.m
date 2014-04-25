//
//  ChatTableViewController.m
//  Cetin
//
//  Created by Turushan Aktay on 25/04/14.
//  Copyright (c) 2014 Turushan Aktay. All rights reserved.
//

#import "ChatTableViewController.h"
#import "LoginViewController.h"
#import "ChatTableViewCell.h"
#import "DetailViewController.h"

@interface ChatTableViewController ()

@end

@implementation ChatTableViewController
@synthesize dict, chatNames, index;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarttonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatNames.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"chatCell";
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    /*NSDictionary *aktion = self.chatNames[indexPath.row];
    __block NSString *gg = @"";
    [aktion enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (gg.length) {
            gg = [gg stringByAppendingString:@", "];
        }
        gg = [NSString stringWithFormat:@"%@%@ = %@", gg, key, obj];
    }];*/


    //NSString *tt = [[NSString alloc] initWithFormat:@"%@", [self.chatNames indexPath.row] objectForKey:@"name"]];
    //NSString *tt = [[NSString alloc] initWithFormat:@"%@", [self.chatNames indexOfObject:indexPath]];
    int x = indexPath.row;
    NSString *tt = [[NSString alloc] initWithFormat:@"%@", [self.chatNames objectAtIndex:x]];
    cell.chatName.text = [[NSString alloc] initWithFormat:@"%@", tt];
    
    return cell;
}


- (NSString *)stringWithUrl:(NSURL *)url

{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    
    // Fetch the JSON response
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    
    
    // Construct a String around the Data from the response
    
    return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    if ([segue.identifier isEqualToString:@"detpush"]) {
         NSString *log;
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         NSLog(@"asdad");
         ChatTableViewController *controller = segue.destinationViewController;
         NSLog(@"hello");
         NSLog(@"%d", indexPath.row);
         if(indexPath.row == 0) {
             log = [[NSString alloc] initWithFormat:@"http://bit.ly/1puZ5a3"];
         } else if (indexPath.row == 1) {
             log = [[NSString alloc] initWithFormat:@"http://bit.ly/QJE7EE"];
         } else if (indexPath.row == 2) {
             log = [[NSString alloc] initWithFormat:@"http://bit.ly/1nt3453"];
         } else if (indexPath.row == 3) {
         log = [[NSString alloc] initWithFormat:@"http://bit.ly/1tIw1eK"];
         }
        
        // NSLog(@"hello mf");

         NSString *returnedLog = [self stringWithUrl:[NSURL URLWithString:log]];
         NSData *jsonData = [returnedLog dataUsingEncoding:NSUTF8StringEncoding];
         NSError *e;
         dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
        
         NSLog([dict description]);
         controller.dict = self.dict;
        index = indexPath;
        controller.index = self.index;
        //NSLog([self.tableView indexPathForSelectedRow]);
        //controller.chatLog = self.chatLog;
        
    }
    
}

@end

