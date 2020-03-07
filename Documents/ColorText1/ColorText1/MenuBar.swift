//
//  MenuBar.swift
//  ColorText1
//
//  Created by MacBook Pro 15" on 3/3/20.
//  Copyright © 2020 MacBook Pro 15". All rights reserved.
//

import UIKit
class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var viewController: ViewController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageIconName = ["1", "2", "3", "4", "5"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 64)
        ].forEach{ $0.isActive = true}
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        setupHorizontalBar()
    }
    var horizontalBarLeftAnchorConstraint : NSLayoutConstraint?
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.black
        addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
         horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
              [
                horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5),
                  horizontalBarView.heightAnchor.constraint(equalToConstant: 4)
              ].forEach{ $0.isActive = true}
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.row) * frame.width / 5
        horizontalBarLeftAnchorConstraint?.constant = x
        
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {self.layoutIfNeeded()
//        }, completion: nil)
        viewController?.scrollToMenuIndex(menuIndex: indexPath.row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageIconName[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.init(red: 91, green: 14, blue: 13, alpha: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/5, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



class MenuCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let imageView: UIImageView = {
       let iv = UIImageView()
       iv.image = UIImage(named: "1")?.withRenderingMode(.alwaysTemplate)
       iv.tintColor =  UIColor.init(red: 91, green: 14, blue: 13, alpha: 1)
       return iv
    }()
    override var isHighlighted: Bool
    {
        didSet
        {
            imageView.tintColor = isHighlighted ? UIColor.red :  UIColor.init(red: 91, green: 14, blue: 13, alpha: 1)

        }
    }
    override var isSelected: Bool{
        didSet
        {
            imageView.tintColor = isSelected ? UIColor.red :  UIColor.init(red: 91, green: 14, blue: 13, alpha: 1)

        }
    }
    
    func setupViews() {
        
        backgroundColor = UIColor.lightGray
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        [
            //imageView.topAnchor.constraint(equalTo: self.topAnchor),
            //imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            //imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //imageView.heightAnchor.constraint(equalToConstant: 32),
           // imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ].forEach{ $0.isActive = true}
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
