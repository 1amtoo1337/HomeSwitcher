//
//  Settings.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 13.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Settings : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * serverIP;
@property (nonatomic, retain) NSString * serverPort;
@property (nonatomic, retain) NSString * webserverIndexPath;
@property (nonatomic, retain) NSString * webserverIP;
@property (nonatomic, retain) NSString * webserverPort;
@property (nonatomic, retain) NSString * serverExtIP;

@end
