//
//  CollectionsViewModel.swift
//  DubDub
//
//  Created by Adolfo Vera Blasco on 27/06/2019.
//  Copyright © 2019 Adolfo Vera Blasco. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

import CoreWWDC
import DubDubKit

internal class CollectionsViewModel: ObservableObject
{
    /// Las colecciones disponibles en este momento.
    public private(set) var collections: [SpecialCollection]
    {
        willSet
        {
            self.objectWillChange.send()
        }
    }

    // MARK: - Bindable Object Protocol -

    /// Informamos de los cambios a la vista.
    public var objectWillChange = PassthroughSubject<Void, Never>()

    /**

    */
    public init()
    {
        self.collections = []
        //self.fetchCollections()
    }

    //
    // MARK: - Operations - 
    //

    public func fetchCollections() -> Void
    {
        WWDCClient.shared.requestSpecialCollections() { (result: Result<[SpecialCollection], WWDCError>) -> Void in
            switch result
            {
                case .success(let collections):
                    DispatchQueue.main.async
                    {
                        self.collections = collections
                    }
                
                case .failure(let error):
                    DispatchQueue.main.async
                    {
                        self.collections = []
                    }
                    
                    print("Problemas al recuperar las colecciones especiales. \(error)")
            }
        }
    }
}
