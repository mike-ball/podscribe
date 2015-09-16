require 'rspec/expectations'

describe FizzBuzz do
  before(:each) do 
    @fizz = FizzBuzz.new
  end

  describe "initialized in before(:each)" do
    it "should return nil for 0" do
      expect @fizz.check(0).to eq(nil)
    end

    it "should return blank for 1" do
      expect @fizz.check(1).to eq('')
    end

    it "should return Fizz for 3" do
      expect @fizz.check(3).to eq('Fizz')
    end

    it "should match this hash map" do
      map = { -1  => nil,
              0   => nil,
              1   => '',
              2   => 'Fizz',
              3   => '',
              4   => '',
              5   => 'Buzz',
              6   => 'Fizz'
            }
      map.each do |k, v|
        expect @fizz.check(k).to eq(v)
      end
    end
  end
end