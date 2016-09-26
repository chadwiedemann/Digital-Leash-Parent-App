//
//  StatusViewController.m
//  DigitalLeashParentApp
//
//  Created by Chad Wiedemann on 7/13/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "StatusViewController.h"
#import "ViewController.h"

@interface StatusViewController ()



@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    if(self.inRange ){
        self.view.backgroundColor = UIColorFromRGB(0x129ac7);
        self.runningChild.image = [UIImage imageNamed:@"status-success"];
        self.childStatusLabel.text = @"You're child is fine";
        [self.buttonToReturn setTitle:@"Yes!" forState:normal];
        self.buttonToReturn.backgroundColor = UIColorFromRGB(0xe7753a);
        self.buttonToReturn.layer.cornerRadius = 15;
        self.buttonToReturn.layer.borderWidth = 1;
        
        
    }else{
        self.view.backgroundColor = UIColorFromRGB(0xce293e);
        
        self.runningChild.image = [UIImage imageNamed:@"status-fail"];
        self.childStatusLabel.text = @"Child is not in zone!";
        [self.buttonToReturn setTitle:@"Uh Oh" forState:normal];
        self.buttonToReturn.backgroundColor = [UIColor whiteColor];
        self.buttonToReturn.layer.cornerRadius = 15;
        self.buttonToReturn.layer.borderWidth = 1;

        
    }
}






- (IBAction)buttonToReturn:(UIButton *)sender{
    NSLog(@"button pushed");
    [self dismissViewControllerAnimated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
