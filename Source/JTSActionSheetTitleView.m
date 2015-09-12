//
//  JTSActionSheetTitleView.m
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetTitleView.h"

#import "JTSActionSheetTheme.h"
#import "JTSActionSheetConveniences.h"

@interface JTSActionSheetTitleView ()

@property (strong, nonatomic) NSAttributedString *attributedTitle;
@property (strong, nonatomic) UILabel *titleLabel;
@property (copy, nonatomic) NSString *title;

@end

@implementation JTSActionSheetTitleView

#pragma mark - Public

- (instancetype)initWithTitle:(NSString *)title
                        theme:(JTSActionSheetTheme *)theme
                     position:(JTSActionSheetItemViewPosition)position {
    
    self = [super initWithTheme:theme position:position];
    if (self) {
        
        _title = title.copy;
        
        self.accessibilityTraits = UIAccessibilityTraitStaticText | UIAccessibilityTraitHeader;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, JTSActionSheetMargin * 2.0, JTSActionSheetMargin * 2.0)];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.numberOfLines = 24;
        self.titleLabel.isAccessibilityElement = NO;
        self.isAccessibilityElement = YES;
        
        self.attributedTitle = [self createAttributeStringByText:_title];
        self.titleLabel.attributedText = self.attributedTitle;
        
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title.copy;
    self.attributedTitle = [self createAttributeStringByText:_title];
    self.titleLabel.attributedText = self.attributedTitle;
}

#pragma mark - Accessibility

- (NSString *)accessibilityLabel {
    return self.title;
}

#pragma mark - JTSActionSheetItemView

- (CGFloat)intrinsicHeightGivenAvailableWidth:(CGFloat)availableWidth {
    CGRect boundingRect = [self.titleLabel.attributedText
                           boundingRectWithSize:CGSizeMake(availableWidth - JTSActionSheetMargin*4.0, CGFLOAT_MAX)
                           options:NSStringDrawingUsesLineFragmentOrigin
                           context:nil];
    CGFloat actualHeight = roundf(JTSActionSheetMargin * 4.0 + boundingRect.size.height + 4.0); // pad by 4px to account for UILabel inconsistencies
    CGFloat maxHeight = 400;
    return MIN(actualHeight, maxHeight);
}

#pragma mark - Private

- (NSAttributedString *)createAttributeStringByText:(NSString *)text
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName : self.theme.titleFont,
                                 NSForegroundColorAttributeName : self.theme.titleColor,
                                 NSParagraphStyleAttributeName : paragraphStyle,
                                 NSBaselineOffsetAttributeName : @(self.theme.titleBaselineOffset)
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end



