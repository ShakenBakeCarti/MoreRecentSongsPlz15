#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MRSPLog(fmt, ...) NSLog(@"[MoreRecentSongsPlz] " fmt, ##__VA_ARGS__)

static const NSInteger kUnlimitedLimit = 100000;

%hook MusicLibraryRecentlyAddedSectionController
- (NSInteger)maximumNumberOfItems {
    MRSPLog(@"maximumNumberOfItems hooked -> %ld", (long)kUnlimitedLimit);
    return kUnlimitedLimit;
}
- (NSUInteger)numberOfItemsToFetch {
    return (NSUInteger)kUnlimitedLimit;
}
%end

%hook MusicRecentlyAddedSectionController
- (NSInteger)maximumNumberOfItems { return kUnlimitedLimit; }
- (NSUInteger)numberOfItemsToFetch { return (NSUInteger)kUnlimitedLimit; }
%end

%hook MLRecentlyAddedFetchRequest
- (NSUInteger)fetchLimit { return (NSUInteger)kUnlimitedLimit; }
- (void)setFetchLimit:(NSUInteger)limit { %orig(kUnlimitedLimit); }
%end

%hook ML3RecentlyAddedQuery
- (NSUInteger)limit { return (NSUInteger)kUnlimitedLimit; }
%end

%hook NSFetchRequest
- (NSUInteger)fetchLimit {
    NSUInteger original = %orig;
    NSString *entityName = [self entityName];
    if (entityName &&
        ([entityName containsString:@"RecentlyAdded"] ||
         [entityName containsString:@"Recent"]) &&
        original > 0 && original < 1000) {
        return (NSUInteger)kUnlimitedLimit;
    }
    return original;
}
%end

%ctor {
    @autoreleasepool {
        MRSPLog(@"MoreRecentSongsPlz iOS 15 loaded into %@",
                [[NSBundle mainBundle] bundleIdentifier]);
    }
}
