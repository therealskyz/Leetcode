from collections import defaultdict
from typing import List


# 1. Two Sum
def twoSum(self, nums: List[int], target: int) -> List[int]:
    prevMap = {}

    for i, v in enumerate(nums):
        diff = target - v
        if diff in prevMap:
            return [prevMap[diff], i]
        else:
            prevMap[v] = i


# 20. Valid Parentheses
def isValid(self, s: str) -> bool:
    stack = []
    p = {')': '(', ']': '[', '}': '{'}

    for c in s:
        if c not in p:
            stack.append(c)
        else:
            if stack and stack[-1] == p[c]:
                stack.pop()
            else:
                return False

    if not stack:
        return True
    else:
        return False


# 36. Valid Sudoku
def isValidSudoku(self, board: List[List[str]]) -> bool:
    rows = defaultdict(set)
    cols = defaultdict(set)
    square = defaultdict(set)

    for r in range(9):
        for c in range(9):
            if board[r][c] == '.':
                continue

            if board[r][c] in rows[r] or board[r][c] in cols[c] or board[r][c] in square[(r // 3, c // 3)]:
                return False
            else:
                rows[r].add(board[r][c])
                cols[c].add(board[r][c])
                square[(r // 3, c // 3)].add(board[r][c])

    return True


# 49. Group Anagrams
def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
    res = defaultdict(list)

    for s in strs:
        count = [0] * 26
        for c in s:
            count[ord(c) - ord('a')] += 1
        res[tuple(count)].append(s)

    return res.values()

# 121. Best Time to Buy and Sell Stock
def maxProfit(self, prices: List[int]) -> int:
        l = 0
        r = 1
        maxP = 0

        for i in range(1, len(prices)):
            if prices[l] < prices[r]:
                profit = prices[r] - prices[l]
                maxP = max(profit, maxP)
            else:
                l = r
            r += 1

        return maxP

# 128. Longest Consecutive Sequence
def longestConsecutive(self, nums: List[int]) -> int:
        numSet = set(nums)
        longest = 0

        for i in numSet:
            if (i - 1) not in numSet:
                length = 1
                while (i + length) in numSet:
                    length += 1
                longest = max(longest, length)
        
        return longest
        
# 217. Contains Duplicate
def containsDuplicate(self, nums: List[int]) -> bool:
        numSet = set()

        for i in nums:
            if i in numSet:
                return True
            else:
                numSet.add(i)
        
        return False

# 238. Product of Array Except Self
def productExceptSelf(self, nums: List[int]) -> List[int]:
        res = [0] * len(nums)

        prefix = 1
        for i in range(len(nums)):
            res[i] = prefix
            prefix *= nums[i]
        
        suffix = 1
        for i in range(len(nums) - 1, -1, -1):
            res[i] *= suffix
            suffix *= nums[i]
        
        return res
        
# 242. Valid Anagram
def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False

        countS, countT = {}, {}

        for i in s:
            countS[i] = 1 + countS.get(i, 0)
        
        for i in t:
            countT[i] = 1 + countT.get(i, 0)
        
        for c in countS:
            if countS[c] != countT.get(c, 0):
                return False
        
        return True
        
# 271. Encode and Decode Strings
def encode(self, strs: List[str]) -> str:
        """Encodes a list of strings to a single string.
        """
        res = ""
        for s in strs:
            res += str(len(s)) + '#' + s
        return res

def decode(self, s: str) -> List[str]:
    """Decodes a single string to a list of strings.
    """
    res = []
    i = 0

    while i < len(s):
        j = i
        while s[j] != '#':
            j += 1
        length = int(s[i:j])
        res.append(s[j + 1 : j + 1 + length])
        i = j + 1 + length
    return res

# 347. Top K Frequent Elements
def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        count = {}
        freq = [[] for i in range(len(nums) + 1)]

        for i in nums:
            count[i] = 1 + count.get(i, 0)

        for i, v in count.items():
            freq[v].append(i)
        
        res = []
        for i in range(len(freq) - 1, 0, -1):
            for n in freq[i]:
                res.append(n)
                if len(res) == k:
                    return res