#!/usr/bin/env Rscript
# http://rosettacode.org/wiki/Sorting_algorithms/Merge_sort#R

# In computer science, merge sort (also commonly spelled mergesort)
# is an efficient, general-purpose, comparison-based sorting algorithm.
# Most implementations produce a stable sort, which means that the
# implementation preserves the input order of equal elements in the sorted output.
# Mergesort is a divide and conquer algorithm that was invented by John von Neumann in 1945.[1]
# A detailed description and analysis of bottom-up mergesort
# appeared in a report by Goldstine and Neumann as early as 1948.[2]


mergesort <- function(m) {
   merge_ <- function(left, right)
   # Recursive function to compare and append values in order
   {
      # Create a list to hold the results
      result <- c()
      # This is our stop condition. While left and right contain
      # a value, compare them
      while(length(left) > 0 && length(right) > 0)
      {
           # If left is less than or equal to right,
           # add it to the result list
         if(left[1] <= right[1])
         {
            result <- c(result, left[1])
            # Remove the value from the list
            left <- left[-1]
         } else
         {
            # When right is less than or equal to left,
            # add it to the result.
            result <- c(result, right[1])
            # Remove the appended integer from the list.
            right <- right[-1]
         }
      }
      # Keep appending the values to the result while left and right
      # exist.
      if(length(left) > 0) result <- c(result, left)
      if(length(right) > 0) result <- c(result, right)
      result
   }

   # Below is our stop condition for the mergesort function.
   # When the length of the vector is 1, just return the integer.
   len <- length(m)
   if(len <= 1) m else
   {
      # Otherwise keep dividing the vector into two halves.
      middle <- length(m) / 2
      # Add every integer from 1 to the middle to the left
      left <- m[1:floor(middle)]
      right <- m[floor(middle+1):len]
      # Recursively call mergesort() on the left and right halves.
      left <- mergesort(left)
      right <- mergesort(right)
      # Order and combine the results.
      if(left[length(left)] <= right[1])
      {
         c(left, right)
      } else
      {
         merge_(left, right)
      }
   }
}
