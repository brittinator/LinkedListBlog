class Comment < ActiveRecord::Base

  def next
    # instance method, so you'll be calling this on a particular comment instance
    # gets next comment from current comment and returns it
    Comment.find_by(id: next_id)
  end

  def append(comment)
    # places comment at the end of the list
  end

  def remove(id)

  end

  def to_ary # regular recursive
    # want as a list, this is called a traversal
    if !self.next
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
