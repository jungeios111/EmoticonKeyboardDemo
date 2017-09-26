//
//  ViewController.swift
//  EmoticonTest
//
//  Created by ZKJ on 2017/9/22.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- 属性
    fileprivate lazy var emoticonView : EmoticonController = EmoticonController()
    
    // MARK:- 控件
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.inputView = emoticonView.view
        
        let manager = EmoticonManager()
        for package in manager.packages {
            for emoticon in package.emoticons {
                print(emoticon)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }

}

extension ViewController : UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
