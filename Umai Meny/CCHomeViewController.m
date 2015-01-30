//
//  CCHomeViewController.m
//  Umai Meny
//
//  Created by Caleb on 07/06/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCHomeViewController.h"
#import "SWRevealViewController.h"

@interface CCHomeViewController ()
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)changePageControl:(UIPageControl *)sender;

//@property (strong, nonatomic) NSTimer *imageRotateTimer;
@property (strong, nonatomic) NSMutableArray *homeImages;


@end

@implementation CCHomeViewController

#pragma mark - Lazy Instantiation
-(NSMutableArray *)homeImages
{
    if (!_homeImages) {
        _homeImages = [[NSMutableArray alloc] init];
    }
    return _homeImages;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addHomeImages];

    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.numberOfPages = 5;

//    self.imageRotateTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(turnPageAutomation) userInfo:nil repeats:YES];
    
    //Change bar button color
    self.sideBarButton.tintColor = [UIColor redColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar
    self.sideBarButton.target = self.revealViewController;
    self.sideBarButton.action = @selector(revealToggle:);
    
    
    for (int i=0; i < self.homeImages.count; i++) {
        
        CGFloat xOrigin = i * self.view.frame.size.width;
//        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];

        image.image = [self.homeImages objectAtIndex:i];
        [self.scrollView addSubview:image];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.homeImages.count, self.scrollView.frame.size.height);
    
    self.automaticallyAdjustsScrollViewInsets = NO; // disable vertical scroll in UISCrollView
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    // arrange the CAlayer hierarchy by using zPosition
    self.scrollView.layer.zPosition = 100;
    self.pageControl.layer.zPosition = 110;
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        // code for 4-inch screen
        NSLog(@"iPhone 5");
    } else if (screenBounds.size.height == 480){
        // code for 3.5-inch screen
        NSLog(@"iPhone 4S");
        CGFloat midX = CGRectGetMidX(screenBounds);
        self.pageControl.frame = CGRectMake(midX-50, 440, 100, 2);
        
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIScrollView Delegate

// it let's us know that the user has scrolled the content view inside the scroll view
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    // floor function as a float to an integer
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth)+1;
    
    self.pageControl.currentPage = page;
}




#pragma mark - Helper methods

-(void) addHomeImages
{
    for (int i = 1; i < 6 ; i++ ) {
        NSString *string = [NSString stringWithFormat:@"promotion%d.jpg", i];
        UIImage *homeImage = [UIImage imageNamed:string];
        [self.homeImages addObject:homeImage];
    }
}


- (IBAction)changePageControl:(UIPageControl *)sender {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
@end



