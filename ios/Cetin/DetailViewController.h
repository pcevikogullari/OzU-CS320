//
//  DetailViewController.h
//  Cetin
//
//  Created by Turushan Aktay on 25/04/14.
//  Copyright (c) 2014 Turushan Aktay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *chatLog;
@property (nonatomic, strong) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) NSString *crid;
@end
