//
//  HomeModel.m
//  fyp_Resturant
//
//  Created by leung yan chui on 14/5/14.
//  Copyright (c) 2014年 leung yan chui. All rights reserved.
//

#import "HomeModel.h"
#import "Tattoo_Master_Info.h"
@interface HomeModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation HomeModel

- (void)downloadItems
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"https://localhost:443/phpmyadmin/json/Tattoo_Master.php"];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_Tattoo_Master = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        Tattoo_Master_Info *Tattoo_Master = [[Tattoo_Master_Info alloc] init];
        
        Tattoo_Master.master_id = jsonElement[@"master_id"];
        Tattoo_Master.name = jsonElement[@"Name"];
        Tattoo_Master.gender = jsonElement[@"Gender"];
        Tattoo_Master.tel = jsonElement[@"Tel"];
         Tattoo_Master.email = jsonElement[@"Email"];
        Tattoo_Master.address = jsonElement[@"Address"];
          Tattoo_Master.latitude = jsonElement[@"Latitude"];
          Tattoo_Master.longitude = jsonElement[@"Longitude"];
        Tattoo_Master.website = jsonElement[@"website"];
        Tattoo_Master.gallery_m1 = jsonElement[@"Gallery1"];
               Tattoo_Master.personage = jsonElement[@"Personage"];

        Tattoo_Master.email = jsonElement[@"Email"];
         Tattoo_Master.image = jsonElement[@"image"];

        // Add this question to the locations array
        [_Tattoo_Master addObject:Tattoo_Master];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_Tattoo_Master];
    }
}


// ------------ ByPass ssl starts ----------
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge.protectionSpace.host isEqualToString:@"localhost"]/*check if this is host you trust: */)
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}// -------------------ByPass ssl ends
@end
