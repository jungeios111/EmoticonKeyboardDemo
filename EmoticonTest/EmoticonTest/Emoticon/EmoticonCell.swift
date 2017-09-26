//
//  EmoticonCell.swift
//  EmoticonTest
//
//  Created by ZKJ on 2017/9/25.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

import UIKit

class EmoticonCell: UICollectionViewCell {
    
    //懒加载控件
    fileprivate lazy var emoticonBtn : UIButton = UIButton()
    
    //定义属性
    var emoticon : Emoticon? {
        didSet {
            guard let emoticon = emoticon else {
                return
            }
            
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            emoticonBtn.setTitle(emoticon.emojiCode, for: .normal)
            
            if emoticon.isDelete {
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmoticonCell {
    fileprivate func setupUI() {
        contentView.addSubview(emoticonBtn)
        emoticonBtn.frame = contentView.bounds
        emoticonBtn.isUserInteractionEnabled = false
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
