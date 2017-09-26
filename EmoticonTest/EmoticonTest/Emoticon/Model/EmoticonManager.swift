//
//  EmoticonManager.swift
//  EmoticonTest
//
//  Created by ZKJ on 2017/9/25.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

import UIKit

class EmoticonManager: NSObject {
    var packages : [EmoticonPackage] = [EmoticonPackage]()
    
    override init() {
        super.init()
        // 1.添加最近表情的包
        packages.append(EmoticonPackage(id: ""))
        
        // 2.添加默认表情的包
        packages.append(EmoticonPackage(id: "com.sina.default"))
        
        // 3.添加emoji表情的包
        packages.append(EmoticonPackage(id: "com.apple.emoji"))
        
        // 4.添加浪小花表情的包
        packages.append(EmoticonPackage(id: "com.sina.lxh"))
    }
}
