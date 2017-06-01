//
//  SOTViewController.m
//  GridView
//
//  Created by acct<blob>=<NULL> on 06/01/2017.
//  Copyright (c) 2017 acct<blob>=<NULL>. All rights reserved.
//

#import "SOTViewController.h"
#import "SOTDetailViewController.h"

#import "SOTGridView.h"
#import "SOTCustomItem.h"

@interface SOTViewController () <SOTGridViewDataSource, SOTGridViewDelegate>

@property (weak, nonatomic) IBOutlet SOTGridView *gridView;

@end

@implementation SOTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.gridView setContentMargins:UIEdgeInsetsMake(20, 10, 20, 10)];
    [self.gridView setDataSource:self];
    [self.gridView setDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reload:(id)sender {
    [self.gridView reloadContents];
}


- (NSInteger)numberOfItemsInGridView:(SOTGridView *)gridView {
    return 45;
}

- (SOTGridItem *_Nonnull) gridView:(SOTGridView *_Nonnull)gridView viewAtIndex:(NSInteger)index {
    
    SOTCustomItem *view = (SOTCustomItem *)[[[NSBundle mainBundle] loadNibNamed:@"SOTCustomItem" owner:self options:nil] firstObject];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:((index % 5) * 10 + 80)];
    
    [view addConstraint:heightConstraint];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    return view;
}

- (void) gridView:(SOTGridView *)gridView didSelectItemAtIndex:(NSInteger)index {
    
    [self performSegueWithIdentifier:@"ShowDetail" sender:[NSNumber numberWithInteger:index]];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        SOTDetailViewController *detailController = (SOTDetailViewController *)segue.destinationViewController;
        if(detailController.view) {
            [detailController.detailLabel setText:[NSString stringWithFormat:@"%i", [(NSNumber *)sender intValue]]];
        }
    }
}

@end
