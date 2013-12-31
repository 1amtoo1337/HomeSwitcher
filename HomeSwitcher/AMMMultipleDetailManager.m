//
//  AMMMultipleDetailManager.m
//  MultipleDetailView
//
//  Created by Alfonso Moreno on 11/14/13.
//  Copyright (c) 2013 Alfonso Moreno. All rights reserved.
//

#import "AMMMultipleDetailManager.h"

@interface AMMMultipleDetailManager()
@property (weak,nonatomic)UISplitViewController * splitViewController;
@property (strong,nonatomic)NSArray * detailControllers;
@property (weak,nonatomic)UIViewController * currentDetailController;

// Management of the UISplitViewController button and popover
@property (strong,nonatomic) UIBarButtonItem * masterBarButtonItem;
@property (strong,nonatomic) UIPopoverController * masterPopoverController;
@end

@implementation AMMMultipleDetailManager

-(id)initWithSplitViewController:(UISplitViewController*)splitViewController
       withDetailRootControllers:(NSArray*)detailControllers {
    
    if (self = [super init]) {
        _splitViewController = splitViewController;
        _detailControllers = [detailControllers copy];
        UINavigationController* detailRoot = [splitViewController.viewControllers objectAtIndex:1];
        _currentDetailController = detailRoot.topViewController;
        
        splitViewController.delegate = self;
        
        UINavigationController * masterNavigationController = [splitViewController.viewControllers objectAtIndex:0];
        UITableViewController * masterViewController = (id)masterNavigationController.topViewController;
        
        masterViewController.tableView.delegate = self;
    }
    
    return self;
}


#pragma mark - UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    self.masterBarButtonItem = barButtonItem;
    self.masterPopoverController = popoverController;
    
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    
    [self.currentDetailController.navigationItem setLeftBarButtonItem:self.masterBarButtonItem animated:YES];
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.masterBarButtonItem = nil;
    self.masterPopoverController = nil;
    
    [self.currentDetailController.navigationItem setLeftBarButtonItem:nil animated:YES];
    
}

#pragma mark - UITableViewControllerDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Section: '%i' Row: '%i'",indexPath.section, indexPath.row);
    UINavigationController* detailRootController = [self.detailControllers objectAtIndex:indexPath.row];
    UIViewController* detailControler = detailRootController.topViewController;
    
    if(detailControler != self.currentDetailController)
    {
        // Swap button in detail controller
        [self.currentDetailController.navigationItem setLeftBarButtonItem:nil animated:NO];
        self.currentDetailController = detailControler;
        [self.currentDetailController.navigationItem setLeftBarButtonItem:self.masterBarButtonItem animated:NO];
        
        // Update controllers in splitview
        UIViewController * menu = [self.splitViewController.viewControllers objectAtIndex:0];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:menu,detailRootController, nil];
    }
}

@end

