//
//  TFPDFArray.m
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-14.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import "TFPDFArray.h"
#import "TFPDF.h"

@implementation TFPDFArray
@synthesize CGPDFArray=array;


- (id)initWithCGPDFArray:(CGPDFArrayRef)source {
	self = [super init];
	array = source;
	return self;
}

- (NSUInteger)count {
	return CGPDFArrayGetCount(array);
}

- (id)objectAtIndex:(NSUInteger)index {
	CGPDFObjectRef object;
	if(!CGPDFArrayGetObject(array, index, &object))
		return nil;
	return TFPDFObjectFromCGPDFObject(object);
}


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	if(state->state == 0)
		state->mutationsPtr = state->extra;
	
	if(state->state >= self.count)
		return 0;
	
	stackbuf[0] = [self objectAtIndex:state->state];
	state->itemsPtr = stackbuf;
	state->state++;
	return 1;
}

- (BOOL)isEqual:(id)object {
	return [object isKindOfClass:[TFPDFArray class]] && [object CGPDFArray] == [self CGPDFArray];
}

- (NSUInteger)hash {
	return (NSUInteger)[self CGPDFArray];
}

@end