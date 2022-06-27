// For FairBid SDK Header Bidding Rewarded integration, simply just follow FairBid's documentation.
// FairBid Header Bidding HyBid Adapters that you've added to the project, will do all the work.
// You don't have to write any HyBid related code for this integration.

#import "RewardedViewController.h"
#import <FairBidSDK/FairBidSDK.h>

#define REWARDED_AD_UNIT_ID @"704851"

@interface RewardedViewController () <FYBRewardedDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@end

@implementation RewardedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"FairBid Header Bidding Rewarded";
    [self.activityIndicator stopAnimating];
}

- (IBAction)loadAdTouchUpInside:(id)sender {
    [self.activityIndicator startAnimating];
    self.showAdButton.hidden = YES;
    FYBRewarded.delegate = self;
    [FYBRewarded request:REWARDED_AD_UNIT_ID];
}

- (IBAction)showAdTouchUpInside:(UIButton *)sender {
    if ([FYBRewarded isAvailable:REWARDED_AD_UNIT_ID]) {
        [FYBRewarded show:REWARDED_AD_UNIT_ID];
    } else {
        NSLog(@"Ad wasn't ready");
    }
}

#pragma mark - FYBRewardedDelegate

- (void)rewardedIsAvailable:(NSString *)placementId {
    self.showAdButton.hidden = NO;
    [self.activityIndicator stopAnimating];
}
 
- (void)rewardedIsUnavailable:(NSString *)placementId {
    NSLog(@"rewardedIsUnavailable");
    [self.activityIndicator stopAnimating];
}
 
- (void)rewardedDidShow:(NSString *)placementId impressionData:(FYBImpressionData *)impressionData {
    NSLog(@"rewardedDidShow");
}
 
- (void)rewardedDidFailToShow:(NSString *)placementId withError:(NSError *)error impressionData:(FYBImpressionData *)impressionData {
    [self.activityIndicator stopAnimating];
    NSLog(@"FairBid Rewarded did fail to show with message: %@", [error localizedDescription]);

}
 
- (void)rewardedDidClick:(NSString *)placementId {
    NSLog(@"rewardedDidClick");
}
 
- (void)rewardedDidDismiss:(NSString *)placementId {
    NSLog(@"rewardedDidDismiss");
    self.showAdButton.hidden = YES;
}
 
- (void)rewardedDidComplete:(NSString *)placementId userRewarded:(BOOL)userRewarded {
    NSLog(@"rewardedDidComplete");
}

- (void)rewardedWillRequest:(NSString *)placementId {
    NSLog(@"rewardedWillRequest");
}

@end
