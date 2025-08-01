def variable_sliding_window(arr, max)
  i = 0
  sum = 0
  best = 0

  arr.each_with_index do |val, j|
    sum += val

    while sum > max && i <= j
      sum -= arr[i]
      i += 1
    end

    best = [best, j - i + 1].max if sum == max
  end
  best
end
