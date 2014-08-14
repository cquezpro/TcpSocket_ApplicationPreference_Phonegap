//
//  applicationPreferences.m
//
//
//  Created by Tue Topholm on 31/01/11.
//  Copyright 2011 Sugee. All rights reserved.
//
// THIS HAVEN'T BEEN TESTED WITH CHILD PANELS YET.

#import "AGApplicationPreferences.h"


@implementation AGApplicationPreferences



- (void)getSetting:(CDVInvokedUrlCommand*)command
{
    NSString* callbackID = command.callbackId;
	NSString* jsString;
    
    NSDictionary *options   = [command.arguments objectAtIndex:0];
    NSString *settingsName = [options objectForKey:@"key"];
    CDVPluginResult* result = nil;
	
    @try
    {
        //At the moment we only return strings
        //bool: true = 1, false=0
        NSString *returnVar = [[NSUserDefaults standardUserDefaults] stringForKey:settingsName];
        if(returnVar == nil)
        {
            returnVar = [self getSettingFromBundle:settingsName]; //Parsing Root.plist
            
            if (returnVar == nil)
                @throw [NSException exceptionWithName:nil reason:@"Key not found" userInfo:nil];;
        }
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnVar];
        jsString = [result toSuccessCallbackString:callbackID];
    }
    @catch (NSException * e)
    {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:[e reason]];
        jsString = [result toErrorCallbackString:callbackID];
    }
    @finally
    {
        [self writeJavascript:jsString]; //Write back to JS
    }
}

- (void)setSetting:(CDVInvokedUrlCommand*)command
{
    NSString* callbackID = command.callbackId;
	NSString* jsString;
    CDVPluginResult* result;
    
    NSDictionary *options   = [command.arguments objectAtIndex:0];
    NSString *settingsName = [options objectForKey:@"key"];
    NSString *settingsValue = [options objectForKey:@"value"];
    
    
    @try
    {
        [[NSUserDefaults standardUserDefaults] setValue:settingsValue forKey:settingsName];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        jsString = [result toSuccessCallbackString:callbackID];
        
    }
    @catch (NSException * e)
    {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:[e reason]];
        jsString = [result toErrorCallbackString:callbackID];
    }
    @finally
    {
        [self writeJavascript:jsString]; //Write back to JS
    }
}
/*
 Parsing the Root.plist for the key, because there is a bug/feature in Settings.bundle
 So if the user haven't entered the Settings for the app, the default values aren't accessible through NSUserDefaults.
 */


- (NSString*)getSettingFromBundle:(NSString*)settingsName
{
	NSString *pathStr = [[NSBundle mainBundle] bundlePath];
	NSString *settingsBundlePath = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
	NSString *finalPath = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
	
	NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
	NSArray *prefSpecifierArray = [settingsDict objectForKey:@"PreferenceSpecifiers"];
	NSDictionary *prefItem;
	for (prefItem in prefSpecifierArray)
	{
        
        NSString* strName = [prefItem objectForKey:@"Title"];
        NSLog(@"%@", strName);
		if ([[prefItem objectForKey:@"Title"] isEqualToString:settingsName])
			return [prefItem objectForKey:@"Value"];
	}
	return nil;
	
}
@end