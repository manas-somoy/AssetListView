//
//  ViewController.m
//  AlbumAssetList
//
//  Created by Somoy on 20/10/19.
//  Copyright © 2019 Somoy Das Gupta. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchAlbums];
}
- (BOOL)checkPermission {
//    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
    if (PHPhotoLibrary.authorizationStatus == PHAuthorizationStatusAuthorized) {
        return true;
    } else {
        __block BOOL check;
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                check = true;
            } else {
                check = false;
            }
        }];
        
        return check;
    }
}

- (void)fetchAlbums {
    if ([self checkPermission]) {
        
        NSMutableArray *albumList = [NSMutableArray new];
        NSMutableArray *fetchResult = [NSMutableArray new];
        
        PHFetchResult *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
        [albums enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL * _Nonnull stop) {
            PHFetchOptions *options = [[PHFetchOptions alloc] init];
            options.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:[NSPredicate predicateWithFormat:@"mediaType in %@", @[@(PHAssetMediaTypeVideo)]], nil]];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:false]];
            
            PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:options];
            if (assetsFetchResult.count > 0) {
                [albumList addObject:collection.localizedTitle];
                [fetchResult addObject:assetsFetchResult];
                NSLog(@"%@ --- %lu",collection.localizedTitle,(unsigned long)assetsFetchResult.count);
            }
        }];
    }
}

//MARK:- PHPhotoLibraryChangeObserver
//- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
//    NSLog(@"%@", changeInstance.description);
//}

@end
