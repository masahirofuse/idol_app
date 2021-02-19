class Post < ApplicationRecord
  validates :content, {presence:true, length:{maximum:140}}
  belongs_to :user
  
  NGWORD = %w(クソ キモい)
  NGWORD_REGEX = %r(#{NGWORD.join('|')})
  validates :content, format:{without: NGWORD_REGEX}
  
  
end
