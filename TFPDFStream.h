//
//  TFPDFStream.h
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-14.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TFPDFDictionary;

@interface TFPDFStream : NSObject {
	CGPDFStreamRef stream;
}

- (id)initWithCGPDFStream:(CGPDFStreamRef)source;

@property(readonly) CGPDFStreamRef CGPDFStream;
@property(readonly) NSData *data;
@property(readonly) CGPDFDataFormat format;
@property(readonly) TFPDFDictionary *dictionary;

@end
