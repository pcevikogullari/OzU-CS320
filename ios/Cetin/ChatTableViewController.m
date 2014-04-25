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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
