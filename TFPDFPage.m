//
//  TFPDFPage.m
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-13.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import "TFPDFPage.h"
#import "TFPDF.h"

@implementation TFPDFPage
@synthesize CGPDFPage=page;

- (id)initWithCGPDFPage:(CGPDFPageRef)CGPage {
	self = [super init];
	page = CGPDFPageRetain(CGPage);
	return self;
}

- (void)dealloc {
	CGPDFPageRelease(page);
	[super dealloc];
}

- (CGRect)rectForBox:(CGPDFBox)boxType {
	return CGPDFPageGetBoxRect(page, boxType);
}

- (CGAffineTransform)drawingTransformForBox:(CGPDFBox)boxType rect:(CGRect)rect rotationAngle:(NSInteger)degrees preserveAspectRatio:(BOOL)preserve {
	return CGPDFPageGetDrawingTransform(page, boxType, rect, degrees, preserve);
}

- (void)drawInContext:(CGContextRef)context {
	CGContextDrawPDFPage(context, page);
}

- (BOOL)isEqual:(id)object {
	return [object isKindOfClass:[TFPDFPage class]] && [object CGPDFPage] == [self CGPDFPage];
}

- (NSUInteger)hash {
	return (NSUInteger)[self CGPDFPage];
}

#pragma mark Properties

- (TFPDFDocument*)document {
	return [[[TFPDFDocument alloc] initWithCGPDFDocument:CGPDFPageGetDocument(page)] autorelease];
}

- (NSUInteger)pageNumber {
	return CGPDFPageGetPageNumber(page);
}

- (NSInteger)rotationAngle {
	return CGPDFPageGetRotationAngle(page);	
}

- (TFPDFDictionary*)dictionary {
	return [[[TFPDFDictionary alloc] initWithCGPDFDictionary:CGPDFPageGetDictionary(page)] autorelease];
}

@end