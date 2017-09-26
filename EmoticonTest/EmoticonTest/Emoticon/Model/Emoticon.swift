//
//  Emoticon.swift
//  EmoticonTest
//
//  Created by ZKJ on 2017/9/25.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

import UIKit

class Emoticon: NSObject {
    // MARK:- 属性
    var code : String? {     //emoji表情对应的code
        didSet {
            guard let code = code else {
                return
            }
            
            // 1.创建扫描器
            let sca = Scanner(string: code)
            
            // 2.调用方法,扫描出code中的值
            var value : UInt32 = 0
            sca.scanHexInt32(&value)
            
            // 3.将value转成字符
            let c = Character(UnicodeScalar(value)!)
            
            // 4.将字符转成字符串
            emojiCode = String(c)
        }
    }
    
    var png : String? {       //普通表情对应的图片名称
        didSet {
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs : String?       //普通表情对应的文字
    
    
    
    // MARK:- 数据处理
    var pngPath : String?
    var emojiCode : String?
    var isDelete : Bool = false
    var isEmpty : Bool = false
    
    
    // MARK:- 自定义构造函数
    init(isDelete : Bool) {
        self.isDelete = isDelete
    }
    
    init(isEmpty : Bool) {
        self.isEmpty = isEmpty
    }
    
    init(dic : [String : String]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["emojiCode", "pngPath", "chs"]).description
    }
}
