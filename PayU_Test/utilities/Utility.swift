//
//  Utility.swift
//  InfluencerMarketing
//
//  Created by Manas1 Mishra on 16/10/20.
//  Copyright © 2020 Manas Mishra. All rights reserved.
//

import UIKit

class Utility {
    class func changeOffsetWhenKeyboardWillShow(_ notification: Notification, superView: UIView, collectionView: UICollectionView, cellWhichWillStartEditing: UICollectionViewCell) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        guard let cellframe = cellWhichWillStartEditing.superview?.convert(cellWhichWillStartEditing.frame, to: superView) else {return}
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        let keyboardY = superView.frame.height - keyboardHeight
            
        
        if keyboardY < cellframe.maxY + 10 {
            let offsety =  cellframe.maxY + 10 - keyboardY
            var currentOffset = collectionView.contentOffset
            currentOffset.y += offsety
            collectionView.setContentOffset(currentOffset, animated: false)
        }
    }
    
    
}


