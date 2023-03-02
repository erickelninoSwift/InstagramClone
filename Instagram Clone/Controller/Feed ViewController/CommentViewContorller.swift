//
//  CommentViewContorller.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/03/01.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit


private let collectionviewcellID = "CollectionViewID"

class CommentViewContorller: UICollectionViewController
{
    
    
    lazy var commentTetxfield: UITextField =
    {
            let textfield = UITextField()
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.borderStyle = .roundedRect
            textfield.placeholder = "Type in you comment here"
           textfield.textColor = .darkGray
            textfield.backgroundColor = .white
            
            return textfield
    }()
 
    lazy var postButton: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setTitle("Post", for: .normal)
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(HandlepostButton), for: .primaryActionTriggered)
            
            return button
    }()
    
    
    lazy var containerView: UIView =
        {
            let container  = UIView()
            
            container.addSubview(commentTetxfield)
            container.addSubview(postButton)
            
            
            container.translatesAutoresizingMaskIntoConstraints = false
            container.backgroundColor = .init(white: 0.7, alpha: 1)
            container.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            
            
            NSLayoutConstraint.activate([commentTetxfield.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                                         commentTetxfield.leadingAnchor.constraint(equalToSystemSpacingAfter: container.leadingAnchor, multiplier: 1),
//
            ])
            
            NSLayoutConstraint.activate([postButton.leadingAnchor.constraint(equalToSystemSpacingAfter:commentTetxfield.trailingAnchor , multiplier: 1),
                                         postButton.centerYAnchor.constraint(equalTo: commentTetxfield.centerYAnchor),
                                         container.trailingAnchor.constraint(equalToSystemSpacingAfter: postButton.trailingAnchor, multiplier: 1)
                                         
            ])
            
            
            let separatorView = UIView()
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            
            separatorView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
            container.addSubview(separatorView)
            
            NSLayoutConstraint.activate([separatorView.leadingAnchor.constraint(equalToSystemSpacingAfter: container.leadingAnchor, multiplier: 0),
                                         container.trailingAnchor.constraint(equalToSystemSpacingAfter: separatorView.trailingAnchor, multiplier: 0),
                                         separatorView.topAnchor.constraint(equalTo: container.topAnchor)
            ])
        
            return container
    }()
    
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override var inputAccessoryView: UIView?
    {
        return containerView
    }
    
    override var canBecomeFirstResponder: Bool
    {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension CommentViewContorller: UICollectionViewDelegateFlowLayout
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.commentCellID, for: indexPath) as? CommentCell else
        {return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
}

extension CommentViewContorller
{
    private func style()
    {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.commentCellID)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "Comments"
    }
    
    private func layout()
    {
        
    }
    
    
    @objc private func HandlepostButton()
    {
        print("DEBUG: POST BUTTON PRESSED")
    }
}

