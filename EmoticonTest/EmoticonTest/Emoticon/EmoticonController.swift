//
//  EmoticonController.swift
//  EmoticonTest
//
//  Created by ZKJ on 2017/9/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

import UIKit

fileprivate let emoticonCell = "emoticonCell"

class EmoticonController: UIViewController {

    // MARK:- 控件
    fileprivate lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmoticonCollectionViewLayOut())
    fileprivate lazy var toolBar : UIToolbar = UIToolbar()
    fileprivate lazy var manager : EmoticonManager = EmoticonManager()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK:- 设置UI界面
extension EmoticonController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        collectionView.backgroundColor = UIColor.red
        toolBar.backgroundColor = UIColor.blue
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["toolBar" : toolBar, "colView" : collectionView] as [String : Any]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[colView]-0-[toolBar]-0-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        setupCollectionView()
        setupToolBar()
    }
    
    //布局collectionView
    fileprivate func setupCollectionView() {
        collectionView.collectionViewLayout = EmoticonCollectionViewLayOut()
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: emoticonCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    //布局toolBar
    fileprivate func setupToolBar() {
        let titles = ["最近", "默认", "emoji", "浪小花"]
        
        var index = 0
        var tempItems = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(EmoticonController.toolBarClick(item:)))
            item.tag = index
            tempItems.append(item)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            index += 1
        }
        
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orange
    }
}

// MARK:- toolBar的点击事件
extension EmoticonController {
    @objc fileprivate func toolBarClick(item : UIBarButtonItem) {
        let tag = item.tag
        let indexPath = IndexPath(item: 0, section: tag)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

// MARK:- 设置collectionView的数据源和代理方法
extension EmoticonController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.packages[section].emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emoticonCell, for: indexPath) as! EmoticonCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.cyan : UIColor.green
        let package = manager.packages[indexPath.section]
        cell.emoticon = package.emoticons[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
        insertRecentlyEmoticon(emoticon: emoticon)
    }
    
    fileprivate func insertRecentlyEmoticon(emoticon : Emoticon) {
        if emoticon.isEmpty || emoticon.isDelete {
            return
        }
        
        if (manager.packages.first?.emoticons.contains(emoticon))! {
            let index = manager.packages.first?.emoticons.index(of: emoticon)
            manager.packages.first?.emoticons.remove(at: index!)
        } else {
            manager.packages.first?.emoticons.remove(at: 22)
        }
        
        manager.packages.first?.emoticons.insert(emoticon, at: 0)
    }
}

class EmoticonCollectionViewLayOut: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemWH = UIScreen.main.bounds.width / 8
        itemSize = CGSize(width: itemWH, height: itemWH)
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        let margin = (collectionView!.bounds.height - 3 * itemWH) / 2
        collectionView?.contentInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
    }
}



