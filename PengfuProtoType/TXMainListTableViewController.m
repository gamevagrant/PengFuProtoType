//
//  TXMainListTableViewController.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-12.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXMainListTableViewController.h"
#import "TXMainListTableViewCell.h"
#import "TXSourceManager.h"
#import "TXPostsData.h"
#import "TXIterator.h"
#import "TXImage.h"
#import "TXContentItem.h"


#define FontSize 18


@interface TXMainListTableViewController ()

@end

@implementation TXMainListTableViewController
{
    NSArray *dataList;
}

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataList = [TXSourceManager getPosterList];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TXMainListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell" forIndexPath:indexPath];
    // Configure the cell...
    
    [cell setCellData:(TXPostsData *)dataList[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TXPostsData *data = dataList[indexPath.row];
    TXIterator *iterator = data.contentIterator;
    CGFloat height = HeadHeight + FootHeight;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width - Margins * 2;
    while (iterator.hasNext)
    {
        TXContentItem *content = [iterator next];
        
        if (content.type == TX_CONTENT_PICTURE)
        {
            
            TXImage *image = content.item;
            
            height += width/image.size.width * image.size.height;
        }else if(content.type == TX_CONTENT_JOKE)
        {
            UIFont *font = [UIFont systemFontOfSize:FontSize];
            NSString *str = content.item;
            CGRect strRect = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
            height += strRect.size.height;
        }
    }
    [iterator first];
    return height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
