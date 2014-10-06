﻿
#if COOPER
import java.util
import com.remobjects.elements.linq
#elseif ECHOES
import System.Collections.Generic
import System.Linq
#elseif NOUGAT
import Foundation
import RemObjects.Elements.Linq
#endif


#if NOUGAT
__mapped public class Array<T: class> /*: INSFastEnumeration<T>*/ => Foundation.NSMutableArray {
#elseif COOPER
__mapped public class Array<T> => java.util.ArrayList<T> {
#elseif ECHOES
__mapped public class Array<T> => System.Collections.Generic.List<T> {
#endif
	/*private
	method SetItem(&Index: Integer Value: T)
	method GetItem(&Index: Integer): T*/

	//hack for now so we have a "mapped" field
	/*#if COOPER
	let mapped: java.util.ArrayList<T>!
	#elseif ECHOES
	let mapped: System.Collections.Generic.List<T>!
	#elseif NOUGAT
	let mapped: Foundation.NSMutableArray!
	#endif*/

	init() {
		#if COOPER
		return ArrayList<T>()
		#elseif ECHOES
		return List<T>()
		#elseif NOUGAT
		return NSMutableArray.array()
		#endif
	}
	
	init (items: Array<T>) { // [T]
		#if COOPER
		return items.clone() as Array<T>
		#elseif ECHOES
		return List<T>(items)
		#elseif NOUGAT
		return items.mutableCopy
		#endif
	}
	
	#if NOUGAT
	init (NSArray: NSArray<T>) { // [T]
		
	}
	#endif
	
	init (array: T[]) { // Low-level arrays
	}
	
	init (sequence: ISequence<T>) { // Sequence
		#if COOPER
		#elseif ECHOES
		#elseif NOUGAT
		#endif
	}

	init(count: Int, repeatedValue: T) {
		#if COOPER
		let newSelf: Array<T> = ArrayList<T>(count)
		#elseif ECHOES
		let newSelf: Array<T> = List<T>(count)
		#elseif NOUGAT
		let newSelf: Array<T> = NSMutableArray.arrayWithCapacity(count)
		#endif
		for var i: Int = 0; i < count; i++ {
			newSelf.append(repeatedValue)
		}
		return newSelf
	}
	
	public var count: Int {
		#if COOPER
		return __mapped.size()
		#elseif ECHOES
		return __mapped.Count
		#elseif NOUGAT
		return __mapped.count
		#endif
	}
	
	public var capacity: Int { 
		#if COOPER
		#elseif ECHOES
		return __mapped.Capacity
		#elseif NOUGAT
		#endif
		return -1 // todo
	}

	public var isEmpty: Bool { 
		return count == 0 
	}

	public var first: T? { 
		if count > 0 {
			return __mapped[0]
		}
		return nil
	}

	public var last: T? { 
		let c = count
		if c > 0 {
			return __mapped[c-1]
		}
		return nil
	}

	/// Ensure the array has enough mutable contiguous storage to store
	/// minimumCapacity elements in.  Note: does not affect count.
	/// Complexity: O(N)
	public mutating func reserveCapacity(minimumCapacity: Int) {
	}

	/// Append elements from `sequence` to the Array
	/*public mutating func extend<S : SequenceType where T == T>(sequence: S) {
	}*/

	/// Append newElement to the Array in O(1) (amortized)
	public mutating func append(newElement: T) {
		#if COOPER
		__mapped.add(newElement)
		#elseif ECHOES
		__mapped.Add(newElement)
		#elseif NOUGAT
		__mapped.addObject(newElement)
		#endif
	}

	public mutating func insert(newElement: T, atIndex index: Int) {
		#if COOPER
		__mapped.add(index, newElement)
		#elseif ECHOES
		__mapped.Insert(index, newElement)
		#elseif NOUGAT
		__mapped.insertObject(newElement, atIndex: index)
		#endif
	}

	public mutating func removeAtIndex(index: Int) -> T {
		#if COOPER
		__mapped.remove(index)
		#elseif ECHOES
		__mapped.RemoveAt(index)
		#elseif NOUGAT
		__mapped.removeObjectAtIndex(index)
		#endif
	}

	public mutating func removeLast() -> T {
		let c = count
		if c > 0 {
			removeAtIndex(c-1)
		}		
	}

	/// Erase all the elements.  If `keepCapacity` is `true`, `capacity`
	/// will not change
	public /*mutating*/ func removeAll(keepCapacity: Bool = false /*default*/) {
		#if COOPER
		__mapped.clear()
		#elseif ECHOES
		__mapped.Clear()
		#elseif NOUGAT
		__mapped.removeAllObjects()
		#endif
	}

	/// Interpose `self` between each consecutive pair of `elements`,
	/// and concatenate the elements of the resulting sequence.  For
	/// example, `[-1, -2].join([[1, 2, 3], [4, 5, 6], [7, 8, 9]])`
	/// yields `[1, 2, 3, -1, -2, 4, 5, 6, -1, -2, 7, 8, 9]`
	/*public func join<S : SequenceType where [T] == [T]>(elements: S) -> [T] {
	}*/

	/// Return the result of repeatedly calling `combine` with an
	/// accumulated value initialized to `initial` and each element of
	/// `self`, in turn, i.e. return
	/// `combine(combine(...combine(combine(initial, self[0]),
	/// self[1]),...self[count-2]), self[count-1])`.
	public func reduce<U>(initial: U, combine: (U, T) -> U) -> U {
	}

	public mutating func sort(isOrderedBefore: (T, T) -> Bool) {
		#if COOPER
		//todo
		#elseif ECHOES
		//69820: Silver: can't call Sort() with block, on Echoes
		__mapped.Sort({ (a: T, b: T) -> Boolean in // ToDo: check if this is the right order
			if isOrderedBefore(a,b) {
				return 1
			} else {
				return -1
			}
		})
		#elseif NOUGAT
		__mapped.sortWithOptions(0, usingComparator: { (a: id!, b: id!) -> NSComparisonResult in // TODo: check if this is the right order
			if isOrderedBefore(a,b) {
				return .NSOrderedAscending
			} else {
				return .NSOrderedDescending
			}
		})
		#endif
	}

	public func sorted(isOrderedBefore: (T, T) -> Bool) -> Array<T> { // [T] {
		#if COOPER
		//todo
		#elseif ECHOES
		//69820: Silver: can't call Sort() with block, on Echoes
		let result: List<T> = Array<T>(items: self)
		result.Sort({ (a: T, b: T) -> Boolean in // ToDo: check if this is the right order
			if isOrderedBefore(a,b) {
				return 1
			} else {
				return -1
			}
		})
		return result
		#elseif NOUGAT
		__mapped.sortedArrayWithOptions(0, usingComparator: { (a: id!, b: id!) -> NSComparisonResult in // TODo: check if this is the right order
			if isOrderedBefore(a,b) {
				return .NSOrderedAscending
			} else {
				return .NSOrderedDescending
			}
		})
		#endif
	}

	/// Return an Array containing the results of calling
	/// `transform(x)` on each element `x` of `self`
	public func map<U>(transform: (T) -> U) -> Array<U> { // [U] {
	}

	// consider nt implementing this,coz we have LINQ Reverse already
	public func reverse() -> Array<T> { // [T] {
		#if COOPER
		//var result = Array(items: self)  
		//TODO Collections.reverse(result);
		#elseif ECHOES
		return __mapped.Reverse().ToList()
		#elseif NOUGAT
		return Array(sequence: __mapped.Reverse())
		#endif
	}

	/// Return an Array containing the elements `x` of `self` for which
	/// `includeElement(x)` is `true`
	public func filter(includeElement: (T) -> Bool) -> Array<T> { // [T] {
		return Array(sequence: self.Where(includeElement))
	}

	/// Construct a Array of `count` elements, each initialized to
	/// `repeatedValue`.
	
	/// Call body(p), where p is a pointer to the Array's contiguous storage
	/*func withUnsafeBufferPointer<R>(body: (UnsafeBufferPointer<T>) -> R) -> R {
	}
	
	mutating func withUnsafeMutableBufferPointer<R>(body: (inout UnsafeMutableBufferPointer<T>) -> R) -> R {
	}

	/// This function "seeds" the ArrayLiteralConvertible protocol
	static func convertFromHeapArray(base: Builtin.RawPointer, owner: Builtin.NativeObject, count: Builtin.Word) -> Array<T> { // [T] {
	}*/

	/*mutating func replaceRange<C : CollectionType where T == T>(subRange: Range<Int>, with newValues: C) {
	}
	mutating func splice<S : CollectionType where T == T>(s: S, atIndex i: Int) {
	}*/
	mutating func removeRange(subRange: Range<Int>) {
	}

	#if NOUGAT
	init(_fromCocoaArray source: _CocoaArrayType, noCopy: Bool = false/*default*/) {
	}
	#endif
	
}