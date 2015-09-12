//
//  JTSActionSheet.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

@import UIKit;

#import "JTSActionSheetItem.h"
#import "JTSActionSheetTheme.h"
#import "JTSActionSheetConveniences.h"

@interface JTSActionSheet : UIView

@property (strong, nonatomic, readonly) JTSActionSheetTheme *theme;
@property (strong, nonatomic, readonly) JTSActionSheetItem *cancelItem;
@property (copy, nonatomic, readwrite) NSString *title;

- (instancetype)initWithTheme:(JTSActionSheetTheme *)theme
                        title:(NSString *)title
                  actionItems:(NSArray *)items
                   cancelItem:(JTSActionSheetItem *)cancelItem;

- (void)showInView:(UIView *)view;

- (void)setEnabled:(BOOL)enabled buttonAtIndex:(NSInteger)index;

@end
