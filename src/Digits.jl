module Digits

export
  reversedigits,
  reversedigits!,
  undigit,
  digithist,
  isanagram,
  ispalindrome,
  contains,
  startswith,
  endswith,
  crop,
  combine,
  crosssum,
  select,
  replace,
  replace!,
  digitroot


function undigit(l::Array{Int,1})
  return foldr((a,b)->b*10+a,0,l)
end

undigit(n::Int) = n

reversedigits(n::Int) = undigit(reverse!(digits(n)))

reversedigits(l::Array{Int,1}) = reverse(l)

reversedigits!(l::Array{Int,1}) = reverse!(l)

function digithist(l::Array{Int,1})
  return hist(l,-0.5:10)[2]
end

digithist(n::Int) = digithist(digits(n))

function isanagram(a::Array{Int,1}, b::Array{Int,1})
  if length(a) == length(b)
    return digithist(a) == digithist(b)
  end
  return false
end

isanagram(a::Int, b::Int) = isanagram(digits(a),digits(b))


function ispalindrome(l::Array{Int,1})
  m = div(length(l),2)
  for i = 1:m
    if l[i] != l[end-i+1]
      return false
    end
  end
  return true
end

ispalindrome(n::Int) = ispalindrome(digits(n))

function contains(a::Array{Int,1},b::Array{Int,1})
  la = length(a)
  lb = length(b)
  if la > lb
    for i = 1:la-lb+1
      if a[i:i+lb-1] == b
        return true
      end
    end
  elseif lb > la
    for i = 1:lb-la+1
      if b[i:i+la-1] == a
        return true
      end
    end
  elseif a == b
    return true
  end
  return false
end

contains(a::Array{Int,1},b::Int) = contains(a,digits(b))
contains(a::Int,b::Array{Int,1}) = contains(digits(a),b)
contains(a::Int,b::Int) = contains(digits(a),digits(b))

function endswith(a::Array{Int,1},b::Array{Int,1})
  if a == b
    return true
  end
  la = length(a)
  lb = length(b)
  if la > lb
    if a[1:lb] == b
      return true
    end
  else
    if b[1:la] == a
      return true
    end
  end
  return false
end

endswith(a::Array{Int,1},b::Int) = endswith(a,digits(b))
endswith(a::Int,b::Array{Int,1}) = endswith(digits(a),b)
endswith(a::Int,b::Int) = endswith(digits(a),digits(b))

function startswith(a::Array{Int,1},b::Array{Int,1})
  if a == b
    return true
  end
  la = length(a)
  lb = length(b)
  if la > lb
    if a[end-lb+1:end] == b
      return true
    end
  else
    if b[end-la+1:end] == a
      return true
    end
  end
  return false
end

startswith(a::Array{Int,1},b::Int) = startswith(a,digits(b))
startswith(a::Int,b::Array{Int,1}) = startswith(digits(a),b)
startswith(a::Int,b::Int) = startswith(digits(a),digits(b))

function crop(l::Array{Int,1},i::Int)
  if abs(i) > length(l)
    error("Crop value too big!")
  elseif abs(i) == length(l)
    return [0]
  elseif i == 0
    return l
  elseif i > 0
    return l[1:end-i]
  else i < 0
    return l[1+abs(i):end]
  end
end

crop(n::Int,i::Int) = undigit(crop(digits(n),i))

function replace!(l::Array{Int,1},idx::AbstractArray{Int,1},d::Array{Int,1})
  l[idx] = d
  return l
end

function replace!(l::Array{Int,1},old::Int,new::Int)
  l[l.==old] = new
  return l
end

replace(l::Array{Int,1},idx::AbstractArray{Int,1},d::Array{Int,1}) = replace!(deepcopy(l),idx,d)
replace(l::Array{Int,1},old::Int,new::Int) = replace!(deepcopy(l),old,new)

function replace(n::Int,idx::AbstractArray{Int,1},d::Array{Int,1})
  return undigit(reverse(replace(reverse(digits(n)),idx,d)))
end

function replace(n::Int,old::Int,new::Int)
  return undigit(replace(digits(n),old,new));
end

function select(l::Array{Int,1},idx::AbstractArray{Int,1})
  return l[idx]
end

function select(n::Int,idx::AbstractArray{Int,1})
  return undigit(reverse(reverse(digits(n))[idx]))
end

function combine(a::Int,b::Int)
  if a == 0
    return b
  end
  f = 10^ndigits(b)
  return a*f+b
end

combine(a::Array{Int,1},b::Array{Int,1}) = [b,a]

crosssum(l::Array{Int,1}) = sum(l)
crosssum(n::Int) = sum(digits(n))

function digitroot(n::Int)
  x = abs(n)
  r = x-9*div(x-1,9)
  return copysign(r,n)
end

digitroot(l::Array{Int,1}) = digitroot(undigit(l))


end # module
