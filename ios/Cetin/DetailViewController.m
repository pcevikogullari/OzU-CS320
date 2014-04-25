//
//  DetailViewController.m
//  Cetin
//
//  Created by Turushan Aktay on 25/04/14.
//  Copyright (c) 2014 Turushan Aktay. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize chatLog, dict, index,message, crid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *log = [[NSString alloc] initWithFormat:@"%@", [dict valueForKey:@"message"]];
    [chatLog setText:log];
    NSLog(@"%d", index.row+1);
    // Do any additional setup after loading the view.
}
- (IBAction)sendMessage:(id)sender {
    NSString *msgToSend = message.text;
    crid = [[NSString alloc] initWithFormat:@"%d", index.row + 1 ];
    
    //http://cevikogullari.com/system/call.php?comp=sender&subcomp=sendmsg&crid=2&msg=sondeneme&uid=4
    NSString *msgURL = [[NSString alloc] initWithFormat:@"http://cevikogullari.com/system/call.php?comp=sender&subcomp=sendmsg&crid=%@&msg=%@&uid=5", crid, msgToSend];
    
    NSString *returnMSG = [self stringWithUrl:[NSURL URLWithString:msgURL]];
    NSLog(returnMSG);
    NSLog(@"%@", crid);
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
