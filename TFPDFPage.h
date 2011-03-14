//
//  TFPDFPage.h
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-13.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TFPDFDocument, TFPDFDictionary;

@interface TFPDFPage : NSObject {
	CGPDFPageRef page;
}

- (id)initWithCGPDFPage:(CGPDFPageRef)CGPage;

@property(readonly) CGPDFPageRef CGPDFPage;

@property(readonly) TFPDFDocument *document;
@property(readonly) TFPDFDictionary *dictionary;
@property(readonly) NSUInteger pageNumber;
@property(readonly) NSInteger rotationAngle; // Degrees

- (CGRect)rectForBox:(CGPDFBox)boxType;
- (CGAffineTransform)drawingTransformForBox:(CGPDFBox)boxType rect:(CGRect)rect rotationAngle:(NSInteger)degrees preserveAspectRatio:(BOOL)preserve;
- (void)drawInContext:(CGContextRef)context;
@end