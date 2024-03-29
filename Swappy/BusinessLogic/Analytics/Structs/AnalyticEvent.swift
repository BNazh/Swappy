//
//  AnalyticEvent.swift
//  Swappy
//
//  Created by Mihail on 28/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

enum AnalyticEvent: String {
    case
    startSession = "action_start_session",
    login = "action_login",
    
    loginByVkClick = "action_login_by_vk_click",
    loginByVkSuccess = "action_login_by_vk_success",
    loginByVkFailure = "action_login_by_vk_failure",
    
    loginByFbClick = "action_login_by_fb_click",
    loginByFbSuccess = "action_login_by_fb_success", // TODO
    loginByFbFailure = "action_login_by_fb_failure", // TODO
        
    loginByPhoneClick = "action_login_by_phone_click",
    loginByPhoneSuccess = "action_login_by_phone_success",
    loginByPhoneFailure = "action_login_by_phone_failure",
    
    contactInfoClick = "action_request_contact_info",
    addProductSuccess = "action_add_product",
    contactUsClick = "action_contact_us" // TODO
}
