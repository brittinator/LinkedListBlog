class Comment < ActiveRecord::Base

  def next
    # instance method, so you'll be calling this on a particular comment instance
    # gets next comment from current comment and returns it
    Comment.find_by(id: next_id)
  end

  def append(comment) # recursive
    # places comment at the end of the list
    if self.next.nil?
      self.update!(next_id: comment.id)
    else
      self.next.append(comment) # recursion
    end
  end

  def remove(id)
    return if self.next.nil?
    # edge case - if want to delete the 1st comment
    # 1 - 4 - 6(rmv) - 10
    if self.next.id == id
      # self is 4
      self.update!(next_id: self.next.next_id)
      # currently 6 = now becomes 10
    else
      self.next.remove(id)
    end
  end

  def to_ary # regular recursive
    # want as a list, this is called a traversal
    if self.next.nil?
      [self] # base case
    else
      [self] + self.next.to_ary
      # + is concatenation so [4] + [6] will be [4, 6]
    end
  end
end

# Don't modify this
require "#{Rails.root}/lib/extensions/active_record/relation/explicit_addressing"
::ActiveRecord::Relation::ActiveRecord_Relation_Comment.send(:include,
    Extensions::ActiveRecord::Relation::ExplicitAddressing)
