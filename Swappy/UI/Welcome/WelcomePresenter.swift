//
//  WelcomePresenter.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol WelcomePresenter: class {
    
    func setNameText(_ name: String?)
    func openCitySelection()
    func openMainScreen()
}

final class WelcomePresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: WelcomeView
    private let router: WelcomeRouter
    
    private let keychainStore: KeychainStore
    private let cityService: CityService
    
    private var selectedName: String?
    
    // MARK: - Init
    
    init(view: WelcomeView, router: WelcomeRouter,
         keychainStore: KeychainStore, cityService: CityService) {
        self.view = view
        self.router = router
        self.keychainStore = keychainStore
        self.cityService = cityService
    }
}

// MARK: - WelcomePresenter

extension WelcomePresenterImp: WelcomePresenter {
    
    func openCitySelection() {
        let input = SingleSelectionInput(
            items: cityService.cities,
            selectedItem: cityService.selectedCity,
            title: "Выбор города",
            buttonTitle: "Выбрать"
        )
        
        router.openSelection(delegate: self, input: input)
    }
    
    func setNameText(_ name: String?) {
        selectedName = name
        reloadStartButton()
    }
    
    func openMainScreen() {
        keychainStore.welcomeName = selectedName
        
        router.openMainScreen()
    }
}

// MARK: - SingleSelectionDelegate

extension WelcomePresenterImp: SingleSelectionDelegate {
    
    func didSelectItem(_ item: SelectionItem) {
        guard let city = item as? City else { return }
        
        cityService.selectedCity = city
        
        view.displayCity(city.title)
        reloadStartButton()
    }
}

// MARK: - Private

private extension WelcomePresenterImp {
    
    func reloadStartButton() {
        let name = selectedName ?? ""
        let city = cityService.selectedCity?.title ?? ""
        
        let isReadyToStart = !name.isEmpty && !city.isEmpty
        
        view.setStartButtonEnabled(isReadyToStart)
    }
}
