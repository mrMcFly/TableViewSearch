//
//  ASStudent.h
//  ASTableViewSearch
//
//  Created by Alex Sergienko on 28.02.15.
//  Copyright (c) 2015 Alexandr Sergienko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ASStudent : NSObject

@property (strong, nonatomic) NSString     *firstName;
@property (strong, nonatomic) NSString     *lastName;
@property (strong, nonatomic) NSDate       *birthDate;
@property (strong, nonatomic) NSString     *studentPhrase;
@property (strong, nonatomic)   UIImage      *stdImage;



+ (ASStudent*) createNewStudent;

@end
