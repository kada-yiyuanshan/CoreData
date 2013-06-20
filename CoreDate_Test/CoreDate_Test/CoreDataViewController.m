//
//  CoreDataViewController.m
//  CoreDate_Test
//
//  Created by kada on 13-6-18.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "CoreDataViewController.h"
#import "AppDelegate.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController
@synthesize input,num;
@synthesize tableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [input release];
    [tableview release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(IBAction)save:(id)sender
{
    [self insertdata];
}
-(IBAction)search:(id)sender
{
    [tableview reloadData];
    [self search];
}
-(IBAction)deletedate:(id)sender
{
    [self deletedate];
}
-(IBAction)bg:(id)sender
{
    [input resignFirstResponder];
}
-(void)insertdata
{
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context=[appDelegate managedObjectContext];
    NSManagedObject *manage=[NSEntityDescription insertNewObjectForEntityForName:@"CoreDate_Test" inManagedObjectContext:context];
    [manage setValue:input.text forKey:@"name"];
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}

-(void)deletedate
{
//    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context=[appDelegate managedObjectContext];
//    NSManagedObject *eventToDelete = [[self search] objectAtIndex:self.num];
//    [context deleteObject:eventToDelete];
}

-(NSMutableArray *)search
{
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context=[appDelegate managedObjectContext];
    NSFetchRequest *request=[[[NSFetchRequest alloc] init]autorelease];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CoreDate_Test" inManagedObjectContext:context];
    [request setEntity:entity];
    //使用过滤器查找条件相对应的数据
    //NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name = %@)",name.text];
    //[request setPredicate:pred];
    NSError *error;
    NSArray *arry=[context executeFetchRequest:request error:&error];
    NSMutableArray *data_arry=[[[NSMutableArray alloc]init] autorelease];
    for (NSManagedObject *u_name in arry) {
         [data_arry  addObject:[u_name valueForKey:@"name"]];
    }
    return data_arry;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self search] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.detailTextLabel.text=[[self search] objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.num=indexPath.row;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
