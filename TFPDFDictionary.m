//
//  CGPDFDictionary.m
//  TFPDF
//
//  Created by Tomas Franzén on 2011-03-13.
//  Copyright 2011 Lighthead Software. All rights reserved.
//

#import "TFPDFDictionary.h"
#import "TFPDF.h"

static void KeyApplier(const char *key, CGPDFObjectRef object, void *info) {
	NSString *keyString = [NSString stringWithUTF8String:key];
	if(!keyString) return;
	[(NSMutableArray*)info addObject:keyString];
}


@implementation TFPDFDictionary
@synthesize CGPDFDictionary=dictionary;

- (id)initWithCGPDFDictionary:(CGPDFDictionaryRef)dict {
	self = [super init];
	dictionary = dict;
	return self;
}

- (id)objectForKey:(NSString*)key {
	CGPDFObjectRef value;
	if(!CGPDFDictionaryGetObject(dictionary, [key UTF8String], &value))
		return nil;
	return TFPDFObjectFromCGPDFObject(value);
}

- (id)objectForKey:(NSString*)key requiredClass:(Class)class {
	id obj = [self objectForKey:key];
	return [obj isKindOfClass:class] ? obj : nil;
}

- (NSArray*)allKeys {
	NSMutableArray *keys = [NSMutableArray array];
	CGPDFDictionaryApplyFunction(dictionary, KeyApplier, keys);
	return keys;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	if(state->state == 0) {
		state->mutationsPtr = state->extra;
		state->extra[0] = (long)[self allKeys]; // This probably breaks if you drain a pool in the loop. :-/
	}
	
	NSArray *keys = (id)state->extra[0];
	NSUInteger num = MIN(len, [keys count] - state->state);
	
	[keys getObjects:stackbuf range:NSMakeRange(state->state, num)];
	state->state += num;
	state->itemsPtr = stackbuf;
	return num;
}

- (BOOL)isEqual:(id)object {
	return [object isKindOfClass:[TFPDFDictionary class]] && [object CGPDFDictionary] == [self CGPDFDictionary];
}

- (NSUInteger)hash {
	return (NSUInteger)[self CGPDFDictionary];
}


@end
