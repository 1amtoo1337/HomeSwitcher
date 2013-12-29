//
//  FloorListViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "FloorListViewController.h"
#import "AddFloorViewController.h"
#import "RoomListViewController.h"
#import "Floor.h"
#import "ProgressHUD.h"


@interface FloorListViewController ()

@property (nonatomic, strong) NSArray *floors;

@end

@implementation FloorListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //core data
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [self fetchFloorsFromCoreData];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) return @"Floor";
    
    return @"default";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.floors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Floor *floor = [self.floors objectAtIndex:indexPath.row];
    cell.textLabel.text = floor.name;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    
    UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chevron.png"]];
    cell.accessoryView = checkmark;
    
    
    return cell;
}

-(void)fetchFloorsFromCoreData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Floor" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    self.floors = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

#pragma mark - Segue Stuff

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"FloorListToDetailSegue"])
    {
        RoomListViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        Floor *floor = [self.floors objectAtIndex:indexPath.row];
        vc.floor = floor;
    }
    
    if([[segue identifier] isEqualToString:@"FloorListToAddSegue"])
    {
        AddFloorViewController *vc = [[[segue destinationViewController] viewControllers] objectAtIndex:0];
        
        vc.delegate = self;
    }
    
}

#pragma mark - Custom Delegate Implementation

-(void)didFinishFloorInput:(AddFloorViewController *)controller
{
    NSLog(@"finished floor input fired");
    [self fetchFloorsFromCoreData];
    [ProgressHUD showSuccess:@"Floor added"];
    [self.tableView reloadData];
}
@end
