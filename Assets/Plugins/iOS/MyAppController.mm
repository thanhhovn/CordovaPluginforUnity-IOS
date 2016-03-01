#import <UIKit/UIKit.h>
#import "UnityAppController.h"
#import "UI/UnityView.h"
#import "Cordova/CDVViewController.h"
extern UIViewController *UnityGetGLViewController();
@interface MyAppController : UnityAppController
{
	UINavigationController*		_navController;
	UIViewController*			_embedController1;
	UIViewController*			_embedController2;
}
- (void)createViewHierarchyImpl;
@end

@implementation MyAppController
- (void)createViewHierarchyImpl;
{
NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
NSString* streamingAssetsPathwww = [NSString stringWithFormat:@"%@/Data/Raw/www/", bundlePath];
NSString* streamingAssetsPathindex = [NSString stringWithFormat:@"%@index.html", streamingAssetsPathwww];
	NSString* path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"xml"];
	NSString* myvar = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
	NSLog(@"%@", myvar);
	NSLog(@"%@", streamingAssetsPathindex);
	NSString* myvarb = @"bbbbbbbbbbbbbbbbbbbbbbbbb";
	NSLog(@"%@", myvarb);
	_rootController	= [[UIViewController alloc] init];
	_rootView		= [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	_embedController1 = [[UIViewController alloc] init];
	_embedController1.view = _unityView;
	_embedController1.navigationItem.rightBarButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStyleBordered target:self action:@selector(moveRight:)];

	_embedController2 = [[UIViewController alloc] init];
	CDVViewController* viewController = [CDVViewController new];
	viewController.view.frame = CGRectMake(0, 0, 320, 480);
	//viewController.wwwFolderName = streamingAssetsPathwww;
	//viewController.startPage = streamingAssetsPathindex;
	//viewController.useSplashScreen = YES;	
	
	//[rootViewController.view addSubview:viewController.view];
	//_embedController2.view = viewController.view;
	
	_embedController2.navigationItem.leftBarButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStyleBordered target:self action:@selector(moveLeft:)];

	_embedController2.view = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[(UIWebView*)_embedController2.view loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.unity3d.com"]]];
	
	_rootController.view = _rootView;

	_navController = [[UINavigationController alloc] initWithRootViewController:_embedController1];
	//[_rootView addSubview:_navController.view];
	[_rootView addSubview:viewController.view];
}
- (void)moveRight:(id)sender
{
	[_navController pushViewController:_embedController2 animated:NO];
}
- (void)moveLeft:(id)sender
{
	[_navController popViewControllerAnimated:NO];
}

@end

IMPL_APP_CONTROLLER_SUBCLASS(MyAppController)

