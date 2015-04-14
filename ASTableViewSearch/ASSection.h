//
//  ASSection.h
//  ASTableViewSearch
//
//  Created by Alex Sergienko on 01.03.15.
//  Copyright (c) 2015 Alexandr Sergienko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSection : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *itemsArray;

@end
