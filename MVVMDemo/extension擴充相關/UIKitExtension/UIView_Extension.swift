//
//  ViewExtension.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import UIKit

extension UIView {
    
    /// 重設view高度
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newValue) {
            self.frame.size.height = newValue
        }
    }
    
    /// 重設view寬度
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newValue) {
            self.frame.size.width = newValue
        }
    }
    
    ///將View 轉成 image
    func changetoImage(size: CGSize) -> UIImage? {
        //開啟畫布
        UIGraphicsBeginImageContext(size)
        //設定物件繪製範圍
        let snapshotRet = CGRect(origin: CGPoint.zero, size: size)
        //View繪製
        
        drawHierarchy(in: snapshotRet, afterScreenUpdates: true)
        //取得繪製的圖片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //關閉畫布
        UIGraphicsEndImageContext()
        return image
    }

}
