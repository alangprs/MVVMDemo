//
//  ImageExtexsion.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import UIKit

extension UIImage {
    
    ///將兩張ｉｍａｇｅ合成，回傳合成好的照片
    class func mixImageToPhoto(foregroundImage: UIImage, backgroundImage: UIImage) -> UIImage? {
        //取得背景圖片的寬度
        let width = backgroundImage.size.width

        //取得背景圖片的高度
        let height = backgroundImage.size.height

        //開啟畫布
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))

        //繪製背景圖片
        backgroundImage.draw(at: CGPoint(x: 0, y: 0))

        //繪製前景圖片
        foregroundImage.draw(at: CGPoint(x: 0, y: 0))

        //取得繪製好的圖片
        let mixImage = UIGraphicsGetImageFromCurrentImageContext()

        //關閉畫布
        UIGraphicsEndImageContext()
        return mixImage
    }
}
