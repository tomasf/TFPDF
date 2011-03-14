//
//  TFPDFArray.h
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-14.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TFPDFArray : NSObject <NSFastEnumeration> {
	CGPDFArrayRef array;
}

@property(readonly) CGPDFArrayRef CGPDFArray;
@property(readonly) NSUInteger count;

- (id)initWithCGPDFArray:(CGPDFArrayRef)source;
- (id)objectAtIndex:(NSUInteger)index;
@end