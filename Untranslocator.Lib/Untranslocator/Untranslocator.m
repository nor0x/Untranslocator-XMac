//
//  Untranslocator.m
//  Untranslocator
//
//  Created by Joachim Leonfellner on 05.10.20.
//

#import "Untranslocator.h"
#import <Cocoa/Cocoa.h>
#include <dlfcn.h>

@implementation Untranslocator


- (NSString *)resolveTranslocatedPath: (NSString *)path
{

    // macOS < 10.12
    if (floor(NSAppKitVersionNumber) <= 1404)
        return path;

    void *handle = dlopen("/System/Library/Frameworks/Security.framework/Security", RTLD_LAZY);

    // Failed to load security framework
    if (handle == NULL)
        return path;

    Boolean (*mySecTranslocateIsTranslocatedURL)(CFURLRef path, bool *isTranslocated, CFErrorRef * __nullable error);
    mySecTranslocateIsTranslocatedURL = dlsym(handle, "SecTranslocateIsTranslocatedURL");

    CFURLRef __nullable (*mySecTranslocateCreateOriginalPathForURL)(CFURLRef translocatedPath, CFErrorRef * __nullable error);
    mySecTranslocateCreateOriginalPathForURL = dlsym(handle, "SecTranslocateCreateOriginalPathForURL");

    // Failed to resolve required functions
    if (mySecTranslocateIsTranslocatedURL == NULL || mySecTranslocateCreateOriginalPathForURL == NULL)
        return path;

    bool isTranslocated = false;
    CFURLRef pathURLRef = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (__bridge CFStringRef)path, kCFURLPOSIXPathStyle, false);

    if (mySecTranslocateIsTranslocatedURL(pathURLRef, &isTranslocated, NULL))
    {
        if (isTranslocated)
        {
            CFURLRef resolvedURL = mySecTranslocateCreateOriginalPathForURL(pathURLRef, NULL);
            path = [(__bridge NSURL *)(resolvedURL) path];
        }
    }

    CFRelease(pathURLRef);
    return path;
}

@end
