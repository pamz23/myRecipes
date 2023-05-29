//
//  CurrentUser.swift
//  myRecipes
//
//  Created by Thesya Evania on 29/5/2023.
//

class CurrentUser {
    static let shared = CurrentUser()
    
    var currentUser: User?
    
    private init() {}
}
