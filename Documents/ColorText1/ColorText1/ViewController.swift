//
//  ViewController.swift
//  ColorText1
//
//  Created by MacBook Pro 15" on 2/27/20.
//  Copyright © 2020 MacBook Pro 15". All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    

    var imageArray  = [Image]()
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    @IBOutlet weak var textView: UITextView!
    
    
    
    
    
    @IBOutlet weak var img: UIImageView!
    var TextViewImageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        imageArray = getImage()
        setupCollectionView()
        setUpMenuBar()
    }
    
    let cellId = "cellId"
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
    }
    
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.viewController = self
        return mb
    }()
    func setUpMenuBar() {
        view.addSubview(menuBar)
          menuBar.translatesAutoresizingMaskIntoConstraints = false
        [
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 560),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 64)
        ].forEach{ $0.isActive = true}
    }
    
    func getImage() -> [Image] {
        var generatedImages = [Image]()
        
        for _ in 1...5 {
            let imageOne = Image()
            imageOne.imageName = "Google"
            generatedImages.append(imageOne)
            
            let imageTwo = Image()
            imageTwo.imageName = "FB"
            generatedImages.append(imageTwo)
            
            let imageThree = Image()
            imageThree.imageName = "Email"
            generatedImages.append(imageThree)
        }
        return generatedImages
    }
    
    //MARK:New CollectionView protocol method
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/5
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let colors: [UIColor] = [.black, .blue, .brown, .gray, .red]
        
        cell.backgroundColor = colors[indexPath.row]
        return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 414, height: 229)
    }
    
    
    
    
    
    
    
    
    //MARK: CollectionView Protocol Method
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
//        let image = imageArray[indexPath.row]
//        cell.setImage(image)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
//        setTextView(ImageName: cell.image!.imageName)
//
//    }
//
    
    
    
    
    //MARK: Set TextView to display
    func setTextView(ImageName: String) {
         textView.backgroundColor = UIColor(patternImage: UIImage(named: ImageName)!)
         textView.text = ""
         textView.font = UIFont.preferredFont(forTextStyle: .headline)
         textView.delegate = self
         textViewDidChange(textView)
    }

}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach{ (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
    }
}

}


