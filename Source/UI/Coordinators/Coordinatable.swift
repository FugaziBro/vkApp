//
//  Coordinatable.swift
//  VkNews
//
//  Created by Pyretttt on 24.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

//MARK: - Procol defines coordinator pattern core 
protocol Coordinatable{
    var childCoordinators: [Coordinatable] { get set }
    func start()
    func end()
}
