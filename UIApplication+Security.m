#import <Security/Security.h>
#import "UIApplication+Security.h"

@implementation UIApplication (Security)

static NSString *serviceName = @"com.mycompany.myAppServiceName";

+ (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];  
	
    [searchDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(id)kSecAttrService];
	
    return searchDictionary; 
}

+ (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[self class] newSearchDictionary:identifier];
	
    // Add search attributes
    [searchDictionary setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
	
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	
    NSData *result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)searchDictionary,
                                          (CFTypeRef *)&result);
	
    [searchDictionary release];
    return result;
}

+ (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [[self class] newSearchDictionary:identifier];
    
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(id)kSecValueData];
	
    OSStatus status = SecItemAdd((CFDictionaryRef)dictionary, NULL);
    [dictionary release];
	
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

+ (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *searchDictionary = [[self class] newSearchDictionary:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(id)kSecValueData];
	
    OSStatus status = SecItemUpdate((CFDictionaryRef)searchDictionary,
                                    (CFDictionaryRef)updateDictionary);
    
    [searchDictionary release];
    [updateDictionary release];
	
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

+ (void)deleteKeychainValue:(NSString *)identifier {
	
    NSMutableDictionary *searchDictionary = [[self class] newSearchDictionary:identifier];
    SecItemDelete((CFDictionaryRef)searchDictionary);
    [searchDictionary release];
}

@end

