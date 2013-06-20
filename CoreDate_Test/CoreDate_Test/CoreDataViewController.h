//
//  CoreDataViewController.h
//  CoreDate_Test
//
//  Created by kada on 13-6-18.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CoreDataViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UITextField *input;
    NSInteger num;
}

@property(retain,nonatomic) IBOutlet UITextField *input;
@property(retain,nonatomic) IBOutlet UITableView *tableview;
@property(assign,nonatomic) NSInteger num;

-(IBAction)save:(id)sender;
-(IBAction)search:(id)sender;
-(IBAction)bg:(id)sender;
-(IBAction)deletedate:(id)sender;
@end
