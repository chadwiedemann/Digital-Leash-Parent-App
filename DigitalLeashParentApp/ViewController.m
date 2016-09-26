//
//  ViewController.m
//  DigitalLeashParentApp
//
//  Created by Chad Wiedemann on 7/11/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()



@end



@implementation ViewController

NSString *url = @"https://turntotech.firebaseio.com/digitalleash/%@.json";

//Lazy instantiation for nsmutable request
-(NSMutableURLRequest *)request//creates a setter method
{
    if(!_request){//instiates a class is it does not exist
        _request = [[NSMutableURLRequest alloc]init];
    }
    return _request;
}
//lazy instantiation for UILabel
-(UILabel *)digitalLeashLabel
{
    if(!_digitalLeashLabel)
    {
        _digitalLeashLabel = [[UILabel alloc]init];
    }
    return _digitalLeashLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //adjusting the look of the create user button
    self.createButton.backgroundColor = UIColorFromRGB(0x5ed29a);//using method in header to create proper color with hexidecimal value
    self.createButton.layer.cornerRadius = 8;//this rounds the corner on the button
    self.createButton.layer.borderWidth = 1;//adds a boarder to the button equal to the borders set color
    
    //creating the label for the app

    self.digitalLeashLabel.frame = CGRectMake(20, 20, 300, 100);//creates the title in a label property for the app
    [self.view addSubview:self.digitalLeashLabel];//attaches the title of the app to the initial view
    self.digitalLeashLabel.text = @"Digital Leash";//adds text to the title of the app
    

    
    self.updateButton.backgroundColor = UIColorFromRGB(0x5ed29a); // uses the color method in the header to accept hexidecimal value
    self.updateButton.layer.cornerRadius = 8;//rounds the corner on the button
    self.updateButton.layer.borderWidth = 1;//adds a border to the button
    
    
    
    self.statusButton.backgroundColor = UIColorFromRGB(0x5ed29a);//uses the color method in the header to accept hexidecimal value then sets value
    self.statusButton.layer.cornerRadius = 8;//rounds the corner of the button
    self.statusButton.layer.borderWidth = 1;//adds boarder to the button
    
    
    
    
    self.view.backgroundColor = UIColorFromRGB(0x129ac7);//sets the color using a method and the hexidecimal value of the color
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.statusVC = (StatusViewController *)[sb instantiateViewControllerWithIdentifier:@"SVC"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
}

//create user
- (IBAction)createUserButton:(id)sender//the button that was created from the contection from storyboard
{
    
    //this section checks to make sure the inputs are numbers
    NSNumberFormatter *text1 = [[NSNumberFormatter alloc]init];//created to use the method numberFromString to determine if text is a number or not see line 86-88
    NSNumberFormatter *text2 = [[NSNumberFormatter alloc]init];//same as line83
    NSNumberFormatter *text3 = [[NSNumberFormatter alloc]init];//same as line 83
    bool isDecimalLong = [text1 numberFromString:self.longitudeTextField.text];//returns nil if the user doesn't put a number which is then stored as false if the number in the text field
    bool isDecimalLat = [text2 numberFromString:self.latitudeTextField.text];//returns nil if the user doesn't put a number
    bool isDecimalRadius = [text3 numberFromString:self.radiusTextField.text];//returns nil if the user doesn't put a number
    if(!isDecimalLong)//check to see if the user inputed a number if not then this section is implemented
    {
        self.notANumberView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 425, 110)];//creates a new view to alert user of error
        [self.view addSubview:self.notANumberView];//adds the new subview to the main view to alert user
        self.notANumberView.backgroundColor = UIColorFromRGB(0xf38282);//sets the color in hexidecimal format 
        
        UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(50,50,100,100)];//creates a label to inform the user of error
        label.text = @"Error: Zone Lonitude must be a numerical value";//adds the text to the label from line 95
        [self.notANumberView addSubview:label];//adds the label to the subview from line 91
        
        self.digitalLeashLabel = [[UILabel alloc]initWithFrame: CGRectMake(20,20,300,100)];//creates a label to label the app this is the same label that is used in view did load section
        [self.view addSubview:self.digitalLeashLabel];//adds the label to the subview
        self.digitalLeashLabel.text = @"Digital Leash";//adds text to label

    }else if (!isDecimalLat)//this section is used to perform the same conditional test to the  latituded text field
    {
        self.notANumberView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 425, 110)];
        [self.view addSubview:self.notANumberView];
        self.notANumberView.backgroundColor = UIColorFromRGB(0xf38282);
        
        
        UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(50,50,100,100)];
        label.text = @"Error: Zone Longitude must be a numerical value";
        [self.notANumberView addSubview:label];
    
        self.digitalLeashLabel = [[UILabel alloc]initWithFrame: CGRectMake(20,20,300,100)];
        [self.view addSubview:self.digitalLeashLabel];
        self.digitalLeashLabel.text = @"Digital Leash";

    
    }else if (!isDecimalRadius)//this section is used to perform the same conditional test to the radius text field
    {
        self.notANumberView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 425, 110)];
        [self.view addSubview:self.notANumberView];
        self.notANumberView.backgroundColor = UIColorFromRGB(0xf38282);
        
        
        UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(50,50,100,100)];
        label.text = @"Error: Radius must be a numerical value";
        [self.notANumberView addSubview:label];
        
        
        self.digitalLeashLabel = [[UILabel alloc]initWithFrame: CGRectMake(20,20,300,100)];
        [self.view addSubview:self.digitalLeashLabel];
        self.digitalLeashLabel.text = @"Digital Leash";
        
        
    }
    else{//this section removes the subview created if all three textfields properly have numbers
        [self.notANumberView removeFromSuperview];//removes the warning subview from the view if contitions are corretly met
    }

    
    //this sections creates a new username and digital leash zone for that user
    NSDictionary *userDetails = @{@"username" : self.userNameTextField.text,@"latitude" : self.latitudeTextField.text, @"longitude" : self.longitudeTextField.text, @"radius" : self.radiusTextField.text, };//creates a dictionary with the informtion from the text fields
    NSError* error;//creates and error object
    self.createUserJSONData = [NSJSONSerialization dataWithJSONObject:userDetails options:NSJSONWritingPrettyPrinted error:&error];//converts the dictionary with user data to JSON data ready to upload to the server
    
    
    self.request.URL = [NSURL URLWithString:[NSString stringWithFormat: url,self.userNameTextField.text]];//encapsulates the url into NSMutavleURLrequest that the program will access
    self.request.HTTPMethod = @"PUT";//acction the server will take when it recieves the data sent to it from the NSURLSessionDataTask
    self.request.HTTPBody = self.createUserJSONData;//the acctual data accepted by the server
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {//the object and methos that sends the information to the server
        if(error){
            NSLog(@"%@",error.localizedDescription);//logs the error if the session fails to inform the programmer
        }
    }];
    [dataTask resume];
}

//update user button
- (IBAction)updateUserButton:(id)sender
{
    //This section makes sure the user is inputting a number into the update user button fields
    NSNumberFormatter *text1 = [[NSNumberFormatter alloc]init];
    NSNumberFormatter *text2 = [[NSNumberFormatter alloc]init];
    NSNumberFormatter *text3 = [[NSNumberFormatter alloc]init];
    bool isDecimalLong = [text1 numberFromString:self.longitudeTextField.text];
    bool isDecimalLat = [text2 numberFromString:self.latitudeTextField.text];
    bool isDecimalRadius = [text3 numberFromString:self.radiusTextField.text];
    if(!isDecimalLong)
    {
        NSLog(@"This is not a number");
        self.notANumberView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 425, 110)];
        [self.view addSubview:self.notANumberView];
        self.notANumberView.backgroundColor = UIColorFromRGB(0xf38282);
        
        
        UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(50,50,100,100)];
        label.text = @"Error: Zone Lonitude";
        [self.notANumberView addSubview:label];
        self.digitalLeashLabel = [[UILabel alloc]initWithFrame: CGRectMake(20,20,300,100)];
        [self.view addSubview:self.digitalLeashLabel];
        self.digitalLeashLabel.text = @"Digital Leash";

        
        
    }else if (!isDecimalLat)
    {
        self.notANumberView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 425, 110)];
        [self.view addSubview:self.notANumberView];
        self.notANumberView.backgroundColor = UIColorFromRGB(0xf38282);
        
        
        UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(50,50,100,100)];
        label.text = @"Error: Zone Longitude must be a numerical value";
        [self.notANumberView addSubview:label];
        self.digitalLeashLabel = [[UILabel alloc]initWithFrame: CGRectMake(20,20,300,100)];
        [self.view addSubview:self.digitalLeashLabel];
        self.digitalLeashLabel.text = @"Digital Leash";

        
    }else if (!isDecimalRadius)
    {
        self.notANumberView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 425, 110)];
        [self.view addSubview:self.notANumberView];
        self.notANumberView.backgroundColor = UIColorFromRGB(0xf38282);
        
        
        UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(50,50,100,100)];
        label.text = @"Error: Radius must be a numerical value";
        [self.notANumberView addSubview:label];
        
        self.digitalLeashLabel = [[UILabel alloc]initWithFrame: CGRectMake(20,20,300,100)];
        [self.view addSubview:self.digitalLeashLabel];
        self.digitalLeashLabel.text = @"Digital Leash";

        
    }
    else{
        [self.notANumberView removeFromSuperview];
    }
    //this section takes the inputs from the text fields and sends a PATCH request to the server
    NSDictionary *userDetails = @{@"username" : self.userNameTextField.text,@"latitude" : self.latitudeTextField.text, @"longitude" : self.longitudeTextField.text, @"radius" : self.radiusTextField.text};//creates the dictionary as just like create user button
    NSError* error;
    self.createUserJSONData = [NSJSONSerialization dataWithJSONObject:userDetails options:NSJSONWritingPrettyPrinted error:&error];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://turntotech.firebaseio.com/digitalleash/%@.json",self.userNameTextField.text]];
    
    self.request.URL = url;//encapsulates information needed for the NSURLSessionDataTask, sets the url that the session will comunicate with
    self.request.HTTPMethod = @"PATCH";//insturcts the server what action to perform with the JSON data
    self.request.HTTPBody = self.createUserJSONData;//the data the server will integrate
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            // use UIAlertController to show if there is internet or other issue
            
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    [dataTask resume];
}


//request status button
- (IBAction)requestStatusButton:(id)sender
{
    NSLog(@"button pushed");
    
    
    NSURL *URLLocationOfChildData = [NSURL URLWithString:[NSString stringWithFormat:@"https://turntotech.firebaseio.com/digitalleash/%@.json",self.userNameTextField.text]];//turns a string into a url the user name is accepted from the text field to fill the url
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URLLocationOfChildData];//creates and populates the URL request with the URL used
    NSURLSessionDataTask *requestData = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {//creates the data session to find information needed to determine child's status
        
        if(error){
            NSLog(@"%@", error.localizedDescription);
        }else{
            NSString *putInString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];//puts the JSON data into a string
            self.JSONData = [putInString dataUsingEncoding:NSUTF8StringEncoding];//puts the string into and ns data object
            NSError* error2;
            self.childLocationDict = [NSJSONSerialization JSONObjectWithData: self.JSONData options:NSJSONReadingMutableContainers error:&error2]; //creates a dicionary with the JSON data
            
            
            // its safe to check error2  - which tells you json serialize was successful
            
            //the next section takes the data from the dictionary using the appropriate keys and and compares it to the location data submitted by the parent
            
            // check if current_latitude is null - which means child has not yet reported
            
            double childLat=[self.childLocationDict[@"current_latitude"] doubleValue];
            double childLong=[self.childLocationDict[@"current_longitude"] doubleValue];
            double parentLatitude = [self.childLocationDict[@"latitude"] doubleValue];
            double parentLongitude = [self.childLocationDict[@"longitude"] doubleValue];
            double parentRadius = [self.childLocationDict[@"radius"] doubleValue];
            CLLocation *childLoc= [[CLLocation alloc] initWithLatitude:childLat longitude:childLong];//creates a cllocation with the data provided for child
            CLLocation *parentsLoc= [[CLLocation alloc] initWithLatitude: parentLatitude longitude:parentLongitude];//creates a cllocation with the data that the parents want
            CLLocationDistance distance = [childLoc distanceFromLocation:parentsLoc];//this method determines the distance between to GPS locations
            self.childInRange = distance < parentRadius;//compares the assigned radius to
            
            dispatch_async(dispatch_get_main_queue(), ^{//this takes us back to the main queue to be able to move us to the next view controller
                self.statusVC.inRange = self.childInRange;//this sets the property inRange in the StatusViewController to the bool from line 269
                [self presentViewController:self.statusVC animated:YES completion:nil];
            });
            
            
            
        }
        NSLog(@"%@",self.childLocationDict);
        NSLog(@"test");
    }];
    [requestData resume];
    
    NSLog(@"requestStatusButton complete");
}

@end
