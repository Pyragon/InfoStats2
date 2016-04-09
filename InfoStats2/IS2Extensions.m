//
//  IS2Private.m
//  InfoStats2
//
//  Created by Matt Clarke on 01/06/2015.
//

#import "IS2Extensions.h"
#import "IS2WeatherProvider.h"

@interface IS2Calendar : NSObject
+(void)setupAfterTweakLoad;
@end

@interface IS2System : NSObject
+(void)setupAfterTweakLoaded;
@end

@interface IS2Notifications : NSObject
+(void)setupAfterTweakLoaded;
+(void)setupAfterSpringBoardLaunched;
@end

@interface IS2Location : NSObject
+(void)setupAfterTweakLoaded;
@end

static NSBundle *bundle; // strings bundle.
static IS2Private *instance;

@implementation IS2Private

#pragma mark Internal

+(NSBundle*)stringsBundle {
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:@"/Library/Application Support/InfoStats2/Localisable.bundle"];
    }
    
    return bundle;
}

+(void)setupForTweakLoaded {
    [[IS2WeatherProvider sharedInstance] setupForTweakLoaded];
    [IS2Calendar setupAfterTweakLoad];
    [IS2Notifications setupAfterTweakLoaded];
    [IS2Location setupAfterTweakLoaded];
    [IS2System setupAfterTweakLoaded];
}

+(void)setupAfterSpringBoardLoaded {
    [IS2Notifications setupAfterSpringBoardLaunched];
}

+(NSString*)JSONescapedStringForString:(NSString*)input {
    NSMutableString *s = [NSMutableString stringWithString:input];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

+(instancetype)sharedInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        instance = [[self alloc] init];
    });
    
    // returns the same object each time
    return instance;
}

-(void)performBlockOnMainThread:(void (^)(void))callbackBlock {
    callbackBlock();
}

@end
