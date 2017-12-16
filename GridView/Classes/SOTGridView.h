//
//  SOTGridView.h
//  GridView
//
//  Created by Andrea Altea on 07/12/16.
//  Copyright © 2016 Andrea Altea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOTGridItem.h"

@class SOTGridView;

typedef enum : NSUInteger {
    SOTGridCompositionModeHorizontal,
    SOTGridCompositionModeVertical
} SOTGridCompositionMode;

@protocol SOTGridViewDataSource <NSObject>

/*!
 *
 *
 */

- (NSInteger) numberOfItemsInGridView:(SOTGridView *_Nonnull)gridView;

/*!
 *
 *
 */
- (SOTGridItem *_Nonnull) gridView:(SOTGridView *_Nonnull)gridView viewAtIndex:(NSInteger)index;

@end

@protocol SOTGridViewDelegate <NSObject>

@optional

- (void) gridView:(SOTGridView *_Nonnull)gridView didSelectItemAtIndex:(NSInteger)index;

- (BOOL) gridView: (SOTGridView *_Nonnull)gridView shouldLongPressItemAtIndex:(NSInteger)index;

- (void) gridView:(SOTGridView *_Nonnull)gridView didLongPressItemAtIndex:(NSInteger)index;

@end

@interface SOTGridView : UIView

@property (nonatomic) SOTGridCompositionMode compositionMode;
@property (nonatomic) IBInspectable NSInteger numberOfColumns;
@property (nonatomic) IBInspectable UIEdgeInsets contentMargins;
@property (nonatomic) IBInspectable CGFloat stacksDistance;
@property (nonatomic) IBInspectable CGFloat itemsDistance;

@property (nonatomic, weak, nullable) IBOutlet NSObject<SOTGridViewDelegate> *delegate;
@property (nonatomic, weak, nullable) IBOutlet NSObject<SOTGridViewDataSource> *dataSource;

- (void) reloadContents;
- (void) selectItemAtIndex:(NSInteger)index;
- (void) deselectItemAtIndex:(NSInteger)index;

@end
