//
//  Command.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Outlet;

@interface Command : NSManagedObject

@property (nonatomic, retain) NSString * off;
@property (nonatomic, retain) NSString * on;
@property (nonatomic, retain) Outlet *outlet;

@end
