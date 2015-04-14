//
//  ASDetailsViewController.h
//  ASTableViewSearch
//
//  Created by Alex Sergienko on 09.04.15.
//  Copyright (c) 2015 Alexandr Sergienko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASStudentInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *studentView;
@property (weak, nonatomic) IBOutlet UITextView  *bazingaView;
@property (weak, nonatomic) IBOutlet UILabel     *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *dateLabel;

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phrase;
@property (strong, nonatomic) NSDate   *date;
@property (strong, nonatomic) UIImage  *image;

@end
