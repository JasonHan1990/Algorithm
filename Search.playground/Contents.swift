//: Playground - noun: a place where people can play

import UIKit

/*:
 ## Median of Two Sorted Arrays
 
 There are two sorted arrays A and B of size m and n respectively. Find the median of the
 two sorted arrays. The overall run time complexity should be O(log (m+n)).
 
 Tips: Use binary search. Search kth number in A and B, k is (m + n) / 2.
 
 First, we need make A be the shorter array. Because later we want to remove the correct portion.
 Then, we compare the medians of A and B, if medianA < medianB, we remove all items smaller than
 medianA, and continue next comparison. If medianA > medianB, we remove all items smaller then medianB,
 and continue next comparision. Until, one array is empty or k = 1.
 If one array is empty, return the first item of the other array. If k = 1, return the smaller one of the 
 first items.
 */

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    
    let m = nums1.count
    let n = nums2.count
    
    return (findKth(nums1, nums2, (m + n + 1)/2 ) + findKth(nums1, nums2, (m + n + 2)/2 )) / 2.0

}

func findKth(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> Double {

    let m = nums1.count, n = nums2.count
    
    // compare length
    if m > n {
        return findKth(nums2, nums1, k)
    }
    
    // is shorter array empty
    if m == 0 {
        return Double(nums2[k - 1])
    }
    
    // is k == 1
    if k == 1 {
        return Double(min(nums1[k - 1], nums2[k - 1]))
    }
    
    // campare
    let i = min(k / 2, m)
    let j = min(k / 2, n)
    
    if nums1[i - 1] < nums2[j - 1] {
        return findKth(Array(nums1[i...m - 1]), nums2, k - i)
    } else {
        return findKth(nums1, Array(nums2[j...n - 1]), k - j)
    }
}


//findMedianSortedArrays([1, 9, 12, 15, 26, 38], [2, 13, 17, 30, 45, 55, 56, 57, 78])


/*:
 ##Search Insert Position
 Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order. You may assume no duplicates in the array.
 Here are few examples.
 [1,3,5,6], 5 -> 2
 [1,3,5,6], 2 -> 1
 [1,3,5,6], 7 -> 4
 [1,3,5,6], 0 -> 0
 
 Idea: binary search. log(n)
 brute force. O(n)
 */

func searchInsertPosition(_ nums: [Int], _ target: Int) -> Int {
    
    if nums.count == 0 {
        return 0
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        let mid = (i + j) / 2
        
        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            i = mid + 1
        } else {
            j = mid - 1
        }
    }
    
    return i
}

//searchInsertPosition([1,3,5,6], 0)

/*:
 ##Find Minimum in Rotated Sorted Array
 Suppose a sorted array is rotated at some pivot unknown to you beforehand. (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
 Find the minimum element.You may assume no duplicate exists in the array.
 */

func findMinInRotatedSortedArray(_ nums:[Int]) -> Int {
    
    if nums.count == 0 {
        return -1
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        // no rotate or only one item
        if nums[i] <= nums[j] {
            return nums[i]
        }
        
        let mid = (i + j) / 2
        
        // compare to the left one
        if nums[i] > nums[mid] {
            // if nums[i] > nums[mid], nums[mid] could be the smallest one. So we should include mid 
            // in the next checking
            j = mid
        } else {
            // because the most left one is relatively the min one, if nums[mid] > nums[i]
            // nums[mid] is totally not the smallest one. So, we should start from mid + 1
            i = mid + 1
        }
    }
    
    return -1
}

//findMinInRotatedSortedArray([6,7,1,2,3,4])


/*:
 ##Find Minimum in Rotated Sorted Array II
 Follow up for "Find Minimum in Rotated Sorted Array": What if duplicates are allowed?
 
 The new case is the most left one == the most right one [3, 1, 3]
 Remove either one
 */

func findMinInRotatedSortedArrayII(_ nums:[Int]) -> Int {
    
    if nums.count == 0 {
        return -1
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        while nums[i] == nums[j] && abs(i - j) > 1 {
            i += 1
        }
        
        if nums[i] <= nums[j] {
            return nums[i]
        }
        
        let mid = (i + j) / 2
        
        
        if nums[i] > nums[mid] {
            j = mid
        } else {
            i = mid + 1
        }
    }
    
    return -1
}

//findMinInRotatedSortedArrayII([6,7,1,2,3,4,6,6,6])


/*:
 ##Search for a Range
 Given a sorted array of integers, find the starting and ending position of a given target value. Your algorithm’s runtime complexity must be in the order of O(log n). If the target is not found in the array, return [-1, -1]. For example, given [5, 7, 7, 8, 8, 10] and target value 8, return [3, 4].
 
 Use binary search to get the left index and then the right index
 */

func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    
    var res = [-1, -1]
    
    if nums.count == 0 {
        return res
    }
    
    // find left
    res[0] = findIndex(nums, target, true)
    // find right
    res[1] = findIndex(nums, target, false)
    
    return res
}

func findIndex(_ nums: [Int], _ target: Int, _ isLeft: Bool) -> Int {
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        let mid = (i + j) / 2
        
        if nums[mid] == target {
            // for [1] case
            if i == j {
                return i
            }
            
            if isLeft {
                j = mid
            } else {
                if i + 1 == j {
                    if nums[i] == nums[j] {
                        return j
                    } else {
                        return i
                    }
                }
                i = mid
            }
        } else if nums[mid] > target {
            j = mid - 1
        } else {
            i = mid + 1
        }
    }
    
    return -1
}

//searchRange([1], 1)


/*: 
 ## Search in Rotated Sorted Array
 Suppose a sorted array is rotated at some pivot unknown to you beforehand. (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
 You are given a target value to search. If found in the array return its index, other- wise return -1. You may assume no duplicate exists in the array.
 
 Idea: Understand rotared array: 
 The regular array: [0 1 2 4 5 6 7]
 There are three cases when rotate the array
 Case 1: [6 7 0 1 2 4 5], the mid is 1, 1 < 6, nums[left...mid - 1] is not sorted, nums[mid + 1...right] is sorted
 Case 2: [2 4 5 6 7 0 1], the mid is 6, 2 < 6, nums[left...mid - 1] is sorted, but nums[mid + 1...right] is not sorted
 Case 3: [5 6 7 0 1 2 4], the mid is 0, nums[left...mid - 1] and nums[mid + 1...right] are both sorted.
 
 So, there is always one part of the array is sorted. So we can check whether target is in the part which is sorted, otherwise the target is the another part which could be sorted or not.
 
 The case:
 
 if nums[mid] == target, return mid
 
 if nums[mid] > nums[left] (case 1, right part is always sorted)
    if nums[mid] < target <= nums[right] (in the right part)
        left = mid + 1
    else 
        right = mid - 1
 
 else (case 2, left part is always sorted)
    if nums[left] <= target < nums[mid] (in the left part)
        right = mid - 1
    else 
        left = mid + 1
 
 */

func searchInRotatedSortedArray(_ nums: [Int], _ target: Int) -> Int {
    
    if nums.count == 0 {
        return -1
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        let mid = (i + j) / 2
        
        if nums[mid] == target {
            return mid
        }
        
        if nums[mid] < nums[i] {
            
            if nums[mid] < target && nums[j] >= target {
                i = mid + 1
            } else {
                j = mid - 1
            }
        } else {
            
            if nums[mid] > target && nums[i] <= target {
                j = mid - 1
            } else {
                i = mid + 1
            }
        }
    }
    
    return -1
}

//searchInRotatedSortedArray([6,7,1,2,3,4,5], 4)

/*:
 ## Search in Rotated Sorted Array II
 Follow up for "Search in Rotated Sorted Array": what if duplicates are allowed? Write
 a function to determine if a given target is in the array.
 
 Compare to the last question. There is a new case: if nums[mid] == muns[left].
 
 example: [3 3 3 1 2 3]
          [3 3 3 3 1 2]
 
          [3 1 2 3 3 3 3]
          [3 3 3 3 1 2 3]
 when nums[mid] == muns[left], we can't the left and right part are both hard to said it is sorted. we need to skip the duplicate. 

 if nums[mid] == muns[left]
    left += 1
 
 worst case, [3 3 3 3 3 3], target = 1, the complex become O(n)
 */

func searchInRotatedSortedArrayII(_ nums: [Int], _ target: Int) -> Int {

    if nums.count == 0 {
        return -1
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        let mid = (i + j) / 2
        
        if nums[mid] == target {
            return mid
        }
        
        if nums[mid] < nums[i] {
            
            if nums[mid] < target && nums[j] >= target {
                i = mid + 1
            } else {
                j = mid - 1
            }
        } else if nums[mid] > nums[i] {
            
            if nums[mid] > target && nums[i] <= target {
                j = mid - 1
            } else {
                i = mid + 1
            }
        } else {
            i += 1
        }
    }
    
    return -1
}

searchInRotatedSortedArrayII([1,3,1,1,1], 3)







































