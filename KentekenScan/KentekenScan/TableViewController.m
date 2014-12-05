//
//  TableViewController.m
//  KentekenScan
//
//  Created by Jetse Koopmans on 04/12/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//
//  Code for the TableViewController to show the license plates in the table.
//

#import "TableViewController.h"

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Lijst";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Shows how many rows there are in the tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.results count];
}

// Show for each row in the tableView the license plate.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.results objectAtIndex:indexPath.row];
    
    return cell;
}

@end
