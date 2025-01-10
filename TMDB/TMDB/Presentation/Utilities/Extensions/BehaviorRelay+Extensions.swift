// 
//  BehaviorRelay+Extensions.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import RxSwift
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    /// Appends the provided items to the current value of the `BehaviorRelay`.
    ///
    /// - Parameter items: The items to append to the current value.
    ///
    /// This extension is particularly useful when dealing with collections (e.g., arrays) 
    /// where you want to add new items to the existing ones.
    func append(_ items: Element) {
        var currentItems = self.value
        currentItems.append(contentsOf: items)
        accept(currentItems)
    }
    
    /// Removes the element at the specified index and emits the updated array.
    ///
    /// - Parameter index: The index of the element to remove.
    func remove(at index: Element.Index) {
        var elements = self.value
        elements.remove(at: index)
        accept(elements)
    }
}