//
//  AlertControllers.swift
//  RSS Feed Reader
//
//  Created by Алексей Воронов on 05/10/2018.
//  Copyright © 2018 Алексей Воронов. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

class AlertService {
    
    private init() {}
    
    static func addAlert(in vc: ChannelsViewController,
                         completion: @escaping (String?, String?) -> Void) {
        let alertController = UIAlertController(title: "Добавить новый канал", message: nil, preferredStyle: .alert)
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Введите название канала"
            nameTextField.clearButtonMode = .whileEditing
        }
        alertController.addTextField { (linkTextField) in
            linkTextField.placeholder = "Введите ссылку на канал"
            linkTextField.keyboardType = UIKeyboardType.URL
            linkTextField.clearButtonMode = .whileEditing
        }
        
        let alertAction1 = UIAlertAction(title: "Добавить",
                                         style: .default) { (alert) in
            let newItem = alertController.textFields![0].text
            let newItem2 = alertController.textFields![1].text
            let name = newItem == "" ? nil : newItem
            let link = newItem2 == "" ? nil : newItem2
            completion(name, link)
        }
        let alertAction2 = UIAlertAction(title: "Отмена",
                                         style: .cancel, handler: nil)
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        vc.present(alertController,
                   animated: true,
                   completion: nil)
    }
    
    static func updateAlert(in vc: ChannelsViewController,
                            channelsData: FeedsList,
                            completion: @escaping (String?, String?) -> Void) {
        let alertController = UIAlertController(title: "Изменить канал",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { (nameTextField) in
            nameTextField.text = (channelsData.name)
            nameTextField.placeholder = "Введите название канала"
            nameTextField.clearButtonMode = .whileEditing
        }
        alertController.addTextField { (linkTextField) in
            linkTextField.text = (channelsData.link)
            linkTextField.placeholder = "Введите ссылку на канал"
            linkTextField.keyboardType = UIKeyboardType.URL
            linkTextField.clearButtonMode = .whileEditing
        }
        
        let alertAction1 = UIAlertAction(title: "Изменить",
                                         style: .default) { (alert) in
            let newItem = alertController.textFields![0].text
            let newItem2 = alertController.textFields![1].text
            let name = newItem == "" ? nil : newItem
            let link = newItem2 == "" ? nil : newItem2
            completion(name, link)
        }
        let alertAction2 = UIAlertAction(title: "Отмена",
                                         style: .cancel,
                                         handler: nil)
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        vc.present(alertController,
                   animated: true,
                   completion: nil)
    }
    
    static func shareAlert(in vc: FeedViewController, indexPath: IndexPath) {
        let currentItem = vc.rssItems![indexPath.row]
        let image = vc.imgs[indexPath.row]
        let cell = vc.collectionView.cellForItem(at: indexPath) as? FeedCollectionViewCell
        let alert = UIAlertController(title: currentItem.title, message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Открыть в Safari",
                                      style: .default,
                                      handler: { action in
            UIApplication.shared.open(URL(string: currentItem.link)!)
            vc.activityIndicator.removeFromSuperview()
        }))
        alert.addAction(UIAlertAction(title: "Сохранить новость в Фото",
                        style: .default,
                        handler: { action in
            let image = cell?.captureView()
            UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
            vc.activityIndicator.removeFromSuperview()
        }))
        if image != "" {
            alert.addAction(UIAlertAction(title: "Сохранить изображение",
                                          style: .default,
                                          handler: { action in
                    let img = cell?.newsImage.image
                    UIImageWriteToSavedPhotosAlbum(img!, self, nil, nil)
                    vc.activityIndicator.removeFromSuperview()
                }))
        }
        alert.addAction(UIAlertAction(title: "Скопировать",
                                      style: .default,
                                      handler: { action in
                let copiedItem = currentItem.title + "\n\n" + currentItem.description + "\n\n" + currentItem.link
                UIPasteboard.general.string = copiedItem
                vc.activityIndicator.removeFromSuperview()
        }))
        alert.addAction(UIAlertAction(title: "Поделиться",
                                      style: .default,
                                      handler: { action in
            if image != "" {
                let img = cell?.newsImage.image
                let objectsToShare = [currentItem.title,
                                      "\n",
                                      currentItem.description,
                                      "\n",
                                      img as Any,
                                      "\n",
                                      currentItem.link]
                let activityVC = UIActivityViewController(activityItems: objectsToShare,
                                                          applicationActivities: nil)
                vc.activityIndicator.removeFromSuperview()
                vc.present(activityVC,
                           animated: true,
                           completion: nil)
            }
            else{
                let objectsToShare = [currentItem.title,
                                      "\n",
                                      currentItem.description,
                                      "\n",
                                      currentItem.link]
                let activityVC = UIActivityViewController(activityItems: objectsToShare,
                                                          applicationActivities: nil)
                vc.activityIndicator.removeFromSuperview()
                vc.present(activityVC,
                           animated: true,
                           completion: nil)
                                        }
           
        }))
        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel,
                                      handler: { action in
            vc.activityIndicator.removeFromSuperview()
        }))
        vc.present(alert,
                   animated: true,
                   completion: nil)
    }
    
}
