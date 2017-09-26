//
//  EmoticonPackage.swift
//  EmoticonTest
//
//  Created by ZKJ on 2017/9/25.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    var emoticons : [Emoticon] = [Emoticon]()
    
    init(id : String) {
        super.init()
        // 1.最近分组
        if id == "" {
            self.addEmpty(isRecently: true)
            return
        }
        
        // 2.根据id拼接info.plist的路径
        let path = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        
        // 3.根据plist文件的路径读取数据 [[String : String]]
        let array = NSArray(contentsOfFile: path!) as! [[String : String]]
        
        // 4.遍历字典转模型
        var i = 0
        for var dic in array {
            
            if let png = dic["png"] {
                dic["png"] = id + "/" + png
            }
            
            emoticons.append(Emoticon(dic: dic))
            i += 1
            
            if i == 23 {
                emoticons.append(Emoticon(isDelete: true))
                i = 0
            }
        }
        
        // 5.添加空白表情
        addEmpty(isRecently: false)
    }
    
    fileprivate func addEmpty(isRecently : Bool) {
        let count = emoticons.count % 24
        if count == 0 && !isRecently {
            return
        }
        
        for _ in count..<23 {
            emoticons.append(Emoticon(isEmpty: true))
        }
        emoticons.append(Emoticon(isDelete: true))
    }
}
