//
//  TXMainListTableViewController.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-12.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXMainListTableViewController.h"
#import "TXMainListTableViewCellMore.h"
#import "TXMainListTableViewCellImage.h"
#import "TXMainListTableViewCellText.h"
#import "TXMainListTableViewCellComment.h"
#import "TXMainListTableViewCellHeader.h"
#import "TXMainListTableViewCellFooter.h"
#import "TXSourceManager.h"
#import "TXPostsData.h"
#import "TXIterator.h"
#import "TXImage.h"
#import "TXContentItem.h"
#import "TXDefine.h"


#define FontSize 18


@interface TXMainListTableViewController ()

@end

@implementation TXMainListTableViewController
{
    NSArray *dataList;
    NSMutableArray *expandedIndexPaths;
    NSInteger actionToTake;
    BOOL enableAutoScroll;
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
    expandedIndexPaths = [[NSMutableArray alloc]init];
    enableAutoScroll = YES;
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
    return dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    TXPostsData *data = dataList[section];
    TXIterator *iterator = data.contentIterator;
    
    return iterator.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TXPostsData *postsData = dataList[indexPath.section];
    TXIterator *iterator = postsData.contentIterator;
    
    UITableViewCell *resultCell;
    if(indexPath.row == iterator.count)//更多按钮
    {
        TXMainListTableViewCellMore *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCellMore" forIndexPath:indexPath];
        resultCell = cell;
    }else
    {
        TXContentItem *content = [iterator getItemWidthIndex:indexPath.row];
        if (content.type == TX_CONTENT_PICTURE)
        {
            TXImage *txImage = content.item;
            TXMainListTableViewCellImage *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCellImage" forIndexPath:indexPath];
            cell.txImage = txImage;
            resultCell = cell;
            
        }else if(content.type == TX_CONTENT_JOKE)
        {
            TXMainListTableViewCellText *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCellText" forIndexPath:indexPath];
            cell.text = content.item;
            resultCell = cell;
        }
    }
    return resultCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TXPostsData *postsData = dataList[section];
    
    TXMainListTableViewCellHeader *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCellHeader" forIndexPath:[NSIndexPath indexPathForRow:1 inSection:section]];
    cell.data = postsData;

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TXMainListTableViewCellFooter *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCellFooter" forIndexPath:[NSIndexPath indexPathForRow:1 inSection:section]];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TXPostsData *data = dataList[indexPath.section];
    TXIterator *iterator = data.contentIterator;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width - Margins * 2;
    CGFloat height = Margins * 2;
    
    if(indexPath.row == iterator.count)//更多按钮
    {
        height = 40;
    }else
    {
        TXContentItem *content = [iterator getItemWidthIndex:indexPath.row];
        if (content.type == TX_CONTENT_PICTURE)
        {
            
            TXImage *image = content.item;
            
            height = width/image.size.width * image.size.height;
        }else if(content.type == TX_CONTENT_JOKE)
        {
            UIFont *font = [UIFont systemFontOfSize:FontSize];
            NSString *str = content.item;
            CGRect strRect = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
            height = strRect.size.height;
        }
    }
    
    
    
//    CGFloat height = HeadHeight + FootHeight;
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//    CGFloat width = screenSize.width - Margins * 2;
//    while (iterator.hasNext)
//    {
//        TXContentItem *content = [iterator next];
//        
//        if (content.type == TX_CONTENT_PICTURE)
//        {
//            
//            TXImage *image = content.item;
//            
//            height += width/image.size.width * image.size.height;
//        }else if(content.type == TX_CONTENT_JOKE)
//        {
//            UIFont *font = [UIFont systemFontOfSize:FontSize];
//            NSString *str = content.item;
//            CGRect strRect = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
//            height += strRect.size.height;
//        }
//        height += Margins;
//    }
//    [iterator first];
//    
//    if(actionToTake == 1)
//    {
//        height += 100;
//    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL alreadyExpanded = NO;
    NSIndexPath* correspondingIndexPath;
    for (NSIndexPath* anIndexPath in expandedIndexPaths) {
        if (anIndexPath.row == indexPath.row && anIndexPath.section == indexPath.section)
        {alreadyExpanded = YES; correspondingIndexPath = anIndexPath;}
    }
    
    if (alreadyExpanded)////collapse it!
    {
        actionToTake = -1;
        [expandedIndexPaths removeObject:correspondingIndexPath];
        [tableView beginUpdates];
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }
    else ///expand it!
    {
        actionToTake = 1;
        [expandedIndexPaths addObject:indexPath];
        [tableView beginUpdates];
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        if (enableAutoScroll)
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
//    [self.tableView beginUpdates];
//    [self.tableView endUpdates];
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
