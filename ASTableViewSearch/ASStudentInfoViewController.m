//
//  ASDetailsViewController.m
//  ASTableViewSearch
//
//  Created by Alex Sergienko on 09.04.15.
//  Copyright (c) 2015 Alexandr Sergienko. All rights reserved.
//

#import "ASStudentInfoViewController.h"

@interface ASStudentInfoViewController ()

@end

@implementation ASStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.firstNameLabel.text = self.firstName;
    self.lastNameLabel.text  = self.lastName;
    self.studentView.image   = self.image;
    self.bazingaView.text    = self.phrase;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:self.date];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
