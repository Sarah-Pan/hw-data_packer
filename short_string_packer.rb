# frozen_string_literal: true

# Packs/Unpacks a String to and from an Integer
module ShortStringPacker
  ## Packs a short string into a Integer
  # Arguments:
  #   str - String object
  # Returns: a Integer object
  def self.pack(str)
    packed = 0
    str.chars.each do |char|
      v = char.ord - 'a'.ord + 1
      packed = packed << 5 | v
    end
    packed
  end

  ## Unpacks a Integer from pack() method into a short string
  # Arguments:
  #   packed - a Integer object
  # Returns: a String object
  def self.unpack(packed)
    return '' if packed.zero?

    # Calculate the number of iterations
    iterations = (packed.bit_length + 4) / 5
    # Use each_with_index for controlled iteration
    (0...iterations).each_with_index.inject('') do |ori_str, (_, _index)|
      v = packed & 31
      char = ('a'.ord + v - 1).chr
      char + ori_str.tap { packed >>= 5 }
    end
  end
end
