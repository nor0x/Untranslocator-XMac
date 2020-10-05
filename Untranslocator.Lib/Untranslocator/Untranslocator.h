//
//  Untranslocator.h
//  Untranslocator
//
//  Created by Joachim Leonfellner on 05.10.20.
//

#import <Foundation/Foundation.h>

@interface Untranslocator : NSObject

- (NSString *)resolveTranslocatedPath: (NSString *)path;

@end
