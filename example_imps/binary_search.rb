def binary_search(arr, target)
  search(arr, target, 0, arr.length - 1)
end

def search(arr, target, left, right)
  return nil if left > right

  mid = left + (right - left) / 2
  return mid if target == arr[mid]

  if target > arr[mid]
    search(arr, target, mid + 1, right)
  else
    search(arr, target, left, mid - 1)
  end
end
