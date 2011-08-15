require "test/unit"

class TestStrings < Test::Unit::TestCase
  
  def test_length
    s="Hello, world"
    assert_equal(12, s.length)
  end
  
  def test_expression_substitution
    assert_equal('Hello! Hello! Hello! ', "#{'Hello! ' *3}")
  end
  
  def test_trimming
    assert_equal("Hello! Hello! Hello!", "#{'Hello! ' *3}".strip)
    assert_equal("Hello!Hello!Hello!", "#{('Hello! '.strip) *3}")
  end
  
  def test_trimming_with_reporting
    a='foo '.strip!
    b=' and '.strip!
    c='/ boo / //'.strip!
    assert_equal(['foo', 'and', nil], [a, b, c])  
  end
  
  def test_index_for_invalid_argument
    assert_equal(nil, 'actual'.index('z'))
  end
   
end