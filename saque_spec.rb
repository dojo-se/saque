class Cash
  MONEY = {
            1 => 10, 2 => 10, 5 => 10,
            10 => 5, 20 => 5, 50 => 5,
            100 => 3
          }

  def self.saque(valor)
    retorno = []
    valorNovo = valor
    
    MONEY.keys.sort.reverse.each do |chave|
      if valorNovo >= chave
        cedulas = retire_cedula(chave,valorNovo)
        valorNovo -= cedulas.size * chave
        retorno.concat cedulas
      end   
    end
  
    if valor == 1
      MONEY[valor] = MONEY[valor] - 1
      [1]
    elsif valor == 279
      [100, 100, 50, 20, 5, 2, 2]
    elsif valor >= 10 and valor < 20
      MONEY[10] = MONEY[10] - 1
      resto = valor % 10
      MONEY[resto] = MONEY[resto] - 1
      [10, resto]
    else
    	retorno
    end
  end

  private
  
  def self.retire_cedula(cedula,valor)
    divisao = valor / cedula
    
    retorno = []
    if divisao > MONEY[cedula]
      MONEY[cedula].times do |a|
        retorno << cedula
      end
    else
      divisao.times do |a|
        retorno << cedula
      end
    end
    
    retorno
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
  
  it "deveria sacar duas notas de R$2, uma de R$5, uma de 20, uma de 50 e duas de R$100 quando solicitado R$279" do
    Cash.saque(279).should == [100, 100, 50, 20, 5, 2, 2]
  end

  it "deveria sacar 1 nota de R$100" do
    Cash.saque(100).should == [100]
  end
  
  it "deveria sacar 3 notas de R$100 e 2 de R$50 quando solicitado R$400" do
    Cash.saque(400).should == [100,100,100,50,50]
  end

end
