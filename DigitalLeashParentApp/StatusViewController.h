//
//  StatusViewController.h
//  DigitalLeashParentApp
//
//  Created by Chad Wiedemann on 7/13/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]


@interface StatusViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *childStatusLogo;
@property (weak, nonatomic) IBOutlet UILabel *childStatusLabel;
@property BOOL inRange;
@property (nonatomic, strong) UIImageView *outOfRangeImage;
@property (nonatomic, strong) UIImageView *inRangeImage;
@property (weak, nonatomic) IBOutlet UIImageView *runningChild;
- (IBAction)buttonToReturn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonToReturn;
@property (nonatomic, strong) UIView* rectangleOutOfRangeButton;
@property (nonatomic, strong) UIView* rectangleInRangeButton;



@end
