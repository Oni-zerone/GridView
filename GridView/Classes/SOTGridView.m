//
//  SOTGridView.m
//  GridView
//
//  Created by Andrea Altea on 07/12/16.
//  Copyright © 2016 Andrea Altea. All rights reserved.
//

#import <SOTGridView/SOTGridView-Swift.h>
#import "SOTGridView.h"

@interface SOTGridView ()

@property (nonatomic, strong) NSMutableArray<UIView *> *columns;
@property (nonatomic, strong) NSMutableArray<SOTGridItem *> *items;

@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *columnSeparators; //Really needed?


@end

@implementation SOTGridView

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        [self setupUI];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    
    //Setup arrays
    [self setColumnSeparators:[NSMutableArray array]];
    
    //Setup parameters as default values
    _compositionMode = SOTGridCompositionModeVertical;
    _contentMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    _numberOfColumns = 0;
    _stacksDistance = 0;
    [self setNumberOfColumns:1];
}

- (void) setupColumns {
    NSArray *oldColumns = [self.columns copy];
    for(UIView *column in oldColumns) {
        [column removeFromSuperview];
    }
    [self setColumns: [NSMutableArray array]];
    [self setItems:[NSMutableArray array]];
    
    //Load new columns
    for (NSInteger index = 0; index < self.numberOfColumns; index++) {
        [self insertColumnAtIndex:index];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void) insertColumnAtIndex:(NSInteger)index {
    
    //Add column in View
    UIView *column = [[UIView alloc] initWithFrame:CGRectZero];
    [column setTranslatesAutoresizingMaskIntoConstraints:NO];
    [column setClipsToBounds:NO];
    [self addSubview:column];
    [self.columns addObject:column];
    
    //Add composition direction constraint
    UIView *secondAnchor;
    NSLayoutAttribute firstAttribute = 0;
    CGFloat contentDistance = 0;
    if(self.columns.count == 1) {
        secondAnchor = self;
        firstAttribute = self.compositionMode == SOTGridCompositionModeVertical ? NSLayoutAttributeLeading : NSLayoutAttributeTop;
        if(self.compositionMode == SOTGridCompositionModeVertical) {
            contentDistance = [self interfaceLayoutDirection] == UIUserInterfaceLayoutDirectionLeftToRight ? -self.contentMargins.left : -self.contentMargins.right;
        } else {
            contentDistance = -self.contentMargins.top;
        }
    } else {
        secondAnchor = [self.columns objectAtIndex:index - 1];
        firstAttribute = self.compositionMode == SOTGridCompositionModeVertical ? NSLayoutAttributeTrailing : NSLayoutAttributeBottom;
        if(self.compositionMode == SOTGridCompositionModeVertical) {
            contentDistance = -self.stacksDistance;

        } else {
            contentDistance = -self.stacksDistance;
        }
    }
    NSLayoutAttribute secondAttribute = self.compositionMode == SOTGridCompositionModeVertical ? NSLayoutAttributeLeading : NSLayoutAttributeTop;
    NSLayoutConstraint *firstConstraint = [NSLayoutConstraint constraintWithItem:secondAnchor
                                                                       attribute:firstAttribute
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:column
                                                                       attribute:secondAttribute
                                                                      multiplier:1
                                                                        constant:contentDistance];
    [self addConstraint:firstConstraint];
    
    //Add orghogonal constraints
    NSLayoutAttribute firstOrthogonalAttribute;
    NSLayoutAttribute secondOrhogonalAttribute;
    CGFloat firstOrthogonalDistance = 0;
    CGFloat secondOrthogonalDistance = 0;
    if(self.compositionMode == SOTGridCompositionModeVertical) {
        firstOrthogonalAttribute = NSLayoutAttributeBottom;
        secondOrhogonalAttribute = NSLayoutAttributeTop;
        firstOrthogonalDistance = self.contentMargins.top;
        secondOrthogonalDistance = self.contentMargins.bottom;
        
    } else {
        firstOrthogonalAttribute = NSLayoutAttributeTrailing;
        secondOrhogonalAttribute = NSLayoutAttributeLeading;
        firstOrthogonalDistance = [self interfaceLayoutDirection] == UIUserInterfaceLayoutDirectionLeftToRight ? self.contentMargins.left : self.contentMargins.right;
        secondOrthogonalDistance = [self interfaceLayoutDirection] == UIUserInterfaceLayoutDirectionLeftToRight ? self.contentMargins.right : self.contentMargins.left;
    }
    
    NSLayoutConstraint *firstOrthogonalConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                attribute:firstOrthogonalAttribute
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:column
                                                                                attribute:firstOrthogonalAttribute
                                                                               multiplier:1
                                                                                 constant:firstOrthogonalDistance];
    NSLayoutConstraint *secondOrthogonalConstraint = [NSLayoutConstraint constraintWithItem:column
                                                                                  attribute:secondOrhogonalAttribute
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self
                                                                                  attribute:secondOrhogonalAttribute
                                                                                 multiplier:1
                                                                                   constant:secondOrthogonalDistance];
    [self addConstraint:firstOrthogonalConstraint];
    [self addConstraint:secondOrthogonalConstraint];
    
    //Add row dimension constraint
    if(self.columns.count > 1) {
        NSLayoutAttribute dimensionAttribute = self.compositionMode == SOTGridCompositionModeVertical ? NSLayoutAttributeWidth : NSLayoutAttributeHeight;
        NSLayoutConstraint *dimensionConstraint = [NSLayoutConstraint constraintWithItem:self.columns.firstObject
                                                                               attribute:dimensionAttribute
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:column
                                                                               attribute:dimensionAttribute
                                                                              multiplier:1
                                                                                constant:0];
        [self addConstraint:dimensionConstraint];
    }
    
    //Add closing constraint
    if(index < self.numberOfColumns - 1) {
        return;
    }
    NSLayoutAttribute lastConstraintAttribute;
    CGFloat lastConstraintDistance = 0;
    if (self.compositionMode == SOTGridCompositionModeVertical) {
        lastConstraintAttribute = NSLayoutAttributeTrailing;
        lastConstraintDistance = [self interfaceLayoutDirection] == UIUserInterfaceLayoutDirectionLeftToRight ? -self.contentMargins.right : -self.contentMargins.left;
    } else {
        
        lastConstraintAttribute = NSLayoutAttributeBottom;
        lastConstraintDistance = -self.contentMargins.bottom;
    }
    NSLayoutConstraint *lastConstraint = [NSLayoutConstraint constraintWithItem:column
                                                                      attribute:lastConstraintAttribute
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:lastConstraintAttribute
                                                                     multiplier:1
                                                                       constant:lastConstraintDistance];
    [self addConstraint:lastConstraint];
}

- (void) insertItemAtIndex:(NSInteger)index ofTotal:(NSInteger)total {
    
    SOTGridItem *view = [self.dataSource gridView:self viewAtIndex:index];
    [view addTarget:self action:@selector(didSelectItem:) forControlEvents:UIControlEventTouchUpInside];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Get the correct column into insert the view
    UIView *column = [self.columns objectAtIndex:(index % self.columns.count)];
    [column addSubview:view];
    [self.items addObject:view];
    
    //Set constraints
    UIView *firstAnchor;
    NSLayoutAttribute firstAnchorAttribute;
    NSLayoutAttribute secondAnchorAttribute;
    CGFloat firstAnchorDistance = 0;
    if(index < self.numberOfColumns) {
        //First item in column
        firstAnchor = column;
        
        if (self.compositionMode == SOTGridCompositionModeVertical) {
            firstAnchorAttribute = NSLayoutAttributeTop;
            secondAnchorAttribute = NSLayoutAttributeTop;
            
        } else {
            firstAnchorAttribute = NSLayoutAttributeLeading;
            secondAnchorAttribute = NSLayoutAttributeLeading;
        }
        firstAnchorDistance = 0;
        
        
    } else {
        
        //following items in column
        firstAnchor = [self.items objectAtIndex:(index - self.numberOfColumns)];
        
        if (self.compositionMode == SOTGridCompositionModeVertical) {
            firstAnchorAttribute = NSLayoutAttributeBottom;
            secondAnchorAttribute = NSLayoutAttributeTop;
            
        } else {
            firstAnchorAttribute = NSLayoutAttributeTrailing;
            secondAnchorAttribute = NSLayoutAttributeLeading;
        }
        firstAnchorDistance = -self.itemsDistance;
    }
    
    NSLayoutConstraint *firstAnchorConstraint = [NSLayoutConstraint constraintWithItem:firstAnchor
                                                                             attribute:firstAnchorAttribute
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:view
                                                                             attribute:secondAnchorAttribute
                                                                            multiplier:1
                                                                              constant:firstAnchorDistance];
    [column addConstraint:firstAnchorConstraint];
    
    //Orthogonal Constraints
    NSLayoutAttribute firstOrthogonalAttribute;
    NSLayoutAttribute secondOrthogonalAttribute;
    if(self.compositionMode == SOTGridCompositionModeVertical) {
        firstOrthogonalAttribute = NSLayoutAttributeLeading;
        secondOrthogonalAttribute = NSLayoutAttributeTrailing;
    
    } else {
        firstOrthogonalAttribute = NSLayoutAttributeTop;
        secondOrthogonalAttribute = NSLayoutAttributeBottom;
    }
    
    NSLayoutConstraint *firstOrthogonalConstraint = [NSLayoutConstraint constraintWithItem:column
                                                                                 attribute:firstOrthogonalAttribute
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:view
                                                                                 attribute:firstOrthogonalAttribute
                                                                                multiplier:1
                                                                                  constant:0];
    NSLayoutConstraint *secondOrthogonalConstraint = [NSLayoutConstraint constraintWithItem:column
                                                                                  attribute:secondOrthogonalAttribute
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:view
                                                                                  attribute:secondOrthogonalAttribute
                                                                                 multiplier:1
                                                                                   constant:0];
    [column addConstraint:firstOrthogonalConstraint];
    [column addConstraint:secondOrthogonalConstraint];
    
    //last items constraints
    if(self.numberOfColumns < (total - index)) {
        return;
    }
    
    NSLayoutAttribute lastAttribute;
    if (self.compositionMode == SOTGridCompositionModeVertical) {
        lastAttribute = NSLayoutAttributeBottom;
    
    } else {
        lastAttribute = NSLayoutAttributeTrailing;
    }
    
    NSLayoutConstraint *lastEqualConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                           attribute:lastAttribute
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:column
                                                                           attribute:lastAttribute
                                                                          multiplier:1
                                                                            constant:0];
    [lastEqualConstraint setPriority:250];
    [column addConstraint:lastEqualConstraint];
    
    NSLayoutConstraint *lastGreaterOrEqualConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                                    attribute:lastAttribute
                                                                                    relatedBy:NSLayoutRelationLessThanOrEqual
                                                                                       toItem:column
                                                                                    attribute:lastAttribute
                                                                                   multiplier:1
                                                                                     constant:0];
    [column addConstraint:lastGreaterOrEqualConstraint];
}

- (void) didSelectItem:(SOTGridItem *)item {
    NSInteger index = [self.items indexOfObject:item];
    
    if(index != NSNotFound) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(gridView:didSelectItemAtIndex:)]) {
            [self.delegate gridView:self didSelectItemAtIndex:index];
        }
    }
}

#pragma mark - getter/setter

- (void) setNumberOfColumns:(NSInteger)numberOfColumns {
    if(_numberOfColumns == numberOfColumns) {
        return;
    }
    
    _numberOfColumns = numberOfColumns;
    [self reloadContents];
}

- (void) setContentMargins:(UIEdgeInsets)contentMargins {
    if(UIEdgeInsetsEqualToEdgeInsets(_contentMargins, contentMargins)) {
        return;
    }
    
    _contentMargins = contentMargins;
    [self reloadContents];
}

- (void) setDataSource:(NSObject<SOTGridViewDataSource> *)dataSource {
    if(_dataSource == dataSource) {
        return;
    }
    
    _dataSource = dataSource;
    [self reloadContents];
}

#pragma mark - Public Methods

- (void) reloadContents {
    
    if(!self.dataSource) {
        return;
    }
    
    //Preare Columns
    [self setupColumns];
    
    //Insert contents
    NSInteger items = [self.dataSource numberOfItemsInGridView:self];
    
    for (NSInteger index = 0; index < items; index++) {
        [self insertItemAtIndex:index ofTotal:items];
    }
}

- (void) deselectItemAtIndex:(NSInteger)index {
    
    if(index < 0 || index >= self.items.count) {
        return;
    }
    
    SOTGridItem *item = [self.items objectAtIndex:index];
    [item setSelected:NO];
}

- (void) selectItemAtIndex:(NSInteger)index {
    
    if(index < 0 || index >= self.items.count) {
        return;
    }
    
    SOTGridItem *item = [self.items objectAtIndex:index];
    [item setSelected:YES];
}

#pragma mark - Utils

- (UIUserInterfaceLayoutDirection) interfaceLayoutDirection {
    return [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.semanticContentAttribute];
}

@end
