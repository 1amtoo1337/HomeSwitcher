//
//  AMMMultipleDetailManager.h
//  MultipleDetailView
//
//  Created by Alfonso Moreno on 11/14/13.
//  Copyright (c) 2013 Alfonso Moreno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMMMultipleDetailManager : NSObject <UISplitViewControllerDelegate, UITableViewDelegate>

-(id)initWithSplitViewController:(UISplitViewController*)splitViewController
       withDetailRootControllers:(NSArray*)detailControllers;

@end
