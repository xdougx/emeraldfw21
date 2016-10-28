require "spec_helper"

describe EmeraldFW::Entity do 

  context 'Methods' do

  	it 'has a method initialize' do
  	  expect(EmeraldFW::Entity.respond_to?(:initialize)).to be true
  	end

  end

end