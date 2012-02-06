#import <Foundation/Foundation.h>

@interface UIApplication (Security)

+ (void)deleteKeychainValue:(NSString *)identifier;
+ (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier;
+ (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier;
+ (NSData *)searchKeychainCopyMatching:(NSString *)identifier;
+ (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier;

@end

