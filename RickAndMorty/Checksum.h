//
//  Checksum.h
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 23/09/22.
//

#ifndef Checksum_h
#define Checksum_h
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Checksum : NSObject
+(NSString *) sha1: (NSString *)input;
+(NSString *) sha256: (NSString *)input;
@end
#endif /* Checksum_h */
