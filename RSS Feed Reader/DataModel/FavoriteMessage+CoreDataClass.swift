//
//  FavoriteMessage+CoreDataClass.swift
//  RSS Feed Reader
//
//  Created by Алексей Воронов on 29/10/2018.
//  Copyright © 2018 Алексей Воронов. All rights reserved.
//
//

import CoreData

@objc(FavoriteMessage)
public class FavoriteMessage: NSManagedObject {
    class func newMessage(from feedItem: FeedMessage?) {
        let message = FavoriteMessage(context: CoreDataManager.shared.managedObjectContext)
        message.title = feedItem?.title
        message.desc = feedItem?.desc
        message.pubDate = feedItem?.pubDate
        message.image = feedItem?.image
        message.link = feedItem?.link
        message.savedDate = Date()
    }
}
