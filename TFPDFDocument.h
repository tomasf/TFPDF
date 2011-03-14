//
//  TFPDFDocument.h
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-13.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TFPDFPage;

@interface TFPDFDocument : NSObject <NSFastEnumeration> {
	CGPDFDocumentRef document;
}

@property(readonly) BOOL allowsCopying;
@property(readonly) BOOL allowsPrinting;
@property(readonly, getter=isEncrypted) BOOL encrypted;
@property(readonly, getter=isUnlocked) BOOL unlocked;
@property(readonly) NSUInteger pageCount;

- (id)initWithContentsOfURL:(NSURL*)URL;
- (id)initWithData:(NSData*)data;
- (id)initWithCGPDFDocument:(CGPDFDocumentRef)doc;

- (TFPDFPage*)pageAtIndex:(NSUInteger)index; // 1-based

- (BOOL)unlockWithPassword:(NSString*)password;
@end