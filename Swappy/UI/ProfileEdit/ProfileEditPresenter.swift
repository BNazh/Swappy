//
//  ProfileEditPresenter.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProfileEditPresenter: AnyObject {
    
    func initialize()
    func reloadSaveButton()
    func openCitySelection()
    func save(avatar: UIImage?)
    func logout()
}

final class ProfileEditPresenterImp {
    
    // MARK: - Properties
    
    unowned let view: ProfileEditView
    let router: ProfileEditRouter
    let userService: UserService
    let imageService: ImageService
    let cityService: CityService
    
    // MARK: - Init
    
    init(view: ProfileEditView,
         router: ProfileEditRouter,
         userService: UserService,
         imageService: ImageService,
         cityService: CityService) {
        self.view = view
        self.router = router
        self.userService = userService
        self.imageService = imageService
        self.cityService = cityService
    }
}

// MARK:  ProfileEditPresenter

extension ProfileEditPresenterImp: ProfileEditPresenter {
    
    func initialize() {
        let name = userService.currentFullName ?? ""
        let phone = userService.currentPhone ?? ""
        let city = userService.currentCity?.title ?? ""
        let avatarUrl = userService.currentUser?.avatarUrl?.asUrl
        
        view.displayInitialize(name: name, phone: phone, city: city, avatarUrl: avatarUrl)
    }
    
    func reloadSaveButton() {
        view.reloadSaveButton(isEnabled: isReadyToSave)
    }
    
    func openCitySelection() {
        let input = SingleSelectionInput(
            items: cityService.cities,
            selectedItem: userService.currentCity,
            title: "Выбор города",
            buttonTitle: "Выбрать"
        )
        
        router.openSelection(delegate: self, input: input)
    }
    
    func save(avatar: UIImage?) {
        view.showLoading()

        guard let avatar = avatar else {
            updateUserProfile(avatarUrl: nil)
            return
        }
        
        imageService.uploadImage(avatar, progressBlock: { _ in }) { [weak self] result in
            guard let avatarUrl = result.value else {
                self?.handleUpdateProfileError()
                return
            }
            
            self?.updateUserProfile(avatarUrl: avatarUrl)
        }
    }
    
    func logout() {
        userService.logout()
    }
}

// MARK: - SingleSelectionDelegate

extension ProfileEditPresenterImp: SingleSelectionDelegate {
    
    func didSelectItem(_ item: SelectionItem) {
        guard let city = item as? City else {
            return
        }
        
        cityService.selectedCity = city
        view.city = city.title
        
        reloadSaveButton()
    }
}

// MARK: - Private

private extension ProfileEditPresenterImp {
    
    var isReadyToSave: Bool {
        let nameFilled = !view.name.isEmpty
        let cityFilled = !view.city.isEmpty
        
        return nameFilled && cityFilled
    }
    
    func updateUserProfile(avatarUrl: String?) {
        let name = view.name
        let city = cityService.selectedCity?.title
        userService.updateUser(name: name, avatar: avatarUrl, city: city) { [weak self] result in
            
            self?.view.hideLoading()
            
            switch result {
            case .success:
                self?.router.close()
            case .failure:
                self?.handleUpdateProfileError()
            }
        }
    }
    
    func handleUpdateProfileError() {
        view.hideLoading()
        
        let message = "Не удалось обновить профиль."
        view.showError(message: message)
    }
}
