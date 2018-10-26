//
//  FeedsList+CoreDataClass.swift
//  RSS Feed Reader
//
//  Created by Алексей Воронов on 25/10/2018.
//  Copyright © 2018 Алексей Воронов. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FeedsList)
public class FeedsList: NSManagedObject {
    class func newFeed(name: String, link: String) -> FeedsList {
        let feed = FeedsList(context: CoreDataManager.sharedInstance.managedObjectContext)
        feed.name = name
        feed.link = link
        return feed
    }
    
//    func addFeed(title: String, desc: String, pubDate: String, link: String){
//        let feed = Feed(context: CoreDataManager.sharedInstance.managedObjectContext)
//        var feedSorted = self.messagesSorted
//        feedSorted = [feed]
//    }
    
    func addFeed(title: String, desc: String, pubDate: String, link: String) -> Feed {
        let feed = Feed(context: CoreDataManager.sharedInstance.managedObjectContext)
        feed.feedsList = self
        return feed
    }
    
    var messagesSorted: [Feed] {
        let sortDescriptor = NSSortDescriptor(key: "pubDate", ascending: false)
        return self.feed?.sortedArray(using: [sortDescriptor]) as! [Feed]
    }
    
}