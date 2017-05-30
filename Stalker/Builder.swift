//
//  Builder.swift
//  Stalker
//
//  Created by m2sar on 30/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

// MARK: Builders

typealias EmptyBuilder = () throws -> Void

typealias UserBuilder = () throws -> User
typealias UsersBuilder = () throws -> [User]

typealias FriendshipBuilder = () throws -> Friendship
typealias FriendshipsBuilder = () throws -> [Friendship]

typealias MeetPointBuilder = () throws -> MeetPoint
typealias MeetPointsBuilder = () throws -> [MeetPoint]

