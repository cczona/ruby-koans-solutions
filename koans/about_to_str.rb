require File.expand_path(File.dirname(__FILE__) + '/edgecase')

## Overview adapted by CCZ from: http://groups.google.com/group/ruby-talk-google/msg/e8de3fcc137f3027 and Grant Hutchin's reply to http://briancarper.net/blog/98/ and other ssources
# [to_i, to_s, to_a] are conversion methods. They are used when one wants a *representation* of an object as an integer, string, etc.
# [to_int, to_str, to_ary, to_hash] are duck-typing methods. They indicate that an object is Integer-like or String-like, etc.
# By supplying to_str, an object would be agreeing to be used when a String would normally be, and react like a String in string contexts. 
# to_int, to_str, etc is an object's contract to behave like an Integer, String, etc in corresponding contexts; and agreement that an exception will be thrown if it fails to behave like one. 

class AboutToStr < EdgeCase::Koan

  class CanNotBeTreatedAsString
    def to_s
      "non-string-like"
    end
  end

  def test_to_s_returns_a_string_representation
    not_like_a_string = CanNotBeTreatedAsString.new
    assert_equal 'non-string-like', not_like_a_string.to_s
  end

  def test_normally_objects_cannot_be_used_where_strings_are_expected
    assert_raise(TypeError) do
      File.exist?(CanNotBeTreatedAsString.new)
    end
  end

  # ------------------------------------------------------------------

  class CanBeTreatedAsString
    def to_s
      "string-like"
    end

    def to_str
      to_s
    end
  end

  def test_to_str_also_returns_a_string_representation
    like_a_string = CanBeTreatedAsString.new
    assert_equal 'string-like', like_a_string.to_str
  end

  def test_to_str_allows_objects_to_be_treated_as_strings
    assert_equal false, File.exist?(CanBeTreatedAsString.new)
  end

  # ------------------------------------------------------------------

  def acts_like_a_string?(string)
    string = string.to_str if string.respond_to?(:to_str)
    string.is_a?(String)
  end

  def test_user_defined_code_can_check_for_to_str
    assert_equal false, acts_like_a_string?(CanNotBeTreatedAsString.new)
    assert_equal true,  acts_like_a_string?(CanBeTreatedAsString.new)
  end
end
