//
//  ProfileEditPresenter.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProfileEditPresenter: AnyObject {
    
    func initialize()
    func reloadSaveButton()
    func openCitySelection()
    func save()
    func logout()
}

final class ProfileEditPresenterImp {
    
    // MARK: - Properties
    
    let view: ProfileEditView
    let router: ProfileEditRouter
    let cityService: CityService
    
    // MARK: - Init
    
    init(view: ProfileEditView,
         router: ProfileEditRouter,
         cityService: CityService) {
        self.view = view
        self.router = router
        self.cityService = cityService
    }
}

// MARK:  ProfileEditPresenter

extension ProfileEditPresenterImp: ProfileEditPresenter {
    
    func initialize() {
        
    }
    
    func reloadSaveButton() {
        view.reloadSaveButton(isEnabled: isReadyToSave)
    }
    
    func openCitySelection() {
        let input = SingleSelectionInput(
            items: cityService.cities,
            selectedItem: cityService.selectedCity,
            title: "Выбор города",
            buttonTitle: "Выбрать"
        )
        
        router.openSelection(delegate: self, input: input)
    }
    
    func save() {
        
    }
    
    func logout() {
        
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
        let phoneFilled = !view.phone.isEmpty
        let cityFilled = !view.city.isEmpty
        
        return nameFilled && phoneFilled && cityFilled
    }
}
