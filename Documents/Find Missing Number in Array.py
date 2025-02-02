# 1. Find the missing number in a given array

# Problem Statement: 
# Given an array of positive numbers ranging from 1 to n, 
# such that all numbers from 1 to n are present except one number x, find x. 
# Assume the input array is unsorted.

nums = [3, 7, 1, 2, 8, 4, 5]


from typing import List

class Solution:
    def findMissingNumber(self, nums: List[int]) -> int:
        n = len(nums) + 1  # Since one number is missing, the total count should be len(nums) + 1
        expected_sum = n * (n + 1) // 2  # Sum of numbers from 1 to n
        actual_sum = sum(nums)  # Sum of numbers present in the array
        missing_number = expected_sum - actual_sum  # The missing number is the difference
        return missing_number
