//
//  AddRoomViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddRoomViewController.h"
#import "InputCell.h"
#import "Room.h"
#import "Outlet.h"
#import "Command.h"

@interface AddRoomViewController ()

@property BOOL textEntered;
@property (strong,nonatomic) NSMutableArray *outlets;

@end

@implementation AddRoomViewController

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
    self.outlets = [NSMutableArray array];
    
    //set navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) return @"Room";
    if(section == 1) return @"Outlets";
    
    return @"default";
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIImageView *headerTitleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
//    //[headerTitleView setImage:sectionHeaderBackgroundImage];
//
//    UILabel *sectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 40, 38, 22 - 10)];
//    sectionTitleLabel.textColor = [UIColor redColor];
//    sectionTitleLabel.backgroundColor = [UIColor clearColor];
//    sectionTitleLabel.textAlignment = NSTextAlignmentLeft;
//    sectionTitleLabel.text = @"Room";
//    sectionTitleLabel.font = [UIFont fontWithName:@"Avenir" size:16];
//    [sectionTitleLabel setAdjustsFontSizeToFitWidth:YES];
//    [headerTitleView addSubview:sectionTitleLabel];
//
//    return headerTitleView;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.outlets.count == 0) return 1;
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) return 2;
    if(section == 1) return self.outlets.count;
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    InputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        cell.nameLabel.text = @"Name:";
        cell.nameLabel.font = [UIFont fontWithName:@"Avenir" size:16]; //#task#
        cell.textField.delegate = self;
        cell.textField.tag = 11; //#task#
        cell.textField.font = [UIFont fontWithName:@"Avenir" size:19]; //#task#
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else if(indexPath.section == 0 && indexPath.row == 1)
    {
        cell.nameLabel.text = @"Add Outlet";
        cell.nameLabel.font = [UIFont fontWithName:@"Avenir" size:16]; //#task#
        [cell.textField setHidden:YES];

        UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(270, 5, 30, 30)];
        plus.image = [UIImage imageNamed:@"plus_add_green.png"];
        
        [cell addSubview:plus];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else if(indexPath.section == 1)
    {
        NSString *str = [[self.outlets objectAtIndex:indexPath.row] objectAtIndex:0];
        cell.nameLabel.text = str;
        cell.nameLabel.font = [UIFont fontWithName:@"Avenir" size:16]; //#task#
        cell.textField.hidden = YES;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    if(section == 0 && row == 1) NSLog(@"Add");
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row == 0) return nil;
    
    return indexPath;
}


#pragma mark- UIScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - Segue Stuff

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"roomToOutletAddSegue"])
    {
        AddOutletViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        //vc.importOutlet = [self.outlets objectAtIndex:indexPath.row];
        
    }
}

#pragma mark - Outlet Delegate
-(void)didSelectWith:(AddOutletViewController *)controller outlet:(NSArray *)outlet
{
    for(NSString *str in outlet)
    {
        NSLog(@"String: '%@'",str);
    }
    [self.outlets addObject:outlet];
    NSLog(@"Outlets: '%i'",self.outlets.count);
    [self.tableView reloadData];
    
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

#pragma mark - Custom Implementation

- (IBAction)validateInput:(UIBarButtonItem *)sender
{
    NSString *roomName = ((UITextField*)[self.view viewWithTag:11]).text;
    
    //this fuction needs to trigger a delegate method that reloads the listView tableView
    if([roomName isEqualToString:@""] || self.outlets.count == 0)
    {
        NSString *err1 = @"No Roomname specified";
        NSString *err2 = @"No Outlets for room specified";
        
        UIAlertView *alert;
        if([roomName isEqualToString:@""])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err1 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }else if (self.outlets.count == 0)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err2 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
        
    }else if(![roomName isEqualToString:@""] && self.outlets.count != 0)
    {
        [self saveData];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

-(void)saveData
{
    NSString *roomName = ((UITextField*)[self.view viewWithTag:11]).text;
    //    NSString *outletName = ((UITextField*)[self.view viewWithTag:12]).text;
    //    NSString *outletOn = ((UITextField*)[self.view viewWithTag:13]).text;
    //    NSString *outletOff = ((UITextField*)[self.view viewWithTag:14]).text;
    
    NSMutableArray *allOutlets = [NSMutableArray array];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    Room *room = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Room"
                  inManagedObjectContext:context];
    [room setValue:roomName forKey:@"name"];
    
    for (NSArray *arr in self.outlets)
    {
        Outlet *tOutlet =[NSEntityDescription
                          insertNewObjectForEntityForName:@"Outlet"
                          inManagedObjectContext:context];
        tOutlet.name = [arr objectAtIndex:0];
        tOutlet.state = 0;
        tOutlet.room = room;
        
        Command *tCommand = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Command"
                             inManagedObjectContext:context];
        tCommand.on = [arr objectAtIndex:1];
        tCommand.off = [arr objectAtIndex:2];
        tCommand.outlet = tOutlet;
        tOutlet.command = tCommand;
        
        [allOutlets addObject:tOutlet];
        
    }
    
    [room.outlets setByAddingObjectsFromArray:allOutlets];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.delegate didFinishRoomInput]; //kasius knaktus
    
}


- (IBAction)dismissAddView:(UIBarButtonItem *)sender
{
    NSString *text = ((UITextField*)[self.view viewWithTag:11]).text;
    
    if(![text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel" message:@"Are you sure you want to cancel?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
        [alert show];
        
    }else if([text isEqualToString:@""])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"cancel");
    } else if (buttonIndex == 1)
    {
        NSLog(@"ok");
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:self];
    }
}

@end
