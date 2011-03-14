//
//  TFPDFDocument.m
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-13.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import "TFPDFDocument.h"
#import "TFPDFPage.h"

@implementation TFPDFDocument

- (id)initWithCGPDFDocument:(CGPDFDocumentRef)doc {
	self = [super init];
	document = CGPDFDocumentRetain(doc);
	return self;
}


- (id)initWithDataProvider:(CGDataProviderRef)provider {
	CGPDFDocumentRef doc = CGPDFDocumentCreateWithProvider(provider);
	if(!doc) {
		[self release];
		return nil;
	}
	self = [self initWithCGPDFDocument:doc];
	CGPDFDocumentRelease(doc);
	return self;
}


- (id)initWithContentsOfURL:(NSURL*)URL {
	CGDataProviderRef provider = CGDataProviderCreateWithURL((CFURLRef)URL);
	self = [self initWithDataProvider:provider];
	CFRelease(provider);
	return self;
}


- (id)initWithData:(NSData*)data {
	CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
	self = [self initWithDataProvider:provider];
	CFRelease(provider);
	return self;
}


- (void)dealloc {
	CGPDFDocumentRelease(document);
	[super dealloc];
}


- (TFPDFPage*)pageAtIndex:(NSUInteger)index {
	CGPDFPageRef page = CGPDFDocumentGetPage(document, index);
	return [[[TFPDFPage alloc] initWithCGPDFPage:page] autorelease];
}


- (BOOL)unlockWithPassword:(NSString*)password {
	return CGPDFDocumentUnlockWithPassword(document, [password UTF8String]);
}


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	if(state->state == 0)
		state->mutationsPtr = state->extra;
		
	if(state->state >= self.pageCount)
		return 0;
	
	stackbuf[0] = [self pageAtIndex:state->state+1];
	state->itemsPtr = stackbuf;
	state->state++;
	return 1;
}


#pragma mark Properties

- (BOOL)allowsCopying {
	return CGPDFDocumentAllowsCopying(document);
}

- (BOOL)allowsPrinting {
	return CGPDFDocumentAllowsPrinting(document);
}

- (BOOL)isEncrypted {
	return CGPDFDocumentIsEncrypted(document);
}

- (BOOL)isUnlocked {
	return CGPDFDocumentIsUnlocked(document);
}

- (NSUInteger)pageCount {
	return CGPDFDocumentGetNumberOfPages(document);
}

@end