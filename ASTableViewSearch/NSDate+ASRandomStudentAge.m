//
//  NSDate+ASRandomStudentAge.m
//  ASTableViewSearch
//
//  Created by Alex Sergienko on 28.02.15.
//  Copyright (c) 2015 Alexandr Sergienko. All rights reserved.
//

#import "NSDate+ASRandomStudentAge.h"

@implementation NSDate (ASRandomStudentAge)

+ (NSDate *) generateRandomAgeForStudent {
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear |
                                                            NSCalendarUnitMonth |
                                                            NSCalendarUnitDay
                                                   fromDate:today];
    
    NSInteger currentYear = [dateComponents year];
    NSInteger yearOfBirthDate = currentYear - (arc4random_uniform(11) + 20);
    NSInteger monthOfBirthDate = arc4random_uniform(13);
    
    [dateComponents setYear:yearOfBirthDate];
    [dateComponents setMonth:monthOfBirthDate];
    
    NSRange rangeForDay = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[calendar dateFromComponents:dateComponents]];
    NSInteger dayOfBirthDate = arc4random_uniform((int)rangeForDay.length);

    // + 1 possibility of realization
    /*
     NSInteger periodInSecondsMin = 18 * 12 * 30 * 24 * 60 * 60;//min 18 years
    NSInteger periodInSecondsMax = 60 * 12 * 30 * 24 * 60 * 60;//max 60 years
    NSTimeInterval periodInSecondsRandom = periodInSecondsMin+(arc4random()%(periodInSecondsMax-periodInSecondsMin));
    
    NSDate *dateOfBirth = [NSDate dateWithTimeInterval:-periodInSecondsRandom
                                             sinceDate:now];
     */

    
    [dateComponents setDay:dayOfBirthDate];
    
    NSDate *randomDate = [calendar dateFromComponents:dateComponents];
    
    return randomDate;
}


@end
