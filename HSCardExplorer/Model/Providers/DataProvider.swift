//
//  DataProvider.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import Foundation
import Combine

class DataProvider<T>: ObservableObject {
    
    var currentPage = 0
    let pageSize: Int
    var isFetchingFromServer = false
    var noMoreData = false
    
    @Published var data = [T]()
    
    var subscriptions = Set<AnyCancellable>()
    
    init(pageSize: Int) {
        self.pageSize = pageSize
    }
    
    func getData() {
        guard !isFetchingFromServer,
              !noMoreData
        else {
            return
        }
        fetchData()
    }
    
    func fetchData() {
        isFetchingFromServer = true
    }
    
    var theresMoreData: Bool {
        return !noMoreData
    }
    
    var isFetchingData: Bool {
        return isFetchingFromServer
    }
    
    func resetData() {
        currentPage = 0
        noMoreData = false
        isFetchingFromServer = false
        data.removeAll()
    }
    
    func addData(_ data: [T]) {
        self.data.append(contentsOf: data)
    }
}
