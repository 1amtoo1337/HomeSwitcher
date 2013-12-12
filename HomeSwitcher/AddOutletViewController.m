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

@property (strong,nonatomic) NSArray *cellText;
@property BOOL textEntered;

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

    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.cellText = [[NSArray alloc] initWithObjects:@"Name:",@"Command ON:", @"Command OFF:", nil];
    
    //navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UITextField *outletNameTextField = ((UITextField*)[self.view viewWithTag:100]); //#task#
    [outletNameTextField becomeFirstResponder];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];

    NSString *sectionTitle = @"Add Outlet";
    label.frame = CGRectMake(5, 28, 284, 23);
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont fontWithName:@"Avenir" size:17];
    label.text = sectionTitle;
    label.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [view addSubview:label];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellText.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    OutletInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.outletTextField.tag = indexPath.row + 100; //#task#
    cell.outletTextField.delegate = self;
    cell.outletTextField.font = [UIFont fontWithName:@"Avenir" size:19]; //#task#
    [cell.outletTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    cell.outletTextField.placeholder = [self.cellText objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)textFieldDidChange:(id)sender
{
    NSString *outletName = ((UITextField*)[self.view viewWithTag:100]).text;
    NSString *commandOn = ((UITextField*)[self.view viewWithTag:101]).text;
    NSString *commandOff = ((UITextField*)[self.view viewWithTag:102]).text;

    if(outletName.length > 0 || commandOn.length > 0 || commandOff.length > 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.textEntered = YES;

        
    }else if(outletName.length == 0 || commandOn.length == 0 || commandOff.length == 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.textEntered = NO;

    }
    
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
    if(self.textEntered == YES)
    {
        [self showAlertView];
        
    }else if(self.textEntered == NO)
    {
        [self.navigationController popViewControllerAnimated:YES];
         //popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)validateInput:(UIBarButtonItem *)sender
{
    
    NSString *outletName = ((UITextField*)[self.view viewWithTag:100]).text;
    NSString *commandOn = ((UITextField*)[self.view viewWithTag:101]).text;
    NSString *commandOff = ((UITextField*)[self.view viewWithTag:102]).text;
    
    //this fuction needs to trigger a delegate method that reloads the listView tableView
    if([outletName isEqualToString:@""] || [commandOn isEqualToString:@""] || [commandOff isEqualToString:@""])
    {
        NSString *err0 = @"No Outletname specified";
        NSString *err1 = @"Please specify Command ON";
        NSString *err2 = @"Please specify Command OFF";
        
        //not all fields were entered
        UIAlertView *alert;
        if([outletName isEqualToString:@""])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err0 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }else if ([commandOn isEqualToString:@""])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err1 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }else if ([commandOff isEqualToString:@""])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err2 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }

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
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
