module Enumerable
  def index_and_group_by
    inject ActiveSupport::OrderedHash.new do |grouped, element|
      index, element = yield(element)
      (grouped[index] ||= []) << element
      grouped
    end
  end
end
