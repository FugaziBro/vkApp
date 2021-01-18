//
//  StringExtractor.swift
//  VkNews
//
//  Created by Pyretttt on 26.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation


struct NetworkConstants{
    //Needs vkApi.strings from Resources
    private static let extractString: (String)->String = {
        return Bundle.main.localizedString(forKey: $0, value: nil, table: "vkApi")
    }
    
    public static func getScheme()->String{
        return extractString("scheme")
    }
    
    public static func getHost()->String{
        return extractString("host")
    }
    
    public static func getApiVersion()->String{
        return extractString("version")
    }
    
    public static func getNewsFeedEndpoint()->String{
        return extractString("newsFeed")
    }
    
    public static func getAppId()->String{
        return extractString("appId")
    }
}
