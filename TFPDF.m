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
	void *value = NULL;
	CGPDFObjectGetValue(source, type, &value);
	
	switch(type) {
		case kCGPDFObjectTypeDictionary: return [[[TFPDFDictionary alloc] initWithCGPDFDictionary:(CGPDFDictionaryRef)value] autorelease];
		case kCGPDFObjectTypeArray: return [[[TFPDFArray alloc] initWithCGPDFArray:(CGPDFArrayRef)value] autorelease];
		case kCGPDFObjectTypeStream: return [[[TFPDFStream alloc] initWithCGPDFStream:(CGPDFStreamRef)value] autorelease];
		case kCGPDFObjectTypeNull: return [NSNull null];
		case kCGPDFObjectTypeBoolean: return [NSNumber numberWithBool:*(CGPDFBoolean*)value];
		case kCGPDFObjectTypeInteger: return [NSNumber numberWithInteger:*(CGPDFInteger*)value];
		case kCGPDFObjectTypeReal: return [NSNumber numberWithDouble:*(CGPDFReal*)value];
		case kCGPDFObjectTypeName: return [NSString stringWithUTF8String:(char*)value];
		case kCGPDFObjectTypeString: return [(id)CGPDFStringCopyTextString((CGPDFStringRef)value) autorelease];
	}
	return nil;
}