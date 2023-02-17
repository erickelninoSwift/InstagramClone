//
//  Protocols.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/01.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

protocol ProfileCollectionViewHeaderDelegate: AnyObject
{
    func HandleeditFollow(profileheader: ProfileCollectionViewHeader, buttonConfig: configurationEditbutton)
    func handleGrid(CurrentButton: UIButton , profileheader: ProfileCollectionViewHeader)
    func handleListController(CurrentButton: UIButton , profileheader: ProfileCollectionViewHeader)
    func HandleBookmark(CurrentButton: UIButton , profileheader: ProfileCollectionViewHeader)
}

protocol profileheaderLabelActionDelegate: AnyObject
{
    func HandlePostLabel(userProfileHeader: ProfileCollectionViewHeader)
    func HandleFollowingLabel(userProfileHeader: ProfileCollectionViewHeader)
    func HandleFollowersLabel(userProfileHeader: ProfileCollectionViewHeader)
}

protocol FollowCellDelegate: AnyObject
{
    func handleFollowandUnfollowButtonTapped(cellFollow: FollowersViewControllerCell, cellconfig: followVCconfig)

}


protocol FeedCellDelegate: AnyObject
{
    
    func usernameButtonTapped(cell: FeedCell, buttonPressed: UIButton)
    func feedCellOptionButtonTapped(cell: FeedCell, buttonPressed: UIButton)
    func FeedLikeButtonTapped(cell: FeedCell, buttonPressed: UIButton)
    func FeedCommentbuttonTapped(cell: FeedCell, buttonPressed: UIButton)
    func FeedMessageButtonTapped(cell: FeedCell, buttonPressed: UIButton)
    func BookmarkButtonTapped(cell: FeedCell, buttonPressed: UIButton)
}
