//
//  Lightstrip.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room;

@interface Lightstrip : NSManagedObject

@property (nonatomic, retain) NSNumber * brightness;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * stateOn;
@property (nonatomic, retain) NSNumber * strobe;
@property (nonatomic, retain) NSNumber * valueColorB;
@property (nonatomic, retain) NSNumber * valueColorG;
@property (nonatomic, retain) NSNumber * valueColorR;
@property (nonatomic, retain) Room *room;

@end
