require "test/unit"

class TestTestFixnum < Test::Unit::TestCase
  
  def test_create_fixnum
    f=123
    assert_equal(Fixnum, f.class)
  end
  
  def test_fixnum_is_not_a_float
    f=123.0
    assert_not_equal(Fixnum, f.class)
    assert_equal(Float, f.class)
  end
  
  def test_too_big_to_be_a_fixnum
    n=10**19 #exponent artithmetic operator, i.e. 10 to the power of...
    assert_not_equal(Fixnum, n.class)
    assert_equal(Bignum, n.class)
  end
  
  def test_raise_to_the_power_of_an_exponent
    assert 10**2 == 100
    assert 2.5**2 == 6.25
    assert -4**3 == -64    
  end
  
end