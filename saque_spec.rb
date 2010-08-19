class Cash
  MONEY = {
            '1' => 10, '2' => 10, '5' => 10,
            '10' => 5, '20' => 5, '50' => 5,
            '100' => 3
          }

  def self.saque(valor)
    if valor == 1
      MONEY[valor.to_s] = MONEY[valor.to_s] - 1
      [1]
    else
      MONEY['10'] = MONEY['10'] - 1
      resto = valor % 10
      MONEY[resto.to_s] = MONEY[resto.to_s] - 1
      [10, resto]
    end
  end
end

describe Cash do
  it "deveria sacar uma nota R$1 quando solicitado R$1" do
    Cash.saque(1).should == [1]
  end

  it "deveria sacar uma nota R$1 e uma de R$10 quando solicitado R$11" do
    Cash.saque(11).should == [10,1]
  end
  
  it "deveria sacar uma nota R$2 e uma de R$10 quando solicitado R$12" do
    Cash.saque(12).should == [10,2]
  end
end
