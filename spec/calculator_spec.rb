# Your code here
require 'calculator'
describe Calculator do
  let(:c){Calculator.new}
  let(:c_s){Calculator.new(true)}

  describe "#initialize" do
    it "should give you a Calculator" do
      expect(c).to be_a(Calculator)
    end
    it "should initialise memory as nil" do
      expect(c.instance_variable_get(:@memory)).to be_nil
    end
    it "stringify should return false by default" do
      expect(c.instance_variable_get(:@stringify)).to eq(false)
    end
    it "stringly should return true if init value set to true" do
      expect(c_s.instance_variable_get(:@stringify)).to eq(true)
    end
  end

  describe "#add" do
    it "adds positive nums" do
      expect(c.add(1,2)).to eq(3)
      expect(c.add(1.0, 2.0)).to eq(3.0)
    end
    it "adds negative nums" do
      expect(c.add(-34.34, -56.34)).to eq(-90.68)
      expect(c.add(-2, -4)).to be_within(0.1).of(-6)
    end
    it "adds positive and negative nums" do
      expect(c.add(-1, 4)).to eq(3)
      expect(c.add(-1.5, 4.5)).to eq(3.0)
    end
  end

  describe "#subtract" do
    it "subtracts positive and negative ints" do
      expect(c.subtract(1,2)).to eq(-1)
      expect(c.subtract(-100,-2)).to eq(-98)
      expect(c.subtract(-123,4)).to eq(-127)
    end
    it "subtracts positive and negative floats" do
      expect(c.subtract(-2,-4.2)).to eq(2.2)
      expect(c.subtract(2,-4.2)).to eq(6.2)
      expect(c.subtract(-2,4.2)).to eq(-6.2)
    end
  end

  describe "#multiply" do
    it "multiplies" do
      expect(c.multiply(-4,-2)).to eq(8)
      expect(c.multiply(-4.2, 2)).to eq(-8.4)
      expect(c.multiply(10, 10)).to eq(100)
    end
  end

  describe "#divide" do
    it "properly divides numbers" do
      expect(c.divide(8,2)).to eq(4)
      expect(c.divide(-8,2)).to eq(-4)
      expect(c.divide(-8.0,-2)).to eq(4.0)
    end
    it "returns float if there is remainder" do
      expect(c.divide(2,3)).to be_within(0.1).of(0.6)
      expect(c.divide(-6,7)).to be_within(0.1).of(-0.8)
    end
    it "raises ArgumentError when dividing by 0" do
      expect{c.divide(5,0)}.to raise_error(ArgumentError)
    end
  end

  describe "#pow" do
    it "handles powers" do
      expect(c.pow(3,3)).to eq(27.0)
      expect(c.pow(-3,3)).to eq(-27.0)
    end
    it "handles negative powers" do
      expect(c.pow(3, -3)).to be_within(0.01).of(0.03)
      expect(c.pow(-3,-3)).to be_within(0.01).of(-0.03)
    end
    it "handles decimal powers" do
      expect(c.pow(27,1/3.0)).to eq(3.0)
      expect(c.pow(27,-1/3.0)).to be_within(0.05).of(0.3)
    end
  end

  describe "#sqrt" do
    it "returns integers for round roots" do
      expect(c.sqrt(9)).to eq(3)
      expect(c.sqrt(81.0)).to eq(9)
    end
    it "raises ArgumentError for negative numbers" do
      expect{ c.sqrt(-4) }.to raise_error(ArgumentError)
    end
    it "returns 2-digit decimals for non-round roots" do
      expect(c.sqrt(27)).to eq(5.20)
      expect(c.sqrt(45.0)).to eq(6.71)
    end
  end

  context "@memory writer and reader" do
    before do
      c.memory = 'stored value'
    end
    describe "#memory=" do
      it "stores an object in memory" do
        expect(c.instance_variable_get(:@memory)).to eq('stored value')
      end
      it "overwrites previous object in memory" do
        c.memory = 45
        expect(c.instance_variable_get(:@memory)).to eq(45)
      end
    end

    describe "#memory" do
      it "returns the object in memory" do
        expect(c.memory).to eq('stored value')
      end
      it "clears memory when returned" do
        c.memory
        expect(c.memory).to be_nil
      end
    end
  end
end
