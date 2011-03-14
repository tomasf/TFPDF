//
//  TFPDFStream.m
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-14.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import "TFPDFStream.h"
#import "TFPDF.h"

@implementation TFPDFStream
@synthesize CGPDFStream=stream;

- (id)initWithCGPDFStream:(CGPDFStreamRef)source {
	self = [super init];
	stream = source;
	return self;
}

- (NSData*)data {
	CGPDFDataFormat format;
	return [NSMakeCollectable(CGPDFStreamCopyData(stream, &format)) autorelease];
}

- (CGPDFDataFormat)format {
	CGPDFDataFormat format;
	CFRelease(CGPDFStreamCopyData(stream, &format));
	return format;
}

- (TFPDFDictionary*)dictionary {
	return [[[TFPDFDictionary alloc] initWithCGPDFDictionary:CGPDFStreamGetDictionary(stream)] autorelease];
}

- (BOOL)isEqual:(id)object {
	return [object isKindOfClass:[TFPDFStream class]] && [object CGPDFStream] == [self CGPDFStream];
}

- (NSUInteger)hash {
	return (NSUInteger)[self CGPDFStream];
}

@end