//
//  TableViewController.h
//  KentekenScan
//
//  Created by Jetse Koopmans on 04/12/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface TableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *results;
@property (nonatomic,strong) NSString *result;

@end
