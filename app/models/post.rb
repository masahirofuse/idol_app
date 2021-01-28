class Post < ApplicationRecord
  validates :content, {presence:true, length:{maximum:140}}

  
  NGWORD = %w(クソ キモい)
  NGWORD_REGEX = %r(#{NGWORD.join('|')})
  validates :content, format:{without: NGWORD_REGEX}
  
  
end
