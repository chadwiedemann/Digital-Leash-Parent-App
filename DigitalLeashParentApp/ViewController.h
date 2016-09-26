//
//  ViewController.h
//  DigitalLeashParentApp
//
//  Created by Chad Wiedemann on 7/11/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]//allows the programmer to use the hexidecimal value of the color to set colors on different things

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;

@property (nonatomic, strong) NSData *createUserJSONData;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;

@property (nonatomic, strong) NSData *JSONData;
@property (nonatomic, strong) NSDictionary *childLocationDict;
@property BOOL childInRange;

@property (nonatomic, strong) StatusViewController *statusVC;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) UIView *notANumberView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (nonatomic, strong) UILabel *digitalLeashLabel;





@end

