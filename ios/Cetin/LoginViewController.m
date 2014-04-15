//
//  LoginViewController.m
//  Cetin
//
//  Created by Turushan Aktay on 15/04/14.
//  Copyright (c) 2014 Turushan Aktay. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginButton, username, password, passwordLabel, usernameLabel, viewChats;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)pushLogin:(id)sender {
    NSString *user = [[NSString alloc] initWithFormat:@"%@", username.text];
    NSString *pw = [[NSString alloc] initWithFormat:@"%@", password.text];
    
    NSString *login1st = [[NSString alloc] initWithFormat:@"http://cevikogullari.com/system/call.php?comp=auth&subcomp=usrform&email=%@&pass=%@&%d", user, pw, arc4random() % 50];

    NSString *returnedID = [self stringWithUrl:[NSURL URLWithString:login1st]];

    NSLog(returnedID);
    
    //NSString *returnedIDtrimmed = [returnedID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *login2nd = [[NSString alloc] initWithFormat:@"http:cevikogullari.com/system/call.php/?comp=auth&subcomp=sesstart&usrid=%@&%d", returnedID , arc4random() % 30];
    
    NSString *returnedID2 = [self stringWithUrl:[NSURL URLWithString:login2nd]];
    
    NSLog(returnedID);
    NSLog(returnedID2);

    if ([returnedID isEqualToString:returnedID2]) {
        [loginButton setHidden:YES];
        [username setHidden:YES];
        [password setHidden:YES];
        [usernameLabel setHidden:YES];
        [passwordLabel setHidden:YES];
        [viewChats setHidden:NO];
        [viewChats setTitle:[[NSString alloc] initWithFormat:@"Hoşgeldin, %@", user] forState:UIControlStateNormal];
        
    }
    
    }
    //NSLog(NSString *format, ...)
    
    //NSString *pamirlink = [[NSString alloc] initWithFormat:@"http://cevikogullari.com/system/call.php?comp=auth&subcomp=usrform&email=turushan.aktay@ozu.edu.tr&pass=123456&&%d" , arc4random() % 30];
    //int returnedID = 5;
    
    //NSString *pamirlink = [[NSString alloc] initWithFormat:@"http:cevikogullari.com/system/call.php/?comp=auth&subcomp=sesstart&usrid=%d&%d", returnedID , arc4random() % 30];



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
