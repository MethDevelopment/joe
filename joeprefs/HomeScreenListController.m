#import "HomeScreenListController.h"
#import <Foundation/Foundation.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>

@interface NSTask : NSObject
@property NSString *launchPath;
- (void)launch;
@end

@implementation HomeScreenListController
- (NSMutableArray *)specifiers {
    if (_specifiers == nil) {
        _specifiers = [self loadSpecifiersFromPlistName:@"HomeScreenListController" target:self];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(didTapRespring)];
        self.navigationItem.rightBarButtonItem = item;
    }
    return _specifiers;
}

- (void)didTapRespring {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/sbreload";
    [task launch];
}
@end