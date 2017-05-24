//: Playground - noun: a place where people can play

import UIKit



/**
 ## Add Two Numbers
 * Primary idea: use carry and iterate through both linked lists
 * Time Complexity: O(n), Space Complexity: O(1)
 *
 * Definition for singly-linked list.
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


func addTwoNumbers(l1: ListNode?, l2: ListNode?) -> ListNode? {
    
    var sum = 0, carry = 0
    
    let dummyHead = ListNode(0)
    var node = dummyHead
    var l1 = l1
    var l2 = l2
    
    while l1 != nil || l2 != nil || carry != 0 {
        sum = carry
        
        if l1 != nil {
            sum += l1!.val
            l1 = l1!.next
        }
        
        if l2 != nil {
            sum += l2!.val
            l2 = l2!.next
        }
        
        carry = sum / 10
        sum = sum % 10
        
        node.next = ListNode(sum)
        node = node.next!
    }
    
    return dummyHead.next
}


/*:
 ## Reverse Linked List
 Reverse a singly linked list.
 */

func reverseList(_ head: ListNode?) -> ListNode? {
    
    if head == nil || head?.next == nil {
        return head
    }
    
    var head = head
    let dummyhead = ListNode(0)
    
    while head != nil {
        
        let next = head!.next
        
        head!.next = dummyhead.next
        dummyhead.next = head
        
        head = next
    }
    
    
    return dummyhead.next
}

/*:
 ## Merge Two Sorted Lists
 Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.
 
*/

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    
    let dummyHead = ListNode(0)
    var p = dummyHead
    
    var l1 = l1
    var l2 = l2
    
    while l1 != nil && l2 != nil {
        
        if l1!.val > l2!.val {
            p.next = l2!
            l2 = l2!.next
        } else {
            p.next = l1!
            l1 = l1!.next
        }
        
        p = p.next!
    }
    
    p.next = l1 ?? l2
    
    return dummyHead.next
}

/*:
 ## Merge k Sorted Lists
 
 Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.
 
 Idea: Divide and conquer
 The idea is to pair up K lists and merge each pair in linear time using O(1) space. After first cycle, K/2 lists are left each of size 2*N. After second cycle, K/4 lists are left each of size 4*N and so on. We repeat the procedure until we have only one list left.
 
 */

func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    
    guard lists.count > 0 else {
        return nil
    }
    
    var left = 0
    var right = lists.count - 1
    
    var lists = lists
    
    while right > 0 {
        left = 0
        while left < right {
            lists[left] = mergeTwoLists(lists[left], lists[right])
            left += 1
            right -= 1
        }
    }
    
    return lists[0]
}

/*:
 ## Odd Even Linked List
 Given a singly linked list, group all odd nodes together followed by the even nodes. Please note here we are talking about the node number and not the value in the nodes.
 
 You should try to do it in place. The program should run in O(1) space complexity and O(nodes) time complexity.
 
 Example:
 Given 1->2->3->4->5->NULL,
 return 1->3->5->2->4->NULL.
 
 Note:
 The relative order inside both the even and odd groups should remain as it was in the input.
 The first node is considered odd, the second node even and so on ...
 
 Idea: use a node to store the odd head and a node to store the even head. Iterate the linked list, link the odd node to the odd head, link the even node to even head. Finaly, link the even head to the odd tail.
 */

func oddEvenList(_ head: ListNode?) -> ListNode? {
    
    if head == nil || head!.next == nil || head!.next!.next == nil {
        return head
    }
    
    var odd = head
    let evenHead = head!.next
    var even = head!.next
    
    while even != nil && even!.next != nil {
        odd!.next = odd!.next!.next
        even!.next = even!.next!.next
        
        odd = odd!.next
        even = even!.next
    }
    odd!.next = evenHead
    
    return head;
}

/*:
 ## Palindrome Linked List
 Given a singly linked list, determine if it is a palindrome.
 
 Follow up:
 Could you do it in O(n) time and O(1) space?

 Idea: Revise the right half of the list, the campare the left part and right part.
 */

func isPalindrome(_ head: ListNode?) -> Bool {
    
    if head == nil || head!.next == nil {
        return true
    }
    
    var slow = head, fast = head
    
    while fast != nil && fast!.next != nil {
        slow = slow!.next
        fast = fast!.next!.next
    }
    
    var revisedRight = reverseList(slow)
    
    slow = head
    
    while revisedRight != nil && slow != nil {
        if revisedRight!.val != slow!.val {
            return false
        }
        revisedRight = revisedRight!.next
        slow = slow!.next
    }
    
    return true
}

