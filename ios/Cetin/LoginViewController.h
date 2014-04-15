//
//  LoginViewController.h
//  Cetin
//
//  Created by Turushan Aktay on 15/04/14.
//  Copyright (c) 2014 Turushan Aktay. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *viewChats;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@end
