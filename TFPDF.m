//
//  TFPDF.m
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-13.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import "TFPDF.h"

id TFPDFObjectFromCGPDFObject(CGPDFObjectRef source) {
	CGPDFObjectType type = CGPDFObjectGetType(source);
	void *pointer;
	CGPDFBoolean boolean;
	CGPDFInteger integer;
	CGPDFReal real;
	
	switch(type) {
		case kCGPDFObjectTypeNull: return [NSNull null];
			
		case kCGPDFObjectTypeDictionary:
			CGPDFObjectGetValue(source, type, &pointer);
			return [[[TFPDFDictionary alloc] initWithCGPDFDictionary:(CGPDFDictionaryRef)pointer] autorelease];
			
		case kCGPDFObjectTypeArray:
			CGPDFObjectGetValue(source, type, &pointer);
			return [[[TFPDFArray alloc] initWithCGPDFArray:(CGPDFArrayRef)pointer] autorelease];
			
		case kCGPDFObjectTypeStream:
			CGPDFObjectGetValue(source, type, &pointer);
			return [[[TFPDFStream alloc] initWithCGPDFStream:(CGPDFStreamRef)pointer] autorelease];
			
		case kCGPDFObjectTypeBoolean:
			CGPDFObjectGetValue(source, type, &boolean);
			return [NSNumber numberWithBool:boolean];
			
		case kCGPDFObjectTypeInteger: 
			CGPDFObjectGetValue(source, type, &integer);
			return [NSNumber numberWithLong:integer];
			
		case kCGPDFObjectTypeReal:
			CGPDFObjectGetValue(source, type, &real);
			return [NSNumber numberWithDouble:real];
			
		case kCGPDFObjectTypeName:
			CGPDFObjectGetValue(source, type, &pointer);
			return [NSString stringWithUTF8String:(char*)pointer];
			
		case kCGPDFObjectTypeString:
			CGPDFObjectGetValue(source, type, &pointer);
			return [(id)CGPDFStringCopyTextString((CGPDFStringRef)pointer) autorelease];
	}
	return nil;
}