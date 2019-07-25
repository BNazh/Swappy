//
//  ProfileEditPresenter.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProfileEditPresenter: AnyObject {
    
    func reloadSaveButton()
    func openCitySelection()
    func save()
    func logout()
}

final class ProfileEditPresenterImp {
    
    // MARK: - Properties
    
    let view: ProfileEditView
    let cityService: CityService
    
    // MARK: - Init
    
    init(view: ProfileEditView,
         cityService: CityService) {
        self.view = view
        self.cityService = cityService
    }
}

// MARK:  ProfileEditPresenter

extension ProfileEditPresenterImp: ProfileEditPresenter {
    
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

// MARK: - Private

private extension ProfileEditPresenterImp {
    
    var isReadyToSave: Bool {
        let nameFilled = !view.name.isEmpty
        let phoneFilled = !view.phone.isEmpty
        let cityFilled = !view.city.isEmpty
        
        return nameFilled && phoneFilled && cityFilled
    }
}
