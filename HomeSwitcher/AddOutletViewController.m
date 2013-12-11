//
//  AddOutletViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 10.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddOutletViewController.h"
#import "OutletInputCell.h"


@interface AddOutletViewController ()

@property (strong,nonatomic) NSArray *array;

@end

@implementation AddOutletViewController

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

    //hide backButton
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.array = [[NSArray alloc] initWithObjects:@"Name:",@"Command ON:", @"Command OFF:", nil];
    
    //navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Add Outlet";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    OutletInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.outletNameLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.outletNameLabel.font = [UIFont fontWithName:@"Avenir" size:16]; //#task#
    cell.outletTextField.tag = indexPath.row + 100;
    cell.outletTextField.delegate = self;
    cell.outletTextField.font = [UIFont fontWithName:@"Avenir" size:19]; //#task#
    
    return cell;
}


#pragma mark - UITextField Delegate

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

#pragma mark - custom

-(void)showAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel?" message:@"Do you really want to cancel ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"cancel");
    } else if (buttonIndex == 1)
    {
        NSLog(@"ok");
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
}

- (IBAction)cancelOutletEntry:(UIBarButtonItem *)sender
{
    [self showAlertView];
    
}

- (IBAction)saveOutlet:(UIBarButtonItem *)sender
{
    
    NSString *outletName = ((UITextField*)[self.view viewWithTag:100]).text;
    NSString *commandOn = ((UITextField*)[self.view viewWithTag:101]).text;
    NSString *commandOff = ((UITextField*)[self.view viewWithTag:102]).text;
    
    //this fuction needs to trigger a delegate method that reloads the listView tableView
    if([outletName isEqualToString:@""] || [commandOn isEqualToString:@""] || [commandOff isEqualToString:@""])
    {
        //not all fields were entered
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:@"Not all fields were entered" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }else if(![outletName isEqualToString:@""] && ![commandOn isEqualToString:@""] && ![commandOff isEqualToString:@""])
    {

        /*
         create an outlet object, save it in core data, delegate it to the parent view controller
         if the room gets saved attach it to the corresponding room, if not delete the outlets 
         first, before dismissing the input process
         
         #task#
         */
        NSArray *myOutlet = [NSArray arrayWithObjects:outletName, commandOn, commandOff, nil];
        [self.delegate didSelectWith:self outlet:myOutlet];
        
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
