def fixed_sliding_window(arr, k)
  current_sum = 0
  (0...k).each do |i|
    current_sum += arr[i]
  end

  max = current_sum

  (k...arr.size).each do |i|
    current_sum += arr[i] - arr[i - k]
    max = [current_sum, max].max
  end
  max
end
