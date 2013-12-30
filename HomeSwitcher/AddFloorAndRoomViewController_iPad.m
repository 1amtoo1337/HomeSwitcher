//
//  AddFloorAndRoomViewController_iPad.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddFloorAndRoomViewController_iPad.h"
#import "AddRoomViewController_iPad.h"
#import "ProgressHUD.h"
#import "Floor.h"
#import "Room.h"
#import "Outlet.h"
#import "Command.h"
@interface AddFloorAndRoomViewController_iPad ()

@property (strong, nonatomic) NSArray *sections;
@property BOOL textEntered;

@property (strong, nonatomic) NSArray *floor;
@property (strong, nonatomic) NSMutableArray *rooms;
@property (strong, nonatomic) NSMutableArray *outlets;

@end

@implementation AddFloorAndRoomViewController_iPad

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
    
    self.textEntered = NO;
    self.rooms = [NSMutableArray array];

    self.sections = [[NSArray alloc] initWithObjects:@"Floor", @"Room", nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelButtonClicked)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered  target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"Add Floor";
    
    //core data
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0) return 2; //floor
    if(section == 1) return self.rooms.count; //room s
    
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[textField resignFirstResponder];
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    if(section == 0 && row == 1) NSLog(@"Add");
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row == 0) return nil;
    
    return indexPath;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"%@",NSStringFromCGRect(cell.bounds));
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 600, 44)]; //#task#
    //textField.backgroundColor = [UIColor redColor];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:19];
    textField.font = [UIFont fontWithName:@"Avenir" size:19]; //#task#
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    textField.tag = indexPath.row + 200; //#task#

    textField.placeholder = @"Floorname"; // PLACEHLDR_ADD_ROOM
        
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell addSubview:textField];
        
    }else if(indexPath.section == 0 && indexPath.row == 1)
    {
        textField.text = @"Add Room";
        textField.enabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell addSubview:textField];
        
        UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(480, 5, 30, 30)];
        plus.image = [UIImage imageNamed:@"plus_add_green.png"];
        [cell addSubview:plus];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    else if(indexPath.section == 1)
    {
        textField.text = [[self.rooms objectAtIndex:indexPath.row] objectAtIndex:0]; //roomName
        textField.enabled = NO;
        [cell addSubview:textField];
    }
    

//    switch(indexPath.section)
//    {
//            //Section 0: Floor
//        case 0:
//            switch (indexPath.row)
//        {
//                case 0:
//
//                break;
//                    
//                default:
//                    break;
//        }
//            
//            //Section 1: Room
//        case 1:
//            switch (indexPath.row)
//        {
//            case 0:
//                ;
//                break;
//                
//            default:
//                break;
//        }
//            
//            default:
//            break;
//    }
    // Configure the cell...
    //cell.textLabel.text = @"asdf";
    
    return cell;
}


-(void)textFieldDidChange:(id)sender
{
    NSString *floorName = ((UITextField*)[self.view viewWithTag:200]).text;
    
    if(floorName.length > 0)
    {
        NSLog(@"text avlbl");
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.textEntered = YES;
        
        
    }else if(floorName.length == 0)
    {
        NSLog(@"no text avlbl");
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.textEntered = NO;
    }
    
}

-(void)doneButtonClicked
{
    NSLog(@"adding Floor");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelButtonClicked
{
    NSLog(@"canceling adding Floor");
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark - Segue Stuff

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"floorRoomAddSegue"])
    {
        AddRoomViewController_iPad *vc = [segue destinationViewController];
        vc.delegate = self;
        //vc.importOutlet = [self.outlets objectAtIndex:indexPath.row];
        
    }
}

#pragma mark - Room Delegate
-(void)didFinishRoomInput:(AddRoomViewController_iPad *)controller room:(NSArray *)roomArray
{
    [self.rooms addObject:roomArray];
    [ProgressHUD showSuccess:@"Room added"];
    [self.tableView reloadData];
}


@end
