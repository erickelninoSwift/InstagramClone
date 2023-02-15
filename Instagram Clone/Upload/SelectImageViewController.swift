//
//  SelectImageViewController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/11.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Photos
import Firebase

class SelectImageViewController: UICollectionViewController
{
    
    private var allImages = [UIImage]()
    private var Allasset = [PHAsset]()
    
    
    var user: User?
    
    var pickedImage: UIImage?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.fetchPhotos()
        }
        fetchCurrentUserData()
        configureNavButton()
        style()
        layout()
        
    }
    
}

extension SelectImageViewController: UICollectionViewDelegateFlowLayout
{
    
    private  func style()
    {
        collectionView.register(SelectPhotoHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectPhotoHeaderCell.photoheaderID)
        collectionView.register(SelectPhotoCell.self, forCellWithReuseIdentifier: SelectPhotoCell.selectphotocellID)
    }
    
    
    private func layout()
    {
        self.collectionView.backgroundColor = .white
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPhotoCell.selectphotocellID, for: indexPath) as? SelectPhotoCell else {return UICollectionViewCell()}
        cell.photocellimage.image = allImages[indexPath.row]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard pickedImage != nil else {return}
        self.pickedImage = allImages[indexPath.row]
        self.collectionView.reloadData()
        
        UIView.animate(withDuration: 2) {
            let myindexpath = IndexPath(item: 0, section: 0)
            self.collectionView.scrollToItem(at: myindexpath, at: .bottom, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header  =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SelectPhotoHeaderCell.photoheaderID, for: indexPath) as? SelectPhotoHeaderCell else {return UICollectionViewCell()}
        if let selectedImage = pickedImage
        {
            if let index = self.allImages.firstIndex(of: selectedImage)
            {
                let selectedAsset = Allasset[index]
                let imgaeManager = PHImageManager.default()
                let targetsize  = CGSize(width: view.frame.width, height: 600)
                
                imgaeManager.requestImage(for: selectedAsset, targetSize: targetsize, contentMode: .default, options: nil) { (Image, Infos) in
                    if let currentImage = Image
                    {
                        header.profileImageView.image = currentImage
                    }
                }
                
            }
            
        }
        
        return header
    }
    
    
    // Functions needed to setup Collection views
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 3) / 4, height: (view.frame.width - 3) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension SelectImageViewController
{
    
    private func configureNavButton()
    {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(HansleCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(HandleDone))
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    
    @objc func HansleCancel()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func HandleDone()
    {
        guard let currentuser = user else {return}
        guard let currentImage = pickedImage else {return}
        
        let controller = PostController(user: currentuser, myImage: currentImage)
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension SelectImageViewController
{
    func getAssetoptions() -> PHFetchOptions
    {
        let selectedoption  = PHFetchOptions()
        
        //fetch linit
        selectedoption.fetchLimit = 30
        
        // sort photo by date
        let sortselectedoption = NSSortDescriptor(key: "creationDate", ascending: false)
        
        //set sort description for options
        selectedoption.sortDescriptors = [sortselectedoption]
        
        
        return selectedoption
    }
    
    func fetchPhotos()
    {
        let Allphotos = PHAsset.fetchAssets(with: .image, options: getAssetoptions())
        
        // fetch Imamge in the background
        
        DispatchQueue.global(qos: .background).async {
            
            Allphotos.enumerateObjects { (asset, count, stop) in
                
                let imageManager = PHImageManager.default()
                let targetsize  = CGSize(width: 180, height: 180)
                let currentoptions = PHImageRequestOptions()
                currentoptions.isSynchronous = true
                
                imageManager.requestImage(for: asset, targetSize: targetsize, contentMode: .aspectFit, options: currentoptions) { (Image, infos) in
                    
                    if let currentImage = Image
                    {
                        self.allImages.append(currentImage)
                        self.Allasset.append(asset)
                        
                        if self.pickedImage == nil
                        {
                            self.pickedImage = Image
                        }
                        
                        if count == Allphotos.count - 1
                        {
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension SelectImageViewController
{
    
    
    func fetchCurrentUserData()
    {
        guard let userid = Auth.auth().currentUser?.uid else {return}
        Services.shared.fetchUser(user_Id: userid) { user in
            self.user = user
        }
    }
}
