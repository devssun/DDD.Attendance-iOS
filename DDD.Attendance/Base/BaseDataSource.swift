//
//  BaseDataSource.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class BaseDataSource: NSObject, UICollectionViewDataSource, UITableViewDataSource {
    
    /// Data Values
    var values: [[(value: Any, reusableId: String)]] = []
    
    func clearValues() {
        self.values = [[]]
    }
    
    func clearValues(section: Int) {
        self.padValuesForSection(section)
        self.values[section] = []
    }
    
    func configureCell(collectionCell cell: UICollectionViewCell, withValue value: Any) {}
    
    func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {}
    
    subscript(indexPath: IndexPath) -> Any {
        return self.values[indexPath.section][indexPath.item].value
    }
    
    subscript(itemSection itemSection: (item: Int, section: Int)) -> Any {
        return self.values[itemSection.section][itemSection.item].value
    }
    
    subscript(section section: Int) -> [Any] {
        return self.values[section].map { $0.value }
    }
    
    func set<Cell: BaseCell, Value: Any>(value: Value,
                                              cellClass: Cell.Type,
                                              inSection section: Int,
                                              row: Int
        ) where Cell.Value == Value {
        self.values[section][row] = (value, Cell.defaultReusableId )
    }
    
    func set<Cell: BaseCell, Value: Any>(values: [Value],
                                              cellClass: Cell.Type,
                                              inSection section: Int
        ) where Cell.Value == Value {
        self.padValuesForSection(section)
        self.values[section] = values.map { ($0, Cell.defaultReusableId) }
    }
    
    @discardableResult
    func appendRow <Cell: BaseCell, Value: Any>(value: Value,
                                                     cellClass: Cell.Type,
                                                     toSection section: Int
        ) -> IndexPath where Cell.Value == Value {
        self.padValuesForSection(section)
        self.values[section].append((value, Cell.defaultReusableId))
        return IndexPath(row: self.values[section].count - 1, section: section)
    }
    
    func appendSection <Cell: BaseCell, Value: Any>(values: [Value],
                                                         cellClass: Cell.Type
        ) where Cell.Value == Value {
        self.values.append(values.map { ($0, Cell.defaultReusableId) })
    }
    
    @discardableResult
    func deleteRow<Cell: BaseCell, Value: Any>(value: Value,
                                                    cellClass: Cell.Type,
                                                    atIndex index: Int,
                                                    inSection section: Int
        ) -> IndexPath where Cell.Value == Value {
        self.padValuesForSection(section)
        self.values[section].remove(at: index)
        return IndexPath(row: index, section: section)
    }
    
    /// Sections Count
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.values.count
    }
    
    /// CollectionView numberOfItemsInSection Method
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.values[section].count
    }
    
    /// CollectionView cellForItemAt Method
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let (value, reusableId) = self.values[indexPath.section][indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId,
                                                      for: indexPath)
        self.configureCell(collectionCell: cell, withValue: value)
        return cell
    }
    
    /// TableView numberOfRowsInSection Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values[section].count
    }
    
    /// TableView cellForRowAt Method
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (value, reusableId) = self.values[indexPath.section][indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath)
        self.configureCell(tableCell: cell, withValue: value)
        return cell
    }
    
    func padValuesForSection(_ section: Int) {
        guard self.values.count <= section else { return }
        
        (self.values.count...section).forEach { (_) in
            self.values.append([])
        }
    }
}
