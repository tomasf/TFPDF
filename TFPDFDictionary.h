//
//  CGPDFDictionary.h
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-13.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TFPDFDictionary : NSObject <NSFastEnumeration> {
	CGPDFDictionaryRef dictionary;
}

@property(readonly) CGPDFDictionaryRef CGPDFDictionary;

- (id)initWithCGPDFDictionary:(CGPDFDictionaryRef)dict;

- (id)objectForKey:(NSString*)key;
- (id)objectForKey:(NSString*)key requiredClass:(Class)class;
- (NSArray*)allKeys;
@end